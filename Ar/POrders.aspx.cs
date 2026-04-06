using DMS;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ar_POrders : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        this.Load += new EventHandler(Page_Load);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
           
            // افترض انك تعرف UserID الحالي، مثلا من Session أو Authentication
            Users usr = new Users();
            usr.Where.Email.Operator = WhereParameter.Operand.Equal;
            usr.Where.Email.Value = User.Identity.Name;
            usr.Query.Load();
            BindOrders(usr.Id);
        }
    }
    private void BindOrders(int userId)
    {

        string query = @"
    SELECT 
        o.id AS OrderID,
        a.userid as uid,
        o.Odate,
        a.AddressName,
        p.Name AS PlaceName,p.NameEn AS PlaceNameEn,p.NameRu AS PlaceNameRu,
        STUFF((
            SELECT ' + ' + 
        CASE 
            WHEN @lang = 'en' THEN mi2.NameEn
            WHEN @lang = 'ru' THEN mi2.NameRu
            ELSE mi2.Name
        END
            FROM dbo.Order_Details od2
            INNER JOIN dbo.MenuItems mi2 ON od2.MenuItems_id = mi2.id
            WHERE od2.Order_id = o.id
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 3, '') AS OrderedItems,
        (SELECT SUM(od2.Amount * od2.Price)
         FROM dbo.Order_Details od2
         WHERE od2.Order_id = o.id) AS TotalPrice
    FROM dbo.Orders o
    INNER JOIN dbo.Addresses a ON o.Address_id = a.ID
    INNER JOIN dbo.Order_Details od ON o.id = od.Order_id
    INNER JOIN dbo.MenuItems mi ON od.MenuItems_id = mi.id
    INNER JOIN dbo.Places p ON mi.PlaceID = p.id
    WHERE a.UserID = @UserID
    GROUP BY o.id, o.Odate, a.AddressName, p.Name,p.NameEn,p.NameRu, a.UserID
    ORDER BY o.Odate DESC";

        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@UserID", userId);
            var lang = System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName;
            cmd.Parameters.AddWithValue("@lang", lang);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            rptOrders.DataSource = reader;
            rptOrders.DataBind();
            reader.Close();
        }
        noPreviousOrders.Visible = (rptOrders.Items.Count == 0);
    }

}