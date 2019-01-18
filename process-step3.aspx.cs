using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class process_step3 : System.Web.UI.Page
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
    public int totalprice = 0;
    public int totalnum = 0;
    public int num = 0;
    public string Articleid = "";
    public string cid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        article.MainData MainData = new article.MainData();
        MainData = HttpContext.Current.Session["MainData"] as article.MainData;
        List<article.Lecturer> Lecturer = new List<article.Lecturer>();
        List<article.LessonDetail> classdata = new List<article.LessonDetail>();
        List<LessonLib.JoinData> joindata = new List<LessonLib.JoinData>();
        if (MainData != null)
        {

            subject = MainData.Subject;
            Session["title"] = subject + "│" + Application["site_name"];
            pic = MainData.Pic;
            Session["image"] = Session["websiteurl"] + pic;
            List<article.Lesson> lesson = new List<article.Lesson>();
            List<article.LessonDetail> lessondetail = new List<article.LessonDetail>();
            if (MainData.Lesson.Id  > 0)
            {
                Articleid = MainData.Id.ToString();
                startday = MainData.Lesson.StartDay == null ? "" : MainData.Lesson.StartDay.ToString("yyyy/MM/dd");
                endday = MainData.Lesson.EndDay.ToString("yyyy/MM/dd");
                address = MainData.Lesson.Address;
                contents = MainData.Contents;
                lessondetail = MainData.Lesson.LessonDetail;
              
                lessontime = MainData.Lesson.Lessontime;
                Lecturer = article.DbHandle.Get_Lecturer_list(MainData.Lesson.Lecturer);

            }

            keywords = article.Web.Get_Keyword_link(MainData.Keywords);
            viewcount = MainData.Viewcount.ToString();
            tags = article.Web.Get_category_link(MainData.Id);

            Session["description"] = unity.classlib.noHTML(contents);
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

            string[] joinnum = Request.Form["joinnum"].Split(',');
            string[] lessonid = Request.Form["lessonid"].Split(',');
            int i = 0;
            foreach (string s in joinnum)
            {
                if (joinnum[i] != "0")
                {
                    article.LessonDetail ItemData = (article.LessonDetail)LessonLib.DbHandle.Get_LessonClass(int.Parse(lessonid[i]));
                    classdata.Add(new article.LessonDetail
                    {
                        Id = (int)ItemData.Id,
                        Description = (string)ItemData.Description,
                        Price = (int)ItemData.Price,
                        Sellprice = (int)ItemData.Sellprice,
                        Limitnum= int.Parse(joinnum[i])
                    });
                    int j = 0;
                    for (j = 1; j <= int.Parse(joinnum[i]); j++)
                    {

                        joindata.Add(new LessonLib.JoinData
                        {
                            Id = int.Parse(lessonid[i])



                        });
                    }
                    totalnum += int.Parse(joinnum[i]);
                    totalprice += (int)ItemData.Sellprice * int.Parse(joinnum[i]);
                }
                i++;
            }
            num = classdata.Count;
            Repeater1.DataSource = classdata;
            Repeater1.DataBind();
        }
    }
}