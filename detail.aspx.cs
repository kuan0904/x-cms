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
using System.Text.RegularExpressions;
public partial class detail : System.Web.UI.Page
{
    public Unitlib.WebsiteData m = new Unitlib.WebsiteData();

    public string iscollection = "";
    public string Breadcrumb = "";
    public string subject = "";
    public string subtitle = "";
    public string contents = "";
    public string pic = "";
    public string postday = "";
    public string keywords = "";
    public string viewcount = "";
    public string tags = "";
    public string pagetitle = "";
    public string pageunit = "";
    public string author = "";
    public string cid = "";
    public string flag = "";
    public string Articleid = "";
    protected void Page_LoadComplete(object sender, EventArgs e)
    {       
       
        ASP.masterpage_master P  = this.Master as ASP.masterpage_master;
        P.active = cid;
      
     
    }
    protected void Page_Load(object sender, EventArgs e)
    {
       
        Unitlib.WebsiteData m = new Unitlib.WebsiteData();


        Articleid = Request.QueryString["Articleid"];
        Route myRoute = RouteData.Route as Route;     
        if (myRoute != null )
        {
            Articleid = RouteData.Values["Articleid"].ToString();          
        }
    
        article.MainData MainData = new article.MainData();
        List<article.ItemData> ItemData = new List<article.ItemData>() ;
     
        if (Articleid != null)
        {
            MainData = article.DbHandle.Get_article(int.Parse(Articleid));
        }
        else if (Session["MainData"] != null)
        {

            MainData = HttpContext.Current.Session["MainData"] as article.MainData;
        }

        if (MainData != null)
        {
          
            if (MainData.kind =="Y" || MainData.kind == "L") Response.Redirect("/Class/" + MainData.Id );
            subject = MainData.Subject;
            subtitle = MainData.SubTitle ;
            if (subtitle != "") subtitle = "<blockquote><p>" + subtitle + "</p></blockquote>";
            Session["title"] = subject + "│" + Application["site_name"];
            pic = MainData.Pic.IndexOf ("/") <0 ? "/webimages/article/" + MainData.Pic : MainData.Pic;
            Session["image"] = Session["websiteurl"] + pic;
            pic = "<a href=\"" + pic + "\">" + "<img class=\"image-full modal-image size-full\" src=\"" + pic + "\" width=\"1350\" height=\"900\" /></a>";
            postday = MainData.PostDay.ToString("yyyy/MM/dd");
            contents = MainData.Contents;
            keywords = article.Web.Get_Keyword_link (  MainData.Keywords );
            Session["description"] = unity.classlib .noHTML (contents);
            Session["keywords"] = MainData.Keywords;
            flag = MainData.Flag;
            if (MainData.YoutubeUrl != "")
            {
                Match regexMatch = Regex.Match(MainData.YoutubeUrl, "^[^v]+v=(.{11}).*",
                        RegexOptions.IgnoreCase);
                string v = regexMatch.Groups[1].Value;
                FatchU2BUtility util = new FatchU2BUtility(MainData.YoutubeUrl);
                pic = " <iframe width = \"853\" height = \"480\" src = \"https://www.youtube.com/embed/"+ v +"\" frameborder = \"0\" allow = \"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen ></iframe >";

            }
            viewcount = MainData.Viewcount.ToString();
            tags = article.Web.Get_category_link(MainData.Id);
            author = article.Web.Get_author_link(MainData.Author );
            ItemData = article.DbHandle. Get_article_item(MainData.Id);
            foreach (var s in ItemData)
            {
                contents += "<h2>" +  s.Title + "</h2>";
                contents += s.Contents;
            }
            article.DbHandle.Add_views(MainData.Id);

            List<article.MainData> hotlist = new List<article.MainData>();
            hotlist = article.DbHandle.Get_article_list("", "", 5, 1);

            if (MainData.NextRead != "" && MainData.NextRead != null)
            {
                List<article.MainData> nextlist = new List<article.MainData>();
                string[] nextread = MainData.NextRead.Split(',');

                int i = 0;
                foreach (string n in nextread)
                {

                    nextlist = article.DbHandle.Get_article_list("", n.Trim(), 1, 1);
                    if (nextlist.Count != 0)
                    {

                        var itemToRemove = hotlist.Find(r => r.Id == nextlist[0].Id);
                        if (itemToRemove != null) hotlist.Remove(itemToRemove);
                        hotlist.Insert(i, nextlist.FirstOrDefault());
                        i++;
                    }
                    nextlist.Clear();
                }

            }
            extended_list.DataSource = hotlist;
            extended_list.DataBind();

            DataTable dt;
            string strsql = "select* from tbl_article_file where  status <> 'D' and  (articleid =@articleid or tempid=@articleId) and kind='F' order by sort";
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("articleid", MainData.Id.ToString());
            dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count > 0)
            {
                Repeater_file.DataSource = dt;
                Repeater_file.DataBind();
            }
            dt.Dispose();
            nvc.Clear();

            List<article.Category>  cate = new List<article.Category >();
            cate = (List<article.Category>) article.DbHandle.Get_article_category(MainData.Id );   
            foreach (var a in cate)
            {              
              
                cid = a.CategoryId.ToString  ();
                pagetitle = Unitlib.Get_title((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));
                Session["active"] = Unitlib.Set_activeId((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));            
                Breadcrumb = Unitlib.Get_Breadcrumb((List<Unitlib.MenuModel>)Session["webmenu"], int.Parse(cid));
                break;
              
            }

            if (Session["memberdata"] != null && Session["memberdata"].ToString () != "")
            {
                MemberLib.Mmemberdata o = (MemberLib.Mmemberdata) Session["memberdata"];
                iscollection = MemberLib.Member.Is_collection(o.Memberid.ToString (), MainData.Id.ToString ())=="Y"? " active ":"";
                


            }
        }
    }
}

public class FatchU2BUtility
{

    public string YoutubeURL { get; private set; }
    public string Id { get; private set; }
    public string Title { get; private set; }
    public string Intro { get; private set; }
    public string ImageLarge { get; private set; }
    public string ImageSmall { get; private set; }

    public FatchU2BUtility(string youtubeURL)
    {
        // <p id="eow-description" >

        var src =youtubeURL;
        var regexIntro = new Regex(
           @"(p id=""eow-description"" >)(?<INTRO>.*?)(</p>)",
            RegexOptions.IgnoreCase);
        MatchCollection mcIntro = regexIntro.Matches(src);

        //<meta name="title" content="
        var regexTitle = new Regex(
          @"(<meta name=""title"" content="")(?<TITLE>.*?)("">)",
           RegexOptions.IgnoreCase);
        MatchCollection mcTitle = regexTitle.Matches(src);



        var regexId = new Regex(
         @"(data-button-menu-id=""some-nonexistent-menu"" data-video-id="")(?<ID>.*?)("")",
          RegexOptions.IgnoreCase);
        MatchCollection mcId = regexId.Matches(src);


        if (mcIntro.Count != 0)
            Intro = mcIntro[0].Groups["INTRO"].Value;
        else
            throw new Exception("Can't find Intro");

        if (mcTitle.Count != 0)

            Title = mcTitle[0].Groups["TITLE"].Value;
        else
            throw new Exception("Can't find Title");

        if (mcId.Count != 0)
            Id = mcId[0].Groups["ID"].Value;
        else
            throw new Exception("Can't find Id");


        ImageSmall = "http://img.youtube.com/vi/" + Id + "/2.jpg";
        ImageLarge = "http://img.youtube.com/vi/" + Id + "/0.jpg";

        YoutubeURL = "http://www.youtube.com/watch?v=" + Id;


    }


}