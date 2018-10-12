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

        rptmenu.DataSource = Session["webmenu"];//  JsonConvert.SerializeObject(aa);
        rptmenu.DataBind();
        Repeater1.DataSource = Session["webmenu"];//  JsonConvert.SerializeObject(aa);
        Repeater1.DataBind();
    }
    protected void rptmenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

        List<Unitlib.MenuModel> menus = new List<Unitlib.MenuModel>();
        menus = (List<Unitlib.MenuModel>)Session["webmenu"];
        foreach (Unitlib.MenuModel m1 in menus)
        {
            if (e.Item.DataItem != null)
            {
                if (m1.Id == ((Unitlib.MenuModel)e.Item.DataItem).Id)
                {
                    Repeater rpt = (Repeater)e.Item.FindControl("Repeater2");
                    List<Unitlib.MenuModel> submenu = new List<Unitlib.MenuModel>();
                    submenu = ((Unitlib.MenuModel)e.Item.DataItem).Detial;
                    rpt.DataSource = submenu;
                    rpt.DataBind();
                }
            }

        }
    }
}