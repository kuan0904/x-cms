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
    public string active = "";
    public string FacebookAppId = "164103481107660";
    public string cid = "";
    public string _status = "";
    public string _link = "";
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Session["webmenu"] == null)
        {
            object menu = Unitlib.Get_menu();
            Session["webmenu"] = menu;
        }

        if (Session["memberdata"] == null)
        {
            _status = "登入 / 註冊";
            _link = "/login.html";
        }
        else
        {
            _status = "Hi 會員名稱";
            _link = "/member-edit.aspx";
        }

    }
    protected void Page_Load(object sender, EventArgs e) {
       
      
        Route myRoute = Page.RouteData.Route as Route;
        if (myRoute != null)       {
           cid =Page.RouteData.Values["cid"] == null  ? "" :Page.RouteData.Values["cid"].ToString();

           
        }
        else
        {
            cid = Request.QueryString["cid"];

           
        }
      if (cid != null)    active = cid;
      
        List <Unitlib.MenuModel> subMenu = (List<Unitlib.MenuModel>) Session["webmenu"];
        var parent = subMenu.FirstOrDefault(x => x.Detial.Any(y => y.Id.ToString () == cid));
        if (parent != null) active = parent.Id.ToString();
        rptmenu.DataSource = Session["webmenu"];//  JsonConvert.SerializeObject(aa);
        rptmenu.DataBind();
        mrptmenu.DataSource = Session["webmenu"];//  JsonConvert.SerializeObject(aa);
        mrptmenu.DataBind();
      
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
