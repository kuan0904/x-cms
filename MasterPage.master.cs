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
            object menu = unitlib.Get_menu();
            Session["webmenu"] = menu;
        }

        if (Session["memberdata"] == null)
        {
            _status = "登入 / 註冊";
            _link = "/ligin.html";
        }
        else
        {
            _status = "Hi 會員名稱";
            _link = "/member-edit.html";
        }

    }
    protected void Page_Load(object sender, EventArgs e) {

      
        Route myRoute = Page.RouteData.Route as Route;
        if (myRoute != null)       {
           cid =Page.RouteData.Values["id"] == null  ? "" :Page.RouteData.Values["id"].ToString();
        }
        else
        {
            cid = Request.QueryString["cid"];
        }
      
   
        active = cid;

        List<unitlib.MenuModel> subMenu = (List<unitlib.MenuModel>) Session["webmenu"];
        var parent = subMenu.FirstOrDefault(x => x.Detial.Any(y => y.Id.ToString () == cid));
        if (parent != null) active = parent.Id.ToString();


        //foreach (unitlib.MenuModel m1 in subMenu)
        //{
        //    List<unitlib.MenuModel> m2 = m1.Detial;
        //    foreach (unitlib.MenuModel m in m2)
        //    {
        //        if (m.Id.ToString() == cid) active = m1.Id.ToString();
        //        if (m1.Id.ToString()  == "3") logo = "emba";
        //    }
        //}
        rptmenu.DataSource = Session["webmenu"];//  JsonConvert.SerializeObject(aa);
        rptmenu.DataBind();
        mrptmenu.DataSource = Session["webmenu"];//  JsonConvert.SerializeObject(aa);
        mrptmenu.DataBind();
      
    }

    protected void rptmenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

        List<unitlib.MenuModel> menus = new List<unitlib.MenuModel>();
        menus = (List<unitlib.MenuModel>)Session["webmenu"];
        foreach (unitlib.MenuModel m1 in menus)
        {
            if (m1.Id == ((unitlib.MenuModel)e.Item.DataItem).Id)
            {
                Repeater rpt = (Repeater)e.Item.FindControl("Repeater1");
                List<unitlib.MenuModel> submenu = new List<unitlib.MenuModel>();
                submenu = ((unitlib.MenuModel)e.Item.DataItem).Detial;
                rpt.DataSource = submenu;
                rpt.DataBind();
            }


        }
    }
}
