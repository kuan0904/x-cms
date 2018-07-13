using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sitemap : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        Session["description"] = Application["description"];
        Session["keywords"] = Application["keywords"];
        Session["image"] = Session["websiteurl"] + "/image/logo.jpg";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["title"] = "網站導覽│" + Application["site_name"];
    }
}