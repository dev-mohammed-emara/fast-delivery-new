using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using DMS;
public partial class Admin_Pages_Orders : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // قيم افتراضية للتواريخ
            txtFromDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            txtToDate.Text = DateTime.Today.ToString("yyyy-MM-dd");

            LoadGovs();
            BindOrders();
        }
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkbox = (CheckBox)sender;
        GridViewRow Grow = (GridViewRow)chkbox.NamingContainer;
        string z = ((HiddenField)Grow.FindControl("hf")).Value;
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            string sql = "UPDATE Orders SET Delivered=@Delivered  where ID=@ID";
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@Delivered", chkbox.Checked);
            cmd.Parameters.AddWithValue("@ID", Convert.ToInt32(z));
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }
    private void LoadGovs()
    {
        string connStr = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT id, Name FROM Gov", conn);
            SqlDataReader dr = cmd.ExecuteReader();
            ddlGov.DataSource = dr;
            ddlGov.DataTextField = "Name";
            ddlGov.DataValueField = "id";
            ddlGov.DataBind();
            ddlGov.Items.Insert(0, new System.Web.UI.WebControls.ListItem("الكل", "0"));
            dr.Close();
        }
        LoadAreas(0);
    }

    private void LoadAreas(int govId)
    {
        ddlArea.Items.Clear();
        ddlArea.Items.Add(new System.Web.UI.WebControls.ListItem("الكل", "0"));
        if (govId > 0)
        {
            string connStr = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT id, Name FROM Areas WHERE gov_id=@govId", conn);
                cmd.Parameters.AddWithValue("@govId", govId);
                SqlDataReader dr = cmd.ExecuteReader();
                ddlArea.DataSource = dr;
                ddlArea.DataTextField = "Name";
                ddlArea.DataValueField = "id";
                ddlArea.DataBind();
                dr.Close();
            }
        }
    }

    protected void ddlGov_SelectedIndexChanged(object sender, EventArgs e)
    {
        int govId = int.Parse(ddlGov.SelectedValue);
        LoadAreas(govId);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindOrders();
    }

    private void BindOrders()
    {
        string connStr = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            string query = @"
                SELECT o.id, u.Name + ' ' + u.Lname AS UserName,
                       g.Name AS Gov, a.Name AS Area,
                       SUM(od.Amount * od.Price) AS total,
                       o.DeliveryCost,
                       SUM(od.Amount * od.Price) + o.DeliveryCost AS net,
                       o.Delivered,
                       CAST(o.Odate AS DATE) AS Odate
                FROM Orders o
                INNER JOIN Order_Details od ON o.id = od.Order_id
                INNER JOIN Addresses addr ON o.Address_id = addr.ID
                INNER JOIN Users u ON addr.UserID = u.Id
                INNER JOIN Areas a ON addr.Area_id = a.id
                INNER JOIN Gov g ON a.gov_id = g.id
                WHERE 1=1";

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;

            // التاريخ
            DateTime fromDate, toDate;
            if (!DateTime.TryParse(txtFromDate.Text, out fromDate)) fromDate = DateTime.Today;
            if (!DateTime.TryParse(txtToDate.Text, out toDate)) toDate = DateTime.Today;

            query += " AND CAST(o.Odate AS DATE) >= @FromDate AND CAST(o.Odate AS DATE) <= @ToDate";
            cmd.Parameters.AddWithValue("@FromDate", fromDate);
            cmd.Parameters.AddWithValue("@ToDate", toDate);

            // الفلتر على التوصيل
            if (ddlDelivered.SelectedValue != "-1")
            {
                query += " AND o.Delivered = @Delivered";
                cmd.Parameters.AddWithValue("@Delivered", ddlDelivered.SelectedValue == "1");
            }

            // الفلتر على المحافظة والمنطقة
            int govId = int.Parse(ddlGov.SelectedValue);
            if (govId > 0)
            {
                query += " AND g.id = @GovId";
                cmd.Parameters.AddWithValue("@GovId", govId);
            }

            int areaId = int.Parse(ddlArea.SelectedValue);
            if (areaId > 0)
            {
                query += " AND a.id = @AreaId";
                cmd.Parameters.AddWithValue("@AreaId", areaId);
            }

            query += @"
                GROUP BY o.id, u.Name, u.Lname, g.Name, a.Name, o.DeliveryCost, o.Delivered, o.Odate
                ORDER BY o.Odate DESC";

            cmd.CommandText = query;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvOrders.DataSource = dt;
            gvOrders.DataBind();
            lblCount.Text = dt.Rows.Count.ToString();
        }
    }
    protected void gvOrders_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvOrders.PageIndex = e.NewPageIndex;
        BindOrders();
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#MyPopup", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();$('#MyPopup2').hide();", true);

    }
    protected void gvOrders_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ShowDetails")
        {
            ltcontent.Text = "<iframe src='OrdersDetails.aspx?id=" + e.CommandArgument + "' width='100%' height='100%' style='overflow:hidden;overflow-x:hidden;overflow-y:hidden;height:100%;width:100%;position:absolute;top:0px;left:0px;right:0px;bottom:0px' height='100%' width='100%'></iframe>";
            string title = "تفاصيل الطلب";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Popup", "ShowPopup('" + title + "');", true);
            return;
        }
    }
}
