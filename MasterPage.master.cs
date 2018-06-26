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
    public string[] active = { "", "", "", "", "", "","" };
    public string FacebookAppId = "164103481107660";
    protected void Page_Load(object sender, EventArgs e)
    {

        string returnurl = (Request.QueryString["page"] != null) ? Request.QueryString["page"] : "";
        btnFbLogin.NavigateUrl = "https://www.facebook.com/v2.10/dialog/oauth/?client_id=164103481107660&redirect_uri=https://www.culturelaunch.net/fb_login.ashx&response_type=code" ;

       
        string cid = "";
        Route myRoute = Page.RouteData.Route as Route;
        if (myRoute != null)
        {
          
            cid =Page.RouteData.Values["id"] == null  ? "" :Page.RouteData.Values["id"].ToString();

        }
        else
        {
            cid = Request.QueryString["cid"];
        }
    
        string[] array = { "3", "13","14","15","16" };
        if (array.Contains(cid))
        {
            logo = " emba";
            active[3] = " active";
        }
        array = new string [4]  { "1", "7","8","9" };
        if (array.Contains(cid))
        {    
            active[1] = " active";
        }
        array = new string[4] { "2", "10", "11", "12" };
        if (array.Contains(cid))
        {
         
            active[2] = " active";
        }
        if (cid =="5") active[5] = " active";
        if (cid == "4")active[4] = " active";
        array = new string[3] { "6", "17", "18" };
        if (array.Contains(cid))
        {

            active[6] = " active";
        }

      
    }
}
