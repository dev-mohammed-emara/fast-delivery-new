using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Linq;

public partial class Admin_Pages_OrdersDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int orderId = 0;
            if (Request.QueryString["id"] != null)
                int.TryParse(Request.QueryString["id"], out orderId);

            BindOrders(orderId);
        }
    }

    private void BindOrders(int orderId)
    {
        string connStr = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        DataTable dt = new DataTable();

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            string query = @"
                SELECT od.id, od.Order_id, p.Name AS Place, p.Address AS PlaceAddress, a.Name AS Area, g.Name AS Gov,
                       m.Name AS Menu, mi.Name AS Item, od.Amount, od.Price, od.Amount * od.Price AS total,
                       u.Name AS Fname, u.Lname, addr.AddressName, addr.Mobile, addr.phone, addr.AType, 
                       addr.StreetName, addr.Build, addr.FloorNo, addr.adepartmentNo, addr.Instructions,
                       Gov_1.Name AS UGov, Areas_1.Name AS UArea, o.DeliveryCost,
                       addr.Latitude, addr.Longitude
                FROM Order_Details od
                INNER JOIN MenuItems mi ON od.MenuItems_id = mi.id
                INNER JOIN Menus m ON mi.MenuID = m.id
                INNER JOIN Places p ON mi.PlaceID = p.id
                INNER JOIN Areas a ON p.Areas_id = a.id
                INNER JOIN Gov g ON a.gov_id = g.id
                INNER JOIN Orders o ON od.Order_id = o.id
                INNER JOIN Addresses addr ON o.Address_id = addr.ID
                INNER JOIN Users u ON addr.UserID = u.Id
                INNER JOIN Areas AS Areas_1 ON addr.Area_id = Areas_1.id
                INNER JOIN Gov AS Gov_1 ON Areas_1.gov_id = Gov_1.id
                WHERE od.Order_id = @OrderId";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@OrderId", orderId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
        }

        if (dt.Rows.Count == 0)
        {
            phPlaces.Controls.Add(new Literal { Text = "<div class='alert alert-warning'>لا توجد بيانات لهذا الطلب</div>" });
            return;
        }

        // بيانات العميل
        var rowCustomer = dt.Rows[0];
        string custName = string.Format("{0} {1}", rowCustomer["Fname"], rowCustomer["Lname"]);
        string custMobile = rowCustomer["Mobile"].ToString();
        string custPhone = rowCustomer["phone"].ToString();
        string addrName = rowCustomer["AddressName"].ToString();
        int aType = Convert.ToInt32(rowCustomer["AType"]);
        string aTypeText = (aType == 0 ? "شقة" : aType == 1 ? "منزل" : "مكتب");
        string street = rowCustomer["StreetName"].ToString();
        string build = rowCustomer["Build"].ToString();
        string floor = rowCustomer["FloorNo"].ToString();
        string apartment = rowCustomer["adepartmentNo"].ToString();
        string instructions = rowCustomer["Instructions"].ToString();
        string uGov = rowCustomer["UGov"].ToString();
        string uArea = rowCustomer["UArea"].ToString();
        decimal deliveryCost = Convert.ToDecimal(rowCustomer["DeliveryCost"]);
        string latitude = rowCustomer["Latitude"].ToString();
        string longitude = rowCustomer["Longitude"].ToString();

        string fullAddress = string.Format("{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}",
            addrName, street, build, floor, apartment, instructions, uArea, uGov);

        // عرض بيانات العميل
        Label lblCustomer = new Label();
        lblCustomer.Text = string.Format(
            "<div class='alert alert-secondary'>" +
            "<div><strong>العميل:</strong> {0}</div>" +
            "<div><strong>الهاتف:</strong> {1}</div>" +
            "<div><strong>الموبايل:</strong> {2}</div>" +
            "<div><strong>العنوان:</strong> {3}</div>" +
            "<div><strong>نوع العنوان:</strong> {4}</div>" +
            "</div>" +
            "<div id='map' style='height: 300px; margin-top:10px;'></div>",
            custName, custPhone, custMobile, fullAddress, aTypeText
        );
        phPlaces.Controls.Add(lblCustomer);
        string safeCustName = custName.Replace("'", "\\'");
        string safeFullAddress = fullAddress.Replace("'", "\\'");
        // سكربت Leaflet لإظهار الخريطة
        string mapScript = string.Format(@"
<script>
window.onload = function() {{
    var map = L.map('map').setView([{0}, {1}], 16);
    L.tileLayer('https://{{s}}.tile.openstreetmap.org/{{z}}/{{x}}/{{y}}.png', {{
        maxZoom: 19,
        attribution: '&copy; OpenStreetMap contributors'
    }}).addTo(map);
    var marker = L.marker([{0}, {1}]).addTo(map)
        .bindPopup('<b>{2}</b><br>{3}')
        .openPopup();
}};
</script>
", latitude, longitude, safeCustName, safeFullAddress);

        ltMapScript.Text = mapScript;

        // Literal في ASPX باسم ltMapScript
        ltMapScript.Text = mapScript;

        // تقسيم حسب المكان
        var grouped = dt.AsEnumerable()
                        .GroupBy(r => new
                        {
                            Place = r.Field<string>("Place"),
                            Address = r.Field<string>("PlaceAddress"),
                            Area = r.Field<string>("Area"),
                            Gov = r.Field<string>("Gov")
                        });

        decimal grandTotal = 0;

        foreach (var grp in grouped)
        {
            Label lblPlace = new Label();
            lblPlace.Text = string.Format(
                "<div class='mt-3'><h5>{0} - {1} | {2} | {3}</h5></div>",
                grp.Key.Place, grp.Key.Address, grp.Key.Area, grp.Key.Gov
            );
            phPlaces.Controls.Add(lblPlace);

            GridView gv = new GridView();
            gv.CssClass = "table table-bordered table-striped";
            gv.AutoGenerateColumns = false;
            gv.DataKeyNames = new string[] { "id" };
            gv.ShowFooter = true;

            gv.Columns.Add(new BoundField { HeaderText = "القائمة", DataField = "Menu" });
            gv.Columns.Add(new BoundField { HeaderText = "المنتج", DataField = "Item" });
            gv.Columns.Add(new BoundField { HeaderText = "الكمية", DataField = "Amount" });
            gv.Columns.Add(new BoundField { HeaderText = "السعر", DataField = "Price", DataFormatString = "{0:N2}" });
            gv.Columns.Add(new BoundField { HeaderText = "الإجمالي", DataField = "total", DataFormatString = "{0:N2}" });

            DataTable dtPlace = grp.CopyToDataTable();
            gv.DataSource = dtPlace;
            gv.DataBind();

            decimal totalPerPlace = dtPlace.AsEnumerable().Sum(r => Convert.ToDecimal(r["total"]));
            grandTotal += totalPerPlace;

            if (gv.FooterRow != null)
            {
                gv.FooterRow.Cells[0].Text = "المجموع لكل مكان:";
                gv.FooterRow.Cells[0].ColumnSpan = 4;
                gv.FooterRow.Cells[0].HorizontalAlign = HorizontalAlign.Right;
                gv.FooterRow.Cells[4].Text = totalPerPlace.ToString("N2");
            }

            phPlaces.Controls.Add(gv);
        }

        decimal netTotal = grandTotal + deliveryCost;
        Label lblSummary = new Label();
        lblSummary.Text = string.Format(
            "<div class='alert alert-info mt-3'><strong>المجموع الكلي:</strong> {0:N2} | <strong>تكلفة التوصيل:</strong> {1:N2} | <strong>الصافي:</strong> {2:N2}</div>",
            grandTotal, deliveryCost, netTotal
        );
        phPlaces.Controls.Add(lblSummary);
    }
}
