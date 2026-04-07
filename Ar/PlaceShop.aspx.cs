using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DMS;
public partial class Ar_PlaceShop : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindMenu();
            Addresses addr = new Addresses();
            addr.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString["addid"].ToString()));
            Areas area = new Areas();
            area.LoadByPrimaryKey(addr.Area_id);
            Gov gov = new Gov();
            gov.LoadByPrimaryKey(area.Gov_id);
            ltareaId.Text = addr.s_Area_id;
            ltaddid.Text = addr.s_ID;
            Ssetting set = new Ssetting();
            set.LoadAll();
            ltPercentage.Text = set.DeliveryP.ToString("G29");
            Places place = new Places();
            place.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString["id"].ToString()));
            var lang = System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName;

            ltlocation.Text = lang == "en" ? "<a href='Places.aspx?id=" + place.Categories_id + "&addid=" + addr.ID + "'>" + gov.NameEn + "-" + area.NameEn + "</a>" :
                          lang == "ru" ? "<a href='Places.aspx?id=" + place.Categories_id + "&addid=" + addr.ID + "'>" + gov.NameRu + "-" + area.NameRu + "</a>" :
                          "<a href='Places.aspx?id=" + place.Categories_id + "&addid=" + addr.ID + "'>" + gov.Name + "-" + area.Name + "</a>";
            
            
            DeliveryZones dzone = new DeliveryZones();
            dzone.Where.PlacesID.Operator = WhereParameter.Operand.Equal;
            dzone.Where.PlacesID.Value = place.Id;
            dzone.Where.Areas_id.Operator = WhereParameter.Operand.Equal;
            dzone.Where.Areas_id.Value = addr.Area_id;
            dzone.Query.Load();
            vw_Users usr = new vw_Users();
            usr.Where.Id.Operator = WhereParameter.Operand.Equal;
            usr.Where.Id.Value = addr.UserID;
            usr.Query.Load();
            ltDeliveryCost.Text = dzone.DeliveryCost.ToString("G29");
            if (usr.Ocounts == 0)
            {
                ltdeliveryFee.Text = "0";
            }
            else
            {
                ltdeliveryFee.Text = dzone.s_DeliveryCost;
            }
            ltshopId.Text = place.s_Id;
            ltshopName.Text = lang == "en" ? place.NameEn:
                      lang == "ru" ? place.NameRu :
                      place.Name;


            ltshopAreaId.Text = place.s_Areas_id;
            ltname.Text = ltname2.Text  = lang == "en" ? place.NameEn :
                     lang == "ru" ? place.NameRu :
                     place.Name;
            
            
            ltDetails.Text  = lang == "en" ? place.DescriptionEn :
                     lang == "ru" ? place.DescriptionRu :
                     place.Description;


            ltmincost.Text = place.MinOrder.ToString("G29")+' '+(string)GetGlobalResourceObject("texts", "currency");
            ltdeliverytime.Text = (place.DeliveredTime+ dzone.DeliveredTime).ToString();
            imgplace.ImageUrl = place.PhotoPath;
            int rating = place.Rate; // get this value from your database, for example
            string starsHtml = "";
            for (int i = 1; i <= 5; i++)
            {
                if (i <= rating)
                    starsHtml += "<i class='fa-solid fa-star' style='color:#FFD700;'></i>"; // filled star
                else
                    starsHtml += "<i class='fa-regular fa-star' style='color:#FFD700;'></i>"; // empty star
            }
            shopRating.InnerHtml = starsHtml;
        }
    }
  
    private void BindMenu()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string sql = "SELECT distinct dbo.Menus.id, dbo.Menus.Name, dbo.Menus.NameEn, dbo.Menus.NameRu FROM  dbo.Menus INNER JOIN dbo.MenuItems ON dbo.Menus.id = dbo.MenuItems.MenuID INNER JOIN dbo.Places ON dbo.MenuItems.PlaceID = dbo.Places.id WHERE(dbo.MenuItems.PlaceID = " + Convert.ToInt32(Request.QueryString["id"].ToString())+") ";
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(sql, connStr);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rptMenu.DataSource=FoodCategoryRepeater.DataSource = dt;
            rptMenu.DataBind();
            FoodCategoryRepeater.DataBind();
            rptCategories.DataSource = dt;
            rptCategories.DataBind();
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

    protected void rptCategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            int categoryId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "id"));
            Repeater rptFoodItems = (Repeater)e.Item.FindControl("rptFoodItems");

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT dbo.MenuItems.id,dbo.MenuItems.PlaceID, dbo.MenuItems.MenuID, dbo.MenuItems.Name,dbo.MenuItems.NameEn,dbo.MenuItems.NameRu, dbo.MenuItems.Description,dbo.MenuItems.DescriptionEn,dbo.MenuItems.DescriptionRu, dbo.MenuItems.Price AS OldPrice," + 
               " dbo.MenuItems.Price - dbo.MenuItems.DiscountValue AS NewPrice , dbo.MenuItems.PhotoUrl "+
" FROM dbo.Menus INNER JOIN "+
               " dbo.MenuItems ON dbo.Menus.id = dbo.MenuItems.MenuID INNER JOIN "+
               " dbo.Places ON dbo.MenuItems.PlaceID = dbo.Places.id where MenuID=@MenuID and PlaceID=@PlaceID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@MenuID", categoryId);
                cmd.Parameters.AddWithValue("@PlaceID", Convert.ToInt32(Request.QueryString["id"].ToString()));

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                rptFoodItems.DataSource = rdr;
                rptFoodItems.DataBind();
            }
        }
    }
}