using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DMS;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.HtmlControls;

public partial class Ar_Places : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            //LoadAddresses();
            if (Convert.ToInt32(Request.QueryString["addid"].ToString()) != 0)
            {
                BindRepeater();
                BindRepeaterC();
            }
            else
            {
                Response.Redirect("~/ar/Addresses.aspx");
            }
        }
    }
    public string GetActiveClass(string categoryId)
    {
        // جلب الـ ID المختار من رابط URL (Query String)
        string currentSelectedId = Request.QueryString["id"] ?? "1";

        // مقارنة ID العنصر بالـ ID المختار
        if (categoryId == currentSelectedId)
        {
            return " active";
        }
        return "";
    }
    
    private void BindRepeaterC()
    {
        Categories cat = new Categories();
        cat.LoadAll();
        CategoryRepeater.DataSource = cat.DefaultView.Table;
        CategoryRepeater.DataBind();
    }
    //void LoadAddresses()
    //{
    //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
    //    {
    //        string sql = @"
    //    SELECT 
    //        a.ID, 
    //        a.StreetName + '(' + g.Name + ',' + ar.Name + ' ) ' AS Name,
    //        a.Build + ' , ' + a.adepartmentNo + ' , ' + a.FloorNo AS Description
    //    FROM Addresses a
    //    INNER JOIN Areas ar ON a.Area_id = ar.id
    //    INNER JOIN Gov g ON ar.gov_id = g.id
    //    ORDER BY g.Name, ar.Name, a.StreetName";
    //        SqlCommand cmd = new SqlCommand(sql, con);
    //        con.Open();
    //        SqlDataReader dr = cmd.ExecuteReader();
    //        ddlAddresses.Items.Clear();
    //        while (dr.Read())
    //        {
    //            // Combine Name|Description for Select2
    //            ddlAddresses.Items.Add(new ListItem(dr["Name"] + "|" + dr["Description"], dr["ID"].ToString()));
    //        }
    //    }
    //}

    private void BindRepeater()
    {
        Categories cat = new Categories();
        cat.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString["id"].ToString()));


        var lang = System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName;

        ltname.Text = lang == "en" ? cat.NameEn :
                      lang == "ru" ? cat.NameRu :
                      cat.Name;
        Addresses add = new Addresses();
        add.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString["addid"].ToString()));
        Areas ara = new Areas();
        ara.LoadByPrimaryKey(add.Area_id);
        Gov gov = new Gov();
        gov.LoadByPrimaryKey(ara.Gov_id);

        ltlocation.Text = ltlocation2.Text=lang == "en" ? gov.NameEn + "-" + ara.NameEn:
                      lang == "ru" ? gov.NameRu + "-" + ara.NameRu :
                      gov.Name + "-" + ara.Name;

        

        using (SqlConnection con = new SqlConnection(connStr))
        {
            // SQL تحسب المسافة مباشرة
            string sql = @"
               SELECT p.id, p.Name, p.NameEn, p.NameRu, p.Address, p.Description, p.DescriptionEn,p.Description, p.DescriptionRu,(p.DeliveredTime+dbo.DeliveryZones.DeliveredTime) as DeliveredTime, p.MinOrder, p.Rate, p.PhotoPath, dbo.DeliveryZones.DeliveryCost
FROM  dbo.Places AS p INNER JOIN
               dbo.PlacesDeliverySchedule AS s ON p.id = s.PlacesId INNER JOIN
               dbo.DaysOfWeek AS d ON s.DayId = d.Id INNER JOIN
               dbo.DeliveryZones ON p.id = dbo.DeliveryZones.PlacesID INNER JOIN
               dbo.Addresses AS a ON dbo.DeliveryZones.Areas_id = a.Area_id INNER JOIN
               dbo.Categories ON p.Categories_id = dbo.Categories.id
WHERE (p.Active = 1) AND (s.IsActive = 1) AND (DATEPART(WEEKDAY, DATEADD(HOUR, 10, GETDATE())) = d.DayOrder) AND (CAST(DATEADD(HOUR, 10, GETDATE()) AS TIME) BETWEEN s.StartTime AND
                s.EndTime) AND (a.ID = @addr) AND (s.IsActive = 1) AND (dbo.Categories.id = @catg)";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@addr", Convert.ToInt32(Request.QueryString["addid"].ToString()));
            cmd.Parameters.AddWithValue("@catg", Convert.ToInt32(Request.QueryString["id"].ToString()));
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            rptplaces.DataSource = rdr;
            rptplaces.DataBind();
        }
    }
    protected void ddlAddresses_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindRepeater();
    }
    protected void rpt_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            // جِب الريت من الداتا
            int rating = 0;
            var dataObj = DataBinder.Eval(e.Item.DataItem, "Rate");
            if (dataObj != null && dataObj.ToString() != "")
            {
                rating = Convert.ToInt32(dataObj);
            }

            // ابني النجوم
            string starsHtml = "";
            for (int i = 1; i <= 5; i++)
            {
                if (i <= rating)
                    starsHtml += "<i class='fa-solid fa-star' style='color:#FFD700;'></i>";
                else
                    starsHtml += "<i class='fa-regular fa-star' style='color:#FFD700;'></i>";
            }

            // حطّ النجوم جوه span shopRating
            var shopRating = (HtmlGenericControl)e.Item.FindControl("shopRating");
            if (shopRating != null)
            {
                shopRating.InnerHtml = starsHtml;
            }
        }
    }
}