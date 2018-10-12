using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class member_order : System.Web.UI.Page
{
    public static int Totalrow = 0;
    public static int Pagecount = 0;
    public static int PageSize = 6;
    public static int PageIdx = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        PageIdx = Request.QueryString["pageindex"] != null ? int.Parse(Request.QueryString["pageindex"]) : 1;
        if (Session["memberdata"] != null)
        {
            MemberLib.Mmemberdata o = (MemberLib.Mmemberdata)Session["memberdata"];
            DataTable dt = MemberLib.Member.MyOrderData(o.Memberid.ToString());
            Session["title"] = "我的訂單│" + Application["site_name"];
            Totalrow = dt.Rows.Count;
            dt = DbControl.GetPagedTable(dt, PageIdx, PageSize);



            Repeater1.DataSource = dt;
            Repeater1.DataBind();
            dt.Dispose();
        }

    }
    public static string PagePaging(string path = "")
    {
        string retmsg = "";
        Pagecount = Totalrow / PageSize + (Totalrow % PageSize > 0 ? 1 : 0);
        int i = 0;

        retmsg += "<li class=\"page-item\"><a class=\"page-link\" href=\"" + path + "?pageindex=" + (PageIdx <= 1 ? Pagecount : PageIdx - 1) + "\" aria-label=\"Previous\"><span aria-hidden=\"true\">«</span><span class=\"sr-only\">Previous</span></a></li>";
        for (i = 1; i <= Pagecount; i++)
        {

            retmsg += "<li class=\"page-item" + (i == PageIdx ? " active" : "") + "\"><a class=\"page-link\"  href=\"" + path + "?pageindex=" + i + "\">" + i + "</a></li>";
        }

        retmsg += "<li class=\"page-item\"><a class=\"page-link\" href=\"" + path + "?pageindex=" + (PageIdx >= Pagecount ? PageIdx + 1 : 1) + "\" aria-label=\"Next\"><span aria-hidden=\"true\">»</span><span class=\"sr-only\">Next</span></a></li>";

        return retmsg;
    }
}