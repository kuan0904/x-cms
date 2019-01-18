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
public partial class detail_course_ : System.Web.UI.Page
{
    public Unitlib.MainData s = new Unitlib.MainData();
    public string pic = "";
    public string postday = "";
    public string keywords = "";
    public string viewcount = "";
    public string tags = "";
    public string pagetitle = "";
    public string pageunit = "";
    public string author = "";
    public string lessonid = "";
    public string title = "";
    public article.MainData MainData = new article.MainData();
    public string Articleid = "";
    public string status = "";
    public List<article.Lesson> lesson = new List<article.Lesson>();
  
    protected void Page_Load(object sender, EventArgs e)
    {      
      
        Articleid = Request.QueryString["Articleid"];
        Route myRoute = RouteData.Route as Route;
        if (myRoute != null) Articleid = RouteData.Values["Articleid"].ToString();  
        List<article.Lecturer> Lecturer = new List<article.Lecturer>();
        if (Articleid != null && Articleid !="0")
        {
            MainData = article.DbHandle.Get_article(int.Parse(Articleid));
          
        }
        else if (Session["MainData"] != null)
        {
          
            MainData = HttpContext.Current.Session["MainData"] as article.MainData;
        }
        if (MainData != null)
        {
            status = MainData.Status;        
            Session["title"] = MainData.Subject + "│" + Application["site_name"];
            pic =   MainData.Pic;
            Session["image"] = Session["websiteurl"] + pic;
            pic = "<a href=\"" + pic + "\">" + "<img class=\"image-full modal-image size-full\" src=\"" + pic + "\" width=\"1350\" height=\"900\" /></a>";
            if (MainData.Lesson.Id  > 0)
            {
                //lessondetail = MainData.Lesson.LessonDetail;
                //if ( DateTime.Compare(DateTime.Today, MainData.Lesson.EndDay) <= 0)
                // lessondetail = MainData.Lesson.LessonDetail.Find(x => x.Flag == "Y");

                Repeater2.DataSource = MainData.Lesson.LessonDetail.FindAll(x => x.Flag == "Y");
                Repeater2.DataBind();
                //}
                //else
                //{
                //    Repeater3.DataSource = MainData.Lesson.LessonDetail;
                //    Repeater3.DataBind();
                //}

              
                Lecturer = article.DbHandle.Get_Lecturer_list(MainData.Lesson.Lecturer);
                Repeater1.DataSource = Lecturer;
                Repeater1.DataBind();
            }  
          
            keywords = article.Web.Get_Keyword_link(MainData.Keywords);
            viewcount = MainData.Viewcount.ToString();
            tags = article.Web.Get_category_link(MainData.Id);
            Session["description"] = unity.classlib.noHTML(MainData.Contents);
            Session["keywords"] = MainData.Keywords;
            article.DbHandle.Add_views(MainData.Id);
            List<article.Category> cate = new List<article.Category>();
            cate = (List<article.Category>)article.DbHandle.Get_article_category(MainData.Id);
            foreach (var a in cate)
            {
                List<Unitlib.MenuModel> subMenu = (List<Unitlib.MenuModel>)Session["webmenu"];
                var data = subMenu.SelectMany(x => x.Detial).FirstOrDefault(c => c.Id == a.CategoryId);
                if (data != null)
                {
                    var p = subMenu.Find(x => x.Id == data.ParentId);
                    if (p != null)
                    {
                        pageunit += "<li class=\"active\"><a href=\"/catalog/" + p.Id.ToString() + "\">" + p.Title.ToString() + "</a></li>";
                    }
                    pageunit += "<li class=\"active\"><a href=\"/catalog/" + data.Id.ToString() + "\">" + data.Title.ToString() + "</a></li>";
                }

                break;

            }
      

        }


        s = Unitlib.Get_UnitData(37, "");



    }
    public static string  Get_joinnum(article.MainData MainData, string lessonId)
    {
        string result = "";
        var lessondetail = MainData.Lesson.LessonDetail.Find(c => c.LessonId == int.Parse(lessonId));
        int num = lessondetail.Limitnum - LessonLib.Web.Get_JoinNum(MainData.Id.ToString () , lessonId);
        if (DateTime.Compare(DateTime.Today, MainData.Lesson.EndDay) > 0)
        {
            result = "<a href = \"#\" class=\"btn btn-danger btn-block\"  >活動已結束</a>";
        }
        else if (DateTime.Compare(DateTime.Today, lessondetail.Strdat  ) < 0)
        {
            result = "<a href =\"#\" class=\"btn btn-danger btn-block\"  >報名未開始</a>";

        }
        else if (DateTime.Compare(DateTime.Today, lessondetail.Enddat ) > 0)
        {
            result = "<a href =\"#\" class=\"btn btn-danger btn-block\"  >報名己截止</a>";

        }
        else if (  num >0)
        {
            result = "<a href =\"/class/Article/" + MainData.Id.ToString() + "/lesson/" + lessonId + "\" class=\"btn btn-danger btn-block\"  >立即報名</a>";

        }
        else
        {
            result = "<a href =\"#\" class=\"btn btn-danger btn-block\"  >額滿</a>";
        }
        return result;
    }
}
