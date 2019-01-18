using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using System.Data;
using System.Linq;
public partial class process_step1 : System.Web.UI.Page
{
 
   
    public string postday = "";
    public string keywords = "";
    public string viewcount = "";
    public string tags = "";
    public string pagetitle = "";
    public string pageunit = "";
    public string author = "";
    public string lessonid = "";
    public string title = "";
    public string cid = "";
    public string Articleid = "";
    public int num = 0;
    public string status = "";
    public article.MainData MainData = new article.MainData();
    public article.LessonDetail lessondetail = new article.LessonDetail();
    protected void Page_Load(object sender, EventArgs e)
    {

        lessonid = Request.QueryString["lessonid"];
        Articleid = Request.QueryString["Articleid"];
        Route myRoute = RouteData.Route as Route;
        if (myRoute != null)
        {
            Articleid = RouteData.Values["ArticleId"].ToString();
            lessonid = RouteData.Values["lessonId"].ToString();
        }
 

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
          
            Session["title"] = MainData.Subject + "│" + Application["site_name"];
            Session["image"] = Session["websiteurl"] + MainData.Pic;
            List<article.Lesson> lesson = new List<article.Lesson>();
           
            if (MainData.Lesson.Id > 0)
            {
               
       
                lessondetail = MainData.Lesson.LessonDetail.Find(c => c.LessonId == int.Parse (lessonid));
                num = lessondetail.Limitnum - LessonLib.Web.Get_JoinNum(Articleid, lessonid);                     
                Lecturer = article.DbHandle.Get_Lecturer_list(MainData.Lesson.Lecturer);
          
                if (DateTime.Compare(DateTime.Today, MainData.Lesson.EndDay) > 0)
                {
                    status = "活動已結束";
                }
                else if (DateTime.Compare(DateTime.Today, lessondetail.Strdat) < 0)
                {
                    status = "報名未開始";

                }
                else if (MainData.Status !="Y")
                {
                    status = "無效課程資料";

                }
                else if (DateTime.Compare(DateTime.Today, lessondetail.Enddat) > 0)
                {
                    status = "報名己截止";

                }
                else if (num > 0)
                {
                    status = "";

                }
                else
                {
                    status = "額滿";
                }
               
            }

            keywords = article.Web.Get_Keyword_link(MainData.Keywords);
            viewcount = MainData.Viewcount.ToString();
            tags = article.Web.Get_category_link(MainData.Id);

            Session["description"] = unity.classlib.noHTML(MainData.Contents);
            Session["keywords"] = MainData.Keywords;
     

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