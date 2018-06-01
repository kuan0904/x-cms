﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Routing;

public partial class list : System.Web.UI.Page
{
    public static  int Totalrow  = 0;
    public static int Pagecount = 0;
    public static int PageSize = 5;
    public static int PageIdx = 1;
    public static string unitname = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string cid = "";
        Route myRoute = RouteData.Route as Route;
        if (myRoute != null)
        {
    
            PageIdx  = RouteData.Values["pageindex"]==null ? 1:int.Parse ( RouteData.Values["pageindex"].ToString () );
             cid =  RouteData.Values["id"].ToString ();
           
        }
        else
        {
            cid = Request.QueryString["cid"];
            PageIdx = Request.QueryString["pageindex"] == null ? 1 : int.Parse (Request.QueryString["pageindex"]);
        }
       // string[] Segments = Request.Url.Segments;
       // foreach (string s in Segments)
       // {
       //     Response.Write(s + "<BR>");
       // }
       // string idx = Segments[Segments.Length - 1];
      
       // if (int.TryParse(idx, out PageIdx))
       // {
       //     int.TryParse(idx, out PageIdx);
                      
       // }
       // else
       // {
       //     PageIdx = 1;
       //    cid= Segments[Segments.Length - 2];

       // }
       //cid = kind.Replace("/", "");
        unitname =  cid + "/catalog";
      
        List<Banner.MainData> banner1 = new List<Banner.MainData>();
        banner1 = Banner.DbHandle.Banner_Get_list(1);
        Repeater1.DataSource = banner1;
        Repeater1.DataBind();
        banner1.Clear();
     
        List<article.MainData> hotlist = new List<article.MainData>();  
        hotlist = article.DbHandle.Get_article_list(cid, "", PageSize, PageIdx);
       
        foreach (var p in hotlist)
        {
            Totalrow  = p.TotalRows;
            break;
        }

        hot_list_detail.DataSource = hotlist;
        hot_list_detail.DataBind();
        hotlist.Clear();
    }

    public static string PagePaging()
    {
        string retmsg = "";
        Pagecount = Totalrow / PageSize + (Totalrow % PageSize > 0 ? 1 : 0);
        int i = 0;

        retmsg +="<li class=\"page-item\"><a class=\"page-link\" href=\"/"+ unitname + "/" + (PageIdx <= 1 ? Pagecount  : PageIdx -1 ) + "\" aria-label=\"Previous\"><span aria-hidden=\"true\">«</span><span class=\"sr-only\">Previous</span></a></li>";
        for (i =1;i<= Pagecount; i++)
        {
            
            retmsg += "<li class=\"page-item"  + ( i==PageIdx ? " active" : "") + "\"><a class=\"page-link\" href=\"/"+ unitname + "/" + i  +"\">"+ i +"</a></li>";
        }

        retmsg += "<li class=\"page-item\"><a class=\"page-link\" href=\"/" + unitname + "/" +  (PageIdx >=Pagecount ? PageIdx +1 : 1 ) +  "\" aria-label=\"Next\"><span aria-hidden=\"true\">»</span><span class=\"sr-only\">Next</span></a></li>";
              
        return retmsg;
    }

}