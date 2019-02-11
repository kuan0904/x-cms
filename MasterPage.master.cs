using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Routing;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;
public partial class MasterPage : System.Web.UI.MasterPage
{
    public Unitlib.WebsiteData Webdata = new Unitlib.WebsiteData();

    public string logo = "";
    public string active ;
    public string un = "";
    public string cid = "";
    public string _status = "";
    public string _link = "";
    public string Articleid = "";
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Session["webmenu"] == null)
        {
            object menu = Unitlib.Get_menu();
            Session["webmenu"] = menu;
        }


    }

    protected void Page_Load(object sender, EventArgs e) {   
        Route myRoute = Page.RouteData.Route as Route;
        if (myRoute != null)       {
            cid =Page.RouteData.Values["cid"] == null  ? "" :Page.RouteData.Values["cid"].ToString();
            Articleid = Page.RouteData.Values["Articleid"] == null ? "" : Page.RouteData.Values["Articleid"].ToString();
        }
        rptmenu.DataSource = Session["webmenu"];//  JsonConvert.SerializeObject(aa);
        rptmenu.DataBind();
        mrptmenu.DataSource = Session["webmenu"];//  JsonConvert.SerializeObject(aa);
        mrptmenu.DataBind();      
        if (Session["active"].ToString() == "3") logo = " emba";
        if (Application["site_name"].ToString ().IndexOf ( "幸福台灣")==-1) logo = "";
     
      
        if (Session["memberdata"] != null && Session["memberdata"].ToString () !="")
        {
            MemberLib.Mmemberdata memberdata = (MemberLib.Mmemberdata)Session["memberdata"];
            un=    memberdata.Username ;
              

        }

                   
    }
    public string checkitem(object sender, int id)
    {
        List<Unitlib.MenuModel> menus = new List<Unitlib.MenuModel>();
        menus = (List<Unitlib.MenuModel>)Session["webmenu"];
        foreach (Unitlib.MenuModel m1 in menus)
        {
            if (m1.Id == id)
            {
                foreach (var x in m1.Detial)
                {
                    return " sf-dropdown ";
                }
            }
        }
        return " ";
    }
    protected void rptmenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

        List<Unitlib.MenuModel> menus = new List<Unitlib.MenuModel>();
        menus = (List<Unitlib.MenuModel>)Session["webmenu"];
        foreach (Unitlib.MenuModel m1 in menus)
        {
            if (m1.Id == ((Unitlib.MenuModel)e.Item.DataItem).Id)
            {
                Repeater rpt = (Repeater)e.Item.FindControl("Repeater1");
                List<Unitlib.MenuModel> submenu = new List<Unitlib.MenuModel>();
                submenu = ((Unitlib.MenuModel)e.Item.DataItem).Detial;
                rpt.DataSource = submenu;
                rpt.DataBind();
            }


        }
    }
}
