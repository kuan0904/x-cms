using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class process_step4 : System.Web.UI.Page
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

    protected void Page_Load(object sender, EventArgs e)
    {
        article.MainData MainData = new article.MainData();
        MainData = HttpContext.Current.Session["MainData"] as article.MainData;
        List<article.Lecturer> Lecturer = new List<article.Lecturer>();
        List<LessonLib.ItemData> classdata = new List<LessonLib.ItemData>();
        List<LessonLib.JoinData> joindata = new List<LessonLib.JoinData>();
        if (MainData != null)
        {

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
                lessontime = MainData.Lesson[0].Lessontime;
                Lecturer = article.DbHandle.Get_Lecturer_list(MainData.Lesson[0].Lecturer);

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
                DataTable dt, dt1;
                dt = (DataTable)Application["category"];
                dt.DefaultView.RowFilter = "categoryid=" + a.CategoryId;

                dt1 = dt.DefaultView.ToTable();
                pageunit = "<li class=\"active\"><a href=\"/" + dt1.Rows[0]["CategoryId"].ToString() + "/catalog\">" + dt1.Rows[0]["title"].ToString() + "</a></li>";
                if (dt1.Rows[0]["parentid"].ToString() != "0")
                {
                    dt.DefaultView.RowFilter = "categoryid=" + dt1.Rows[0]["parentid"].ToString();
                    dt1 = dt.DefaultView.ToTable();
                    pageunit = "<li><a href=\"/" + dt1.Rows[0]["CategoryId"].ToString() + "/catalog\">" + dt1.Rows[0]["title"].ToString() + "</a></li>" + pageunit;
                    dt1.Dispose();
                    dt.Dispose();

                }
                break;
            }

            string[] joinnum = Request.Form["joinnum"].Split(',');
            string[] lessonid = Request.Form["lessonid"].Split(',');
            List<LessonLib.JoinList> item = new List<LessonLib.JoinList>();
            string[] cname = Request.Form["name"].Split(',');
            string[] cphone = Request.Form["phone"].Split(',');
            string[] cemail = Request.Form["email"].Split(',');
            string[] sellprice = Request.Form["sellprice"].Split(',');
            int i = 0;
            foreach (string s in joinnum)
            {
                if (joinnum[i] != "0")
                {
                    LessonLib.ItemData ItemData = (LessonLib.ItemData)LessonLib.DbHandle.Get_LessonClass(int.Parse(lessonid[i]));
                    classdata.Add(new LessonLib.ItemData
                    {
                        Id = (int)ItemData.Id,
                        Description = (string)ItemData.Description,
                        Price = (int)ItemData.Price,
                        Sellprice = (int)ItemData.Sellprice,
                        Num = int.Parse(joinnum[i])
                    });                  
                    totalnum += int.Parse(joinnum[i]);
                    totalprice += (int)ItemData.Sellprice * int.Parse(joinnum[i]);
                }
                int j = 0;
                for (j = 0; j <int.Parse ( joinnum[i]); j++)
                {

                    item.Add(new LessonLib.JoinList
                    {
                        LessonId = int.Parse(lessonid[i]),
                        Name = cname[i],
                        Phone = cphone[i],
                        Email = cemail[i],
                       Amount = int.Parse(sellprice[i]),

                    });
                }
                i++;
            }
            num = classdata.Count;
            //Repeater1.DataSource = classdata;
            //Repeater1.DataBind();
         
       
         

            LessonLib.JoinData jdata = new LessonLib.JoinData();
            jdata.Articleid = MainData.Id;
            jdata.Email = Request.Form["cemail"];
            jdata.Phone = Request.Form["cphone"];
            jdata.Name = Request.Form["cname"];
            jdata.Paymode = Request.Form["paymode"];
            jdata.TicketKind = Request.Form["kind"];
            jdata.TotalPrice = totalprice;
            jdata.JoinLists = item;


         
            LessonLib.DbHandle.JoinAdd(jdata);
        }
    }


}