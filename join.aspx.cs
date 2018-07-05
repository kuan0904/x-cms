using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class join : System.Web.UI.Page
{
    public string lessonid = "";
    public string subject = "";
    public string sellprice = "0";
    public string price = "0";
    public string limitnum = "0";
    protected void Page_Load(object sender, EventArgs e)
    {
        string Articlid = "";
        lessonid = Request.QueryString["lessonid"];
        if (lessonid == null) Response.Redirect("/index");
        article. LessonDetail detail = new article.LessonDetail();
        detail = article.DbHandle.Get_Lesson(int.Parse(lessonid));
        Articlid = detail.Id.ToString() ;
        price = detail.Price.ToString();
        sellprice = detail.Sellprice.ToString();
        limitnum = detail.Limitnum.ToString();
        article.MainData MainData = new article.MainData();
        List<article.Lecturer> Lecturer = new List<article.Lecturer>();

        if (Articlid != null && Articlid != "0")
        {
            MainData = article.DbHandle.Get_article(int.Parse(Articlid));
        }
        else if (Session["MainData"] != null)
        {

            MainData = HttpContext.Current.Session["MainData"] as article.MainData;
        }
        if (MainData != null)
        {

            subject = MainData.Subject;
     

          

      

        }
    }
}