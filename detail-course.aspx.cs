﻿using System;
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
   public  string address = "";
    protected void Page_Load(object sender, EventArgs e)
    {

      
        string Articlid = Request.QueryString["id"];
        Route myRoute = RouteData.Route as Route;
        if (myRoute != null)
        {

            Articlid = RouteData.Values["id"].ToString();
            // string verder = (string)Page.RouteData.Values["verder"];
        }

        article.MainData MainData = new article.MainData();
        List<article.Lecturer> Lecturer = new List<article.Lecturer>();

        if (Articlid != null && Articlid !="0")
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
            pic = "/webimages/article/" + MainData.Pic;
            pic = "<a href=\"" + pic + "\">" + "<img class=\"image-full modal-image size-full\" src=\"" + pic + "\" width=\"1350\" height=\"900\" /></a>";
            List<article.Lesson> lesson = new List<article.Lesson>();
            List<article.LessonDetail> lessondetail = new List<article.LessonDetail>();

            startday = MainData.Lesson [0].StartDay  .ToString("yyyy/MM/dd");
            endday = MainData.Lesson[0].EndDay. ToString("yyyy/MM/dd");
            contents = MainData.Contents;
            keywords = article.Web.Get_Keyword_link(MainData.Keywords);
            viewcount = MainData.Viewcount.ToString();
            tags = article.Web.Get_category_link(MainData.Id);
            lessontime = article.Web.Get_author_link(MainData.Lesson[0].Lessontime);
            address = MainData.Lesson[0].Address;
            //sellprice = MainData.Sellprice.ToString ();
            //price = MainData.Price.ToString ();
            Lecturer = article.DbHandle.Get_Lecturer_list(MainData.Lesson[0].Lecturer);
            lessondetail = MainData.Lesson[0].LessonDetail;
            Repeater1.DataSource = Lecturer;
            Repeater1.DataBind();
            Repeater2.DataSource = lessondetail;
            Repeater2.DataBind();
            article.DbHandle.Add_views(MainData.Id);

            List<article.Category> cate = new List<article.Category>();
            cate = (List<article.Category>)article.DbHandle.Get_article_category(MainData.Id, "list");

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

        }
    }
}