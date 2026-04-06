using System;
using System.Web.Services;
using System.Web.Script.Services;
using Newtonsoft.Json.Linq;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web;

public partial class Ar_SaveLocalStorage : System.Web.UI.Page
{
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object SaveLocalStorage(string cart, string action, int id = 0, string deliveryCost = null)
    {
        try
        {
            JArray items = string.IsNullOrEmpty(cart) ? new JArray() : JArray.Parse(cart);
            DataTable dt = ConvertJArrayToDataTable(items);

            // IDs من الكارت
            List<int> ids = new List<int>();
            foreach (DataRow row in dt.Rows)
            {
                int shopId;
                if (int.TryParse(row["shopId"].ToString(), out shopId))
                    ids.Add(shopId);
            }

            string connStr = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;

            // 1. الأماكن المتاحة الآن
            string sqlAvailable = @"
                  SELECT dbo.PlacesDeliverySchedule.PlacesId
FROM  dbo.PlacesDeliverySchedule INNER JOIN
               dbo.DaysOfWeek ON dbo.PlacesDeliverySchedule.DayId = dbo.DaysOfWeek.Id
WHERE (dbo.DaysOfWeek.Dayorder = DATEPART(WEEKDAY, DATEADD(HOUR, 10, GETDATE())) AND (dbo.PlacesDeliverySchedule.IsActive = 1) AND (CAST(DATEADD(HOUR, 10, GETDATE()) AS TIME) BETWEEN 
               dbo.PlacesDeliverySchedule.StartTime AND dbo.PlacesDeliverySchedule.EndTime))
        ";

            // 2. أسماء الأماكن كلها (ID + Name)
            string sqlNames = @"SELECT Id, Name FROM Places WHERE Id IN ({0})";

            // نحول IDs إلى CSV لاستعماله في SQL
            string idsCsv = string.Join(",", ids);
            sqlNames = string.Format(sqlNames, idsCsv);

            // جدول للأماكن المتاحة
            DataTable dtAvailable = new DataTable();
            // جدول لأسماء الأماكن
            DataTable dtNames = new DataTable();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // الأماكن المتاحة
                using (SqlCommand cmd = new SqlCommand(sqlAvailable, conn))
                using (SqlDataReader dr = cmd.ExecuteReader())
                    dtAvailable.Load(dr);

                // أسماء الأماكن
                using (SqlCommand cmd2 = new SqlCommand(sqlNames, conn))
                using (SqlDataReader dr2 = cmd2.ExecuteReader())
                    dtNames.Load(dr2);
            }

            // HashSet للمتاح
            HashSet<int> availableIds = new HashSet<int>();
            foreach (DataRow row in dtAvailable.Rows)
                availableIds.Add(Convert.ToInt32(row["PlacesId"]));

            // الأماكن غير المتاحة مع أسمائهم
            List<string> notAvailableNames = new List<string>();

            foreach (DataRow row in dtNames.Rows)
            {
                int pid = Convert.ToInt32(row["Id"]);
                if (!availableIds.Contains(pid))
                {
                    string name = row["Name"].ToString();
                    notAvailableNames.Add(name);
                }
            }

            // لو في مطاعم مش متاحة
            if (notAvailableNames.Count > 0)
            {
                string msg = (string)HttpContext.GetGlobalResourceObject("texts", "RestaurantnAvaliable") + string.Join(", ", notAvailableNames);

                return new
                {
                    success = false,
                    error = msg,
                    notAvailable = notAvailableNames
                };
            }

            // الحفظ
            SaveOrderAndDetails(dt, Convert.ToDecimal(deliveryCost));

            return new
            {
                success = true,
                updatedCart = items.ToString()
            };
        }
        catch (Exception ex)
        {
            return new
            {
                success = false,
                error = ex.Message
            };
        }
    }

    public static DataTable ConvertJArrayToDataTable(JArray items)
    {
        DataTable dt = new DataTable();

        if (items == null || items.Count == 0)
            return dt;

        // جلب الأعمدة تلقائياً من أول عنصر
        JObject first = (JObject)items[0];
        foreach (var prop in first.Properties())
        {
            dt.Columns.Add(prop.Name, typeof(string));
        }

        // تعبئة الصفوف
        foreach (JObject obj in items)
        {
            DataRow row = dt.NewRow();
            foreach (var prop in obj.Properties())
            {
                row[prop.Name] = prop.Value != null ? prop.Value.ToString() : "";
            }
            dt.Rows.Add(row);
        }

        return dt;
    }
    public static void SaveOrderAndDetails(DataTable dt, decimal deliveryCost)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            con.Open();

            SqlTransaction trans = con.BeginTransaction();

            try
            {
                int newOrderId = 0;

                // Insert Order
                using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Orders (Address_id, Odate, DeliveryCost, delivered)
                VALUES (@Address_id, GETDATE(), @DeliveryCost, 0);
                SELECT SCOPE_IDENTITY();
            ", con, trans))
                {
                    cmd.Parameters.AddWithValue("@Address_id", dt.Rows[0]["addid"]);
                    cmd.Parameters.AddWithValue("@DeliveryCost", deliveryCost);
                    newOrderId = Convert.ToInt32(cmd.ExecuteScalar());
                }

                // Insert Order Details
                foreach (DataRow row in dt.Rows)
                {
                    using (SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO Order_Details (Order_id, MenuItems_id, amount, price)
                    VALUES (@Order_id, @MenuItems_id, @amount, @price)
                ", con, trans))
                    {
                        cmd.Parameters.AddWithValue("@Order_id", newOrderId);
                        cmd.Parameters.AddWithValue("@MenuItems_id", row["id"]);
                        cmd.Parameters.AddWithValue("@amount", row["amount"]);
                        cmd.Parameters.AddWithValue("@price", row["price"]);

                        cmd.ExecuteNonQuery();
                    }
                }

                // لو كل شيء تمام
                trans.Commit();
            }
            catch(Exception ex)
            {
                // لو في Error
                trans.Rollback();
                throw;
            }
        }
    }
}
