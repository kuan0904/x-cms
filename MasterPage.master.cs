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

    protected void Page_Load(object sender, EventArgs e)
    {
        string cid = "";
        Route myRoute = Page.RouteData.Route as Route;
        if (myRoute != null)
        {
           
            cid = Page.RouteData.Values["id"].ToString();

        }
        else
        {
            cid = Request.QueryString["cid"];
        }
    
        string[] array = { "3", "13","14","15","16" };
        if (array.Contains(cid))
        {
            logo = " emba";
        }
        if (Session["category"] == null)
        {
            DataTable dt;
            string strsql = "SELECT * FROM  tbl_category where status='Y' ";
            NameValueCollection nvc = new NameValueCollection();
            dt = DbControl.Data_Get(strsql, nvc);
            Session["category"] = dt;
        }
    }
}
