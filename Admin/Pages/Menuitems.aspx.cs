using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using AjaxControlToolkit;

public partial class Admin_Pages_MenuItems : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindPlaces();
            BindMenuItems();
        }
    }

    // رفع الصورة من AsyncFileUpload
   

    // جلب القوائم
    void BindMenus()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
           
            SqlCommand cmd = new SqlCommand("SELECT dbo.Menus.id, dbo.Menus.Name, dbo.Menus.NameEn FROM  dbo.Menus INNER JOIN dbo.Places ON dbo.Menus.Categories_id = dbo.Places.Categories_id WHERE(dbo.Places.id = "+Convert.ToInt32(ddlPlace.SelectedValue)+") order by name", conn);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            ddlMenu.DataSource = dr;
            ddlMenu.DataTextField = "Name";
            ddlMenu.DataValueField = "ID";
            ddlMenu.DataBind();
            dr.Close();
            ddlMenu.Items.Insert(0, new ListItem("..اختر القائمة..", "0"));
        }
    }

    // جلب الأماكن / المطاعم
    void BindPlaces()
    {

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("SELECT ID, Name FROM Places  ORDER BY Name", conn);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            ddlPlace.DataSource = dr;
            ddlPlace.DataTextField = "Name";
            ddlPlace.DataValueField = "ID";
            ddlPlace.DataBind();
            dr.Close();
            ddlPlace.Items.Insert(0, new ListItem("..اختر المكان..", "0"));
        }
    }

    // عرض عناصر القائمة في GridView
    void BindMenuItems(string search = "")
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string sql = @"
    SELECT mi.ID, mi.Name, mi.NameEn, mi.NameRu, mi.Description, mi.DescriptionEn, mi.DescriptionRu, 
           mi.Price, mi.DiscountValue, mi.IsAvailable, mi.PhotoUrl, mi.PrepearMin, 
           m.Name AS MenuName, p.Name AS PlaceName
    FROM MenuItems mi
    INNER JOIN Menus m ON mi.MenuID = m.ID
    INNER JOIN Places p ON mi.PlaceID = p.ID";

            if (!string.IsNullOrEmpty(search))
                sql += " WHERE mi.Name LIKE @Search OR mi.Description LIKE @Search";

            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            if (!string.IsNullOrEmpty(search))
                da.SelectCommand.Parameters.AddWithValue("@Search", "%" + search + "%");

            DataTable dt = new DataTable();
            da.Fill(dt);
            gvMenuItems.DataSource = dt;
            gvMenuItems.DataBind();
        }
    }
    // زر الحفظ / التعديل
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string photoPath = hfPhotoPath.Value;

        // رفع الصورة إذا تم اختيارها
        if (fuPhoto.HasFile)
        {
            string ext = Path.GetExtension(fuPhoto.FileName).ToLower();
            if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif")
            {
                string fileName = Guid.NewGuid().ToString() + ext;
                string savePath = Server.MapPath("~/ar/images/items/") + fileName;
                fuPhoto.SaveAs(savePath);
                photoPath = "images/items/" + fileName;
            }
        }
        int menuId = int.Parse(ddlMenu.SelectedValue);
        int placeId = int.Parse(ddlPlace.SelectedValue);
        string name = txtName.Text.Trim();
        string nameEn = txtNameEn.Text.Trim();
        string nameRu = txtNameRu.Text.Trim();
        string desc = txtDescription.Text.Trim();
        string descEn = txtDescriptionEn.Text.Trim();
        string descRu = txtDescriptionRu.Text.Trim();
        decimal price = decimal.Parse(txtPrice.Text.Trim());
        decimal discount = string.IsNullOrEmpty(txtDiscount.Text) ? 0 : decimal.Parse(txtDiscount.Text);
        string photo = hfPhotoPath.Value; // المسار بعد رفع الصورة
        bool isAvailable = chkAvailable.Checked;
        int prepearMin = string.IsNullOrEmpty(txtPrepearMin.Text) ? 0 : int.Parse(txtPrepearMin.Text.Trim());
        if (menuId == 0 || placeId == 0 || string.IsNullOrEmpty(name)) return;

        if (ViewState["EditID"] != null) // تعديل
        {
            int id = (int)ViewState["EditID"];
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
    UPDATE MenuItems SET MenuID=@MenuID, PlaceID=@PlaceID, Name=@Name, NameEn=@NameEn, NameRu=@NameRu, 
                         Description=@Desc, DescriptionEn=@DescEn, DescriptionRu=@DescRu,
                         Price=@Price, DiscountValue=@Discount, PhotoUrl=@Photo, 
                         IsAvailable=@IsAvailable, PrepearMin=@PrepearMin
    WHERE ID=@ID", conn);
                cmd.Parameters.AddWithValue("@MenuID", menuId);
                cmd.Parameters.AddWithValue("@PlaceID", placeId);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@NameEn", nameEn);
                cmd.Parameters.AddWithValue("@NameRu", nameRu);
                cmd.Parameters.AddWithValue("@Desc", string.IsNullOrEmpty(desc) ? (object)DBNull.Value : desc);
                cmd.Parameters.AddWithValue("@DescEn", string.IsNullOrEmpty(descEn) ? (object)DBNull.Value : descEn);
                cmd.Parameters.AddWithValue("@DescRu", string.IsNullOrEmpty(descRu) ? (object)DBNull.Value : descRu);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@Discount", discount);
                cmd.Parameters.AddWithValue("@Photo", string.IsNullOrEmpty(photoPath) ? (object)DBNull.Value : photoPath);

                cmd.Parameters.AddWithValue("@IsAvailable", isAvailable);
                cmd.Parameters.AddWithValue("@PrepearMin", prepearMin);
                cmd.Parameters.AddWithValue("@ID", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            btnSave.Text = "حفظ";
            ViewState["EditID"] = null;
        }
        else // إضافة جديد
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
    INSERT INTO MenuItems (MenuID, PlaceID, Name, NameEn, NameRu, Description, DescriptionEn, DescriptionRu, 
                          Price, DiscountValue, PhotoUrl, IsAvailable, CreatedAt, PrepearMin)
    VALUES (@MenuID, @PlaceID, @Name, @NameEn, @NameRu, @Desc, @DescEn, @DescRu, 
            @Price, @Discount, @Photo, @IsAvailable, @CreatedAt, @PrepearMin)", conn);
                cmd.Parameters.AddWithValue("@MenuID", menuId);
                cmd.Parameters.AddWithValue("@PlaceID", placeId);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@NameEn", nameEn);
                cmd.Parameters.AddWithValue("@NameRu", nameRu);
                cmd.Parameters.AddWithValue("@Desc", string.IsNullOrEmpty(desc) ? (object)DBNull.Value : desc);
                cmd.Parameters.AddWithValue("@DescEn", string.IsNullOrEmpty(descEn) ? (object)DBNull.Value : descEn);
                cmd.Parameters.AddWithValue("@DescRu", string.IsNullOrEmpty(descRu) ? (object)DBNull.Value : descRu);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@Discount", discount);
                cmd.Parameters.AddWithValue("@Photo", string.IsNullOrEmpty(photoPath) ? (object)DBNull.Value : photoPath);

                cmd.Parameters.AddWithValue("@IsAvailable", isAvailable);
                cmd.Parameters.AddWithValue("@CreatedAt", DateTime.Now);
                cmd.Parameters.AddWithValue("@PrepearMin", prepearMin);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        ClearForm();
        BindMenuItems(txtSearch.Text.Trim());
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ClearForm();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindMenuItems(txtSearch.Text.Trim());
    }

    protected void gvMenuItems_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvMenuItems.PageIndex = e.NewPageIndex;
        BindMenuItems(txtSearch.Text.Trim());
    }

    protected void gvMenuItems_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "DeleteItem")
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM MenuItems WHERE ID=@ID", conn);
                cmd.Parameters.AddWithValue("@ID", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            BindMenuItems(txtSearch.Text.Trim());
        }
        else if (e.CommandName == "EditItem")
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM MenuItems WHERE ID=@ID", conn);
                cmd.Parameters.AddWithValue("@ID", id);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    ddlPlace.SelectedValue = dr["PlaceID"].ToString();
                    BindMenus();
                    ddlMenu.SelectedValue = dr["MenuID"].ToString();

                    txtPrepearMin.Text = dr["PrepearMin"].ToString();
                    txtName.Text = dr["Name"].ToString();
                    txtNameEn.Text = dr["NameEn"].ToString();
                    txtNameRu.Text = dr["NameRu"].ToString();
                    txtDescription.Text = dr["Description"].ToString();
                    txtDescriptionEn.Text = dr["DescriptionEn"].ToString();
                    txtDescriptionRu.Text = dr["DescriptionRu"].ToString();
                    txtPrice.Text = dr["Price"].ToString();
                    txtDiscount.Text = dr["DiscountValue"].ToString();
                    hfPhotoPath.Value = dr["PhotoUrl"].ToString();
                    chkAvailable.Checked = (bool)dr["IsAvailable"];
                    ViewState["EditID"] = id;
                    btnSave.Text = "تعديل";
                }
                dr.Close();
            }
        }
    }

    void ClearForm()
    {
        ddlMenu.SelectedValue = "0";
        ddlPlace.SelectedValue = "0";
        txtPrepearMin.Text = "0";
        txtName.Text = "";
        txtNameEn.Text = "";
        txtDescription.Text = "";
        txtPrice.Text = "";
        txtDiscount.Text = "";
        hfPhotoPath.Value = "";
        chkAvailable.Checked = false;
        btnSave.Text = "حفظ";
        ViewState["EditID"] = null;
    }

    protected void ddlPlace_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindMenus();
    }
}
