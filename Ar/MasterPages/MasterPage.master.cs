using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ar_MasterPages_MasterPage : System.Web.UI.MasterPage
{
    public string CurrentLang = "ru"; // كل مرة تعيد تحميل الصفحة تبدأ من عربي
    public string CurrentDir = "ltr";
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpCookie langCookie = Request.Cookies["lang"];
        string lang = (langCookie != null && !string.IsNullOrEmpty(langCookie.Value)) ? langCookie.Value : "ar";

        switch (lang)
        {
            case "en":
                CurrentLang = "en";
                CurrentDir = "ltr";
                ltscript.Text = "<script id='dynamic - texts' src='js/texts_en.js'></script>";
                break;
            case "ru":
                CurrentLang = "ru";
                CurrentDir = "ltr";

                ltscript.Text = "<script id='dynamic - texts' src='js/texts_ru.js'></script>";
                break;
            default:
                CurrentLang = "ar";
                CurrentDir = "rtl";

                ltscript.Text = "<script id='dynamic - texts' src='js/texts_ar.js'></script>";
                break;
        }
    }
  
    protected void lblogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("default.aspx");
    }
}
