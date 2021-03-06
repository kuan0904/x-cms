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
public partial class list : System.Web.UI.Page
{
    public static int Totalrow = 0;
    public static int Pagecount = 0;
    public static int PageSize = 5;
    public static int PageIdx = 1;
    public static string unitname = "";
    public string pagetitle = "";
    public string Breadcrumb = "";
    protected void Page_Init(object sender, EventArgs e)
    {
        Session["description"] = Application["description"];
        Session["keywords"] = Application["keywords"];
        Session["image"] = Session["websiteurl"] + "/images/fbShare.jpg";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string cid = "";
        Route myRoute = RouteData.Route as Route;
        if (myRoute != null)
        {
            PageIdx = RouteData.Values["pageindex"] == null ? 1 : int.Parse(RouteData.Values["pageindex"].ToString());
            cid = RouteData.Values["cid"].ToString();
        }
        else
        {
            cid = Request.QueryString["cid"];
            PageIdx = Request.QueryString["pageindex"] == null ? 1 : int.Parse(Request.QueryString["pageindex"]);
        }

        if (cid == null) Response.Redirect("/index");
        unitname = "/catalog/" + cid;
        //List<Banner.MainData> banner1 = new List<Banner.MainData>();
        //if (Request.QueryString["kind"] == "preview")
        //    banner1 = Banner.DbHandle.Banner_Get_list(1, "preview");
        //else
        //    banner1 = Banner.DbHandle.Banner_Get_list(1);


        List<article.MainData> hotlist = new List<article.MainData>();
        hotlist = article.Web.Recommend_list(int.Parse (cid));      
        Repeaterbanner.DataSource = hotlist;
        Repeaterbanner.DataBind(); 


        hotlist = article.DbHandle.Get_article_list(cid, "", PageSize, PageIdx);
        foreach (var t in hotlist)
        {
            Totalrow = t.TotalRows;
            break;
        }
        hot_list_detail.DataSource = hotlist;
        hot_list_detail.DataBind();
        hotlist.Clear();
       // hotlist = article.DbHandle.Get_article_list("1,2,3,4,5,6", "",5,1);
        pagetitle = Unitlib.Get_title((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));
        Session["active"] = Unitlib.Set_activeId((List<Unitlib.MenuModel>)Session["webmenu"] , int.Parse(cid));  
        Session["title"] = pagetitle + "│" + Application["site_name"];
        Breadcrumb = Unitlib.Get_Breadcrumb((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));

    }

    public static string PagePaging()
    {
        string retmsg = "";
        Pagecount = Totalrow / PageSize + (Totalrow % PageSize > 0 ? 1 : 0);
        int i = 0;

        retmsg +="<li class=\"page-item\"><a class=\"page-link\" href=\""+ unitname + "/page/" + (PageIdx <= 1 ? Pagecount  : PageIdx -1 ) + "\" aria-label=\"Previous\"><span aria-hidden=\"true\">«</span><span class=\"sr-only\">Previous</span></a></li>";
        for (i =1;i<= Pagecount; i++)
        {
            
            retmsg += "<li class=\"page-item"  + ( i==PageIdx ? " active" : "") + "\"><a class=\"page-link\" href=\""+ unitname + "/page/" + i  +"\">"+ i +"</a></li>";
        }

        retmsg += "<li class=\"page-item\"><a class=\"page-link\" href=\"" + unitname + "/page/" +  (PageIdx >=Pagecount ? PageIdx +1 : 1 ) +  "\" aria-label=\"Next\"><span aria-hidden=\"true\">»</span><span class=\"sr-only\">Next</span></a></li>";
              
        return retmsg;
    }

}