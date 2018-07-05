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
public partial class list : System.Web.UI.Page
{
    public static  int Totalrow  = 0;
    public static int Pagecount = 0;
    public static int PageSize = 5;
    public static int PageIdx = 1;
    public static string unitname = "";
    public string pagetitle = "";
      protected void Page_Init(object sender, EventArgs e)
    {


    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string cid = "";
        Route myRoute = RouteData.Route as Route;
        if (myRoute != null)
        {    
            PageIdx  = RouteData.Values["pageindex"]==null ? 1:int.Parse ( RouteData.Values["pageindex"].ToString () );
            cid =  RouteData.Values["id"].ToString ();          
        }
        else
        {
            cid = Request.QueryString["cid"];
            PageIdx = Request.QueryString["pageindex"] == null ? 1 : int.Parse (Request.QueryString["pageindex"]);
        }
        if (cid == null) Response.Redirect("/index");
        if (cid =="3" || cid == "13"  || cid == "14" || cid == "15" || cid == "16" ) Response.Redirect("/" + cid  + "/lesson" );
        unitname =  cid + "/catalog";      
        List<Banner.MainData> banner1 = new List<Banner.MainData>();
        if (Request.QueryString["kind"] == "preview")
            banner1 = Banner.DbHandle.Banner_Get_list(4,"preview");
        else
            banner1 = Banner.DbHandle.Banner_Get_list(4);
        Repeater1.DataSource = banner1;
        Repeater1.DataBind();
        banner1.Clear();
     
        List<article.MainData> hotlist = new List<article.MainData>();  
        hotlist = article.DbHandle.Get_article_list(cid, "", PageSize, PageIdx);
       
        foreach (var p in hotlist)
        {
        

            Totalrow  = p.TotalRows;
            break;
        }
     
        hot_list_detail.DataSource = hotlist;
        hot_list_detail.DataBind();
        hotlist.Clear();

      
        DataTable dt;    
        dt = (DataTable)Application["category"];
        dt.DefaultView.RowFilter = "categoryid=" + cid;
        dt = dt.DefaultView.ToTable();
        pagetitle = dt.Rows[0]["title"].ToString();
        Session["title"] = pagetitle + "│" + Application["site_name"];
        dt.Dispose();
    }

    public static string PagePaging()
    {
        string retmsg = "";
        Pagecount = Totalrow / PageSize + (Totalrow % PageSize > 0 ? 1 : 0);
        int i = 0;

        retmsg +="<li class=\"page-item\"><a class=\"page-link\" href=\"/"+ unitname + "/" + (PageIdx <= 1 ? Pagecount  : PageIdx -1 ) + "\" aria-label=\"Previous\"><span aria-hidden=\"true\">«</span><span class=\"sr-only\">Previous</span></a></li>";
        for (i =1;i<= Pagecount; i++)
        {
            
            retmsg += "<li class=\"page-item"  + ( i==PageIdx ? " active" : "") + "\"><a class=\"page-link\" href=\"/"+ unitname + "/" + i  +"\">"+ i +"</a></li>";
        }

        retmsg += "<li class=\"page-item\"><a class=\"page-link\" href=\"/" + unitname + "/" +  (PageIdx >=Pagecount ? PageIdx +1 : 1 ) +  "\" aria-label=\"Next\"><span aria-hidden=\"true\">»</span><span class=\"sr-only\">Next</span></a></li>";
              
        return retmsg;
    }

}