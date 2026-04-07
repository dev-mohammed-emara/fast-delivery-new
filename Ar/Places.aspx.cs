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

            if (Request.QueryString["addid"] != null)
            {
                int addId;
                // بنحاول نحول القيمة لرقم، ولو نجحت بنتأكد إنها مش صفر
                if (int.TryParse(Request.QueryString["addid"], out addId) && addId != 0)
                {
                    // الكود هنا سليم والـ addId جاهز للاستخدام
                    BindRepeater();
                    BindRepeaterC();
                }
                else
                {
                    // لو القيمة نصية أو صفر
                    Response.Redirect("~/ar/Addresses.aspx");
                }
            }
            else
            {
                // لو الـ addid مش موجود خالص في الـ URL
                Response.Redirect("~/ar/Addresses.aspx");
            }
        }
    }

    public string GetActiveClass(string categoryId)
    {
        string currentSelectedId = Request.QueryString["id"] ?? "1";
        return (categoryId == currentSelectedId) ? " active" : "";
    }

    private void BindRepeaterC()
    {
        Categories cat = new Categories();
        cat.LoadAll();
        CategoryRepeater.DataSource = cat.DefaultView.Table;
        CategoryRepeater.DataBind();
    }

    private void BindRepeater()
    {
        int catId = Convert.ToInt32(Request.QueryString["id"]);
        int addId = Convert.ToInt32(Request.QueryString["addid"]);

        Categories cat = new Categories();
        cat.LoadByPrimaryKey(catId);

        var lang = System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName;
        ltname.Text = (lang == "en") ? cat.NameEn : (lang == "ru") ? cat.NameRu : cat.Name;

        Addresses add = new Addresses();
        add.LoadByPrimaryKey(addId);
        Areas ara = new Areas();
        ara.LoadByPrimaryKey(add.Area_id);
        Gov gov = new Gov();
        gov.LoadByPrimaryKey(ara.Gov_id);

        ltlocation.Text = ltlocation2.Text = (lang == "en") ? gov.NameEn + "-" + ara.NameEn : (lang == "ru") ? gov.NameRu + "-" + ara.NameRu : gov.Name + "-" + ara.Name;

        using (SqlConnection con = new SqlConnection(connStr))
        {
            // الاستعلام المحدث: يجيب كل المطاعم مع حالة الفتح (IsOpened)
            // ويقوم بترتيبها بحيث المفتوح يظهر أولاً
            string sql = @"
                SELECT p.id, p.Name, p.NameEn, p.NameRu, p.Address, p.Description, p.DescriptionEn, p.DescriptionRu,
                       (p.DeliveredTime + dz.DeliveredTime) as DeliveredTime, p.MinOrder, p.Rate, p.PhotoPath, dz.DeliveryCost,
                       CASE 
                          WHEN s.StartTime IS NOT NULL 
                               AND CAST(DATEADD(HOUR, 10, GETDATE()) AS TIME) BETWEEN s.StartTime AND s.EndTime 
                          THEN 1 ELSE 0 
                       END AS IsOpened
                FROM dbo.Places AS p 
                INNER JOIN dbo.DeliveryZones dz ON p.id = dz.PlacesID 
                INNER JOIN dbo.Addresses AS a ON dz.Areas_id = a.Area_id 
                INNER JOIN dbo.Categories ON p.Categories_id = dbo.Categories.id
                LEFT JOIN dbo.PlacesDeliverySchedule AS s ON p.id = s.PlacesId 
                     AND s.IsActive = 1 
                     AND s.DayId = (SELECT Id FROM dbo.DaysOfWeek WHERE DayOrder = DATEPART(WEEKDAY, DATEADD(HOUR, 10, GETDATE())))
                WHERE (p.Active = 1) AND (a.ID = @addr) AND (dbo.Categories.id = @catg)
                ORDER BY IsOpened DESC, p.Name ASC";

            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@addr", addId);
            cmd.Parameters.AddWithValue("@catg", catId);
            con.Open();
            rptplaces.DataSource = cmd.ExecuteReader();
            rptplaces.DataBind();
        }
    }

    protected void rpt_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            var dataObj = DataBinder.Eval(e.Item.DataItem, "Rate");
            int rating = (dataObj != null && dataObj.ToString() != "") ? Convert.ToInt32(dataObj) : 0;

            string starsHtml = "";
            for (int i = 1; i <= 5; i++)
            {
                starsHtml += (i <= rating) ? "<i class='fa-solid fa-star' style='color:#FFD700;'></i>" : "<i class='fa-regular fa-star' style='color:#FFD700;'></i>";
            }

            var shopRating = (HtmlGenericControl)e.Item.FindControl("shopRating");
            if (shopRating != null) shopRating.InnerHtml = starsHtml;
        }
    }
}