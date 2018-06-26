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

public partial class list_search : System.Web.UI.Page
{
    public string keyword = "";
    public static int Totalrow = 0;
    public static int Pagecount = 0;
    public static int PageSize = 10;
    public static int PageIdx = 1;
    public static string unitname = "";
    public string pagetitle = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Route myRoute = RouteData.Route as Route;
        if (myRoute != null)
        {
            PageIdx = RouteData.Values["pageindex"] == null ? 1 : int.Parse(RouteData.Values["pageindex"].ToString());
            keyword = RouteData.Values["keyword"].ToString();
        }
        else
        {
            keyword = Request.QueryString["keyword"];
            PageIdx = Request.QueryString["pageindex"] == null ? 1 : int.Parse(Request.QueryString["pageindex"]);
        }
        Session["title"] = keyword + "│" + Application["site_name"];
        List<article.MainData> hotlist = new List<article.MainData>();
        hotlist = article.DbHandle.Get_article_list("", keyword, PageSize, PageIdx);
        unitname = "search/" + keyword;
        foreach (var p in hotlist)
        {


            Totalrow = p.TotalRows;
            break;
        }

        list_detail.DataSource = hotlist;
        list_detail.DataBind();
        hotlist.Clear();


        DataTable dt;
        dt = (DataTable)Application["category"];
      //  dt.DefaultView.RowFilter = "categoryid=" + cid;
        dt = dt.DefaultView.ToTable();
        pagetitle = dt.Rows[0]["title"].ToString();

        dt.Dispose();
    }
    public static string PagePaging()
    {
        string retmsg = "";
        Pagecount = Totalrow / PageSize + (Totalrow % PageSize > 0 ? 1 : 0);
        int i = 0;

        retmsg += "<li class=\"page-item\"><a class=\"page-link\" href=\"/" + unitname + "/" + (PageIdx <= 1 ? Pagecount : PageIdx - 1) + "\" aria-label=\"Previous\"><span aria-hidden=\"true\">«</span><span class=\"sr-only\">Previous</span></a></li>";
        for (i = 1; i <= Pagecount; i++)
        {

            retmsg += "<li class=\"page-item" + (i == PageIdx ? " active" : "") + "\"><a class=\"page-link\" href=\"/" + unitname + "/" + i + "\">" + i + "</a></li>";
        }

        retmsg += "<li class=\"page-item\"><a class=\"page-link\" href=\"/" + unitname + "/" + (PageIdx >= Pagecount ? PageIdx + 1 : 1) + "\" aria-label=\"Next\"><span aria-hidden=\"true\">»</span><span class=\"sr-only\">Next</span></a></li>";

        return retmsg;
    }
}