using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections.Specialized;
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
    public string cid = "";
    public string ord_code = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string ord_date = DateTime.Today.ToString("yyyy/MM/dd");
        ord_code = OrderLib.Get_ord_code(ord_date);
        article.MainData MainData = new article.MainData();
        string paymode = Request["paymode"];
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

                cid = a.CategoryId.ToString();
                pagetitle = Unitlib.Get_title((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));
                Session["active"] = Unitlib.Set_activeId((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));
                //   Breadcrumb = Unitlib.Get_Breadcrumb((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));
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
                        LessonId = int.Parse(lessonid[j]),
                        Name = cname[j],
                        Phone = cphone[j],
                        Email = cemail[j],
                        Amount = int.Parse(sellprice[j]),

                    });
                   
                }
                i++;
            }
            num = classdata.Count;
            //Repeater1.DataSource = classdata;
            //Repeater1.DataBind();
           
          
            int ship_free = 0;
            string memberid = "0";
            if (Session["memberdata"] != null)
            {
                MemberLib.Mmemberdata m = (MemberLib.Mmemberdata) Session["memberdata"];
                memberid = m.Memberid.ToString();
            }
            OrderLib.OrderData o = new OrderLib.OrderData
            { 
                Ord_code = ord_code ,
                Ord_id = 0,
                Memberid =memberid ,
                Paymode = paymode,
                Invoice="",
                Contents="",
                ShipPrice= ship_free,
                Discount = 0,
                TotalPrice=totalprice ,              
                Delivery_kind="",
                Orddate =DateTime.Today ,
                Companyno="",
                Title="",
                ReceiveTime="",
                coupon_no="",
                Paid="",
                Status="N",
                SubPrice=totalprice,
                Ordname =Request["cname"],
                Ordgender="",
                Ordemail=Request ["cemail"],
                Ordphone = Request["cphone"],
                Ordzip="",
                Ordaddress="",
                Shipname="",
                Shipphone="",
                Shipzip="",
                Shipaddress ="",
                Shipgender="",
                Ordcityid = new OrderLib.ItemData() { Id=0,Name=""},
                Ordcountyid  = new OrderLib.ItemData() { Id = 0, Name = "" },
                Shipcity = new OrderLib.ItemData() { Id = 0, Name = "" },
                Shipcounty = new OrderLib.ItemData() { Id = 0, Name = "" },
            };
            o = OrderLib.AddOrdData (o);
           
            LessonLib.JoinData jdata = new LessonLib.JoinData
            {
                Ord_code =ord_code ,
                Articleid = MainData.Id,              
                TicketKind = Request.Form["kind"],           
                JoinLists = item
            };



            LessonLib.DbHandle.JoinAdd(jdata);
        }
    }

   
}