using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using System.Data;
using System.Linq;
public partial class process_step1 : System.Web.UI.Page
{
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
    public string lessonid = "";
    public string startday = "";
    public string endday = "";
    public string lessontime = "";
    public string price = "";
    public string sellprice = "";
    public string title = "";
    public string address = "";
    public string cid = "";
    protected void Page_Load(object sender, EventArgs e)
    {


        string Articleid = Request.QueryString["Articleid"];
        Route myRoute = RouteData.Route as Route;
        if (myRoute != null)
        {

            Articleid = RouteData.Values["Articleid"].ToString();
            // string verder = (string)Page.RouteData.Values["verder"];
        }

        article.MainData MainData = new article.MainData();
        List<article.Lecturer> Lecturer = new List<article.Lecturer>();

        if (Articleid != null && Articleid != "0")
        {
            MainData = article.DbHandle.Get_article(int.Parse(Articleid));
        }
        else if (Session["MainData"] != null)
        {

            MainData = HttpContext.Current.Session["MainData"] as article.MainData;
        }
        if (MainData != null)
        {
            Session["MainData"] = MainData;
            subject = MainData.Subject;
            Session["title"] = subject + "│" + Application["site_name"];
            pic = MainData.Pic;
            Session["image"] = Session["websiteurl"] + pic;
              List<article.Lesson> lesson = new List<article.Lesson>();
            List<article.LessonDetail> lessondetail = new List<article.LessonDetail>();
            if (MainData.Lesson.Count > 0)
            {
                startday = MainData.Lesson[0].StartDay == null ? "" : MainData.Lesson[0].StartDay.ToString("yyyy/MM/dd");
                endday = MainData.Lesson[0].EndDay.ToString("yyyy/MM/dd");
                address = MainData.Lesson[0].Address;
                contents = MainData.Contents;
                lessondetail = MainData.Lesson[0].LessonDetail;
                Repeater2.DataSource = lessondetail;
                Repeater2.DataBind();
                lessontime = MainData.Lesson[0].Lessontime;
                Lecturer = article.DbHandle.Get_Lecturer_list(MainData.Lesson[0].Lecturer);
                //Repeater1.DataSource = Lecturer;
                //Repeater1.DataBind();
            }

            keywords = article.Web.Get_Keyword_link(MainData.Keywords);
            viewcount = MainData.Viewcount.ToString();
            tags = article.Web.Get_category_link(MainData.Id);

            Session["description"] = unity.classlib.noHTML(contents);
            Session["keywords"] = MainData.Keywords;
            article.DbHandle.Add_views(MainData.Id);

        

            List<article.Category> cate = new List<article.Category>();
            cate = (List<article.Category>)article.DbHandle.Get_article_category(MainData.Id);
            foreach (var a in cate)
            {

                cid = a.CategoryId.ToString();
                pagetitle = Unitlib.Get_title((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));
                Session["active"] = Unitlib.Set_activeId((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));
             //   Breadcrumb = Unitlib.Get_Breadcrumb((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));
                break;

            }

        }
    }
}