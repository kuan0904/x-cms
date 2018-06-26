using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Routing;
public partial class unitdata : System.Web.UI.Page
{
    public string contents = "";
    public string unitname = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        int  unitid = 0;
        Route myRoute = RouteData.Route as Route;
        if (myRoute != null)
        {
            unitid = RouteData.Values["id"] == null ? 1 : int.Parse(RouteData.Values["id"].ToString());
        }
        else
        {
            unitid =int.Parse ( Request.QueryString["unitid"]);
        }
          
        unitlib. MainData MainData = new unitlib.MainData();

        MainData = unitlib.Get_UnitData(unitid);
        contents = MainData.Contents;
        unitname = MainData.Subject;
        Session["title"] = unitname + "│" + Application["site_name"];
    }
}