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
public partial class detail : System.Web.UI.Page
{
    public Unitlib.WebsiteData m = new Unitlib.WebsiteData();

    public string iscollection = "";
    public string Breadcrumb = "";
    public string subject = "";
    public string contents = "";
    public string pic = "";
    public string postday = "";
    public string keywords = "";
    public string viewcount = "";
    public string tags = "";
    public string pagetitle = "";
    public string pageunit = "";
    public string author = "";
    public string cid = "";
    public string Articleid = "";
    protected void Page_LoadComplete(object sender, EventArgs e)
    {       
       
        ASP.masterpage_master P  = this.Master as ASP.masterpage_master;
        P.active = cid;
      
     
    }
    protected void Page_Load(object sender, EventArgs e)
    {
       
        Unitlib.WebsiteData m = new Unitlib.WebsiteData();


        Articleid = Request.QueryString["Articleid"];
        Route myRoute = RouteData.Route as Route;     
        if (myRoute != null )
        {
            Articleid = RouteData.Values["Articleid"].ToString();          
        }
    
        article.MainData MainData = new article.MainData();
        List<article.ItemData> ItemData = new List<article.ItemData>() ;
     
        if (Articleid != null)
        {
            MainData = article.DbHandle.Get_article(int.Parse(Articleid));
        }
        else if (Session["MainData"] != null)
        {

            MainData = HttpContext.Current.Session["MainData"] as article.MainData;
        }

        if (MainData != null)
        {
          
            if (MainData.kind =="Y" || MainData.kind == "L") Response.Redirect("/Class/" + MainData.Id );
            subject = MainData.Subject;
            Session["title"] = subject + "│" + Application["site_name"];
            pic = MainData.Pic;
            Session["image"] = Session["websiteurl"] + pic;
            pic = "<a href=\"" + pic + "\">" + "<img class=\"image-full modal-image size-full\" src=\"" + pic + "\" width=\"1350\" height=\"900\" /></a>";
            postday = MainData.PostDay.ToString("yyyy/MM/dd");
            contents = MainData.Contents;
            keywords = article.Web.Get_Keyword_link (  MainData.Keywords );
            Session["description"] = unity.classlib .noHTML (contents);
            Session["keywords"] = MainData.Keywords;
          
            viewcount = MainData.Viewcount.ToString();
            tags = article.Web.Get_category_link(MainData.Id);
            author = article.Web.Get_author_link(MainData.Author );
            ItemData = article.DbHandle. Get_article_item(MainData.Id);
            foreach (var s in ItemData)
            {
                contents += "<h2>" +  s.Title + "</h2>";
                contents += s.Contents;
            }
            article.DbHandle.Add_views(MainData.Id);

            List<article.MainData> hotlist = new List<article.MainData>();
            hotlist = article.DbHandle.Get_article_list("", "", 5, 1);
            extended_list.DataSource = hotlist;
            extended_list.DataBind();

            DataTable dt;
            string strsql = "select* from tbl_article_file where  status <> 'D' and  (articleid =@articleid or tempid=@articleId) and kind='F' order by sort";
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("articleid", MainData.Id.ToString());
            dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count > 0)
            {
                Repeater_file.DataSource = dt;
                Repeater_file.DataBind();
            }
            dt.Dispose();
            nvc.Clear();

            List<article.Category>  cate = new List<article.Category >();
            cate = (List<article.Category>) article.DbHandle.Get_article_category(MainData.Id );   
            foreach (var a in cate)
            {              
              
                cid = a.CategoryId.ToString  ();
                pagetitle = Unitlib.Get_title((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));
                Session["active"] = Unitlib.Set_activeId((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));            
                Breadcrumb = Unitlib.Get_Breadcrumb((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));
                break;
              
            }

            if (Session["memberdata"] != null)
            {
                MemberLib.Mmemberdata o = (MemberLib.Mmemberdata) Session["memberdata"];
                iscollection = MemberLib.Member.Is_collection(o.Memberid.ToString (), MainData.Id.ToString ())=="Y"? " active ":"";
                


            }
        }
    }
}