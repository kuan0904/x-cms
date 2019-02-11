using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class member_class : System.Web.UI.Page
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
            DataTable dt = MemberLib.Member.MyJoinLesson (o.Memberid.ToString());
            Session["title"] = "我的訂單│" + Application["site_name"];
            Totalrow = dt.Rows.Count;
            dt = DbControl.GetPagedTable(dt, PageIdx, PageSize);



            Repeater1.DataSource = dt;
            Repeater1.DataBind();
            dt.Dispose();
        }
        else
        {
            Response.Redirect("https://www.culturelaunch.net/login");
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
    public string get_qrcode(string ord_code)
    {
        string QrCode = "";
        LessonLib.JoinData o = new LessonLib.JoinData();
        o = LessonLib.Web.Get_ord_JoinData(ord_code);
        foreach (LessonLib.JoinDetail d in o.JoinDetail)
        {
            QrCode += o.Ord_code + "-" + d.JoinId.ToString() + "-" + d.LessonId  + "," + d.Name  + ";" ;
          
        }
        return QrCode;
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView dr = e.Item.DataItem as DataRowView;
            if (dr.Row ["paid"].ToString () != "Y" && dr.Row["paymode"].ToString()=="1" )
            {
                HyperLink hy = ((HyperLink)e.Item.FindControl("repay"));
                hy.Visible = true;
                hy.NavigateUrl = "/pay?repay=" + MySecurity.EncryptAES256(dr.Row["ord_code"].ToString()) ; 
            }

            //b.CommandArgument = drv.Row["ID_COLUMN_NAME"].ToString();
            //  ((Label)e.Item.FindControl("RatingLabel")).Text= "<b>***Good***</b>";
        }
    }
}