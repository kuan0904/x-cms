using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
using System.Collections.Specialized;
using article;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;

public partial class spadmin_article : System.Web.UI.Page
{
    public string articleId = "";
    public article.MainData mainData;
    public string lesson = "";
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Request.QueryString["articleId"] != null)
        {
            articleId = Request.QueryString["articleId"];
          
        }
        lesson = Request.QueryString["lesson"];

    }
    protected void Page_Load(object sender, EventArgs e)
    {
         
    
    
    }
    [WebMethod]    
    public static string get_tag()
    {
        string result = "{ \"main\":[";     
        string strsql = "SELECT *  FROM tbl_tag where status='Y' and unitid=13 ";
        NameValueCollection nvc = new NameValueCollection();
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        //result = JsonConvert.SerializeObject(dt);
        int i = 0;
        for (i = 0; i < dt.Rows.Count; i++)
        {
            if (i != 0) result += ",";
            result += "{\"name\":\"" + dt.Rows[i]["tagname"].ToString() + "\",\"id\":\"" + dt.Rows[i]["tagid"].ToString() + "\"}";

        }
        //result = result.Replace("[", "").Replace("]", "").Replace("\r\n", "");
        // result = JsonConvert.SerializeObject(result);
        dt.Dispose();      
        result += "]}";
       return (result);

    }
    [WebMethod]
    public static string get_lecturer()    {
        string result = "{ \"main\":[";    
            string strsql = "SELECT *  FROM tbl_tag where status='Y' and unitid=14 ";
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            //result = JsonConvert.SerializeObject(dt);
            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {
                if (i != 0) result += ",";
                result += "{\"name\":\"" + dt.Rows[i]["tagname"].ToString() + "\",\"id\":\"" + dt.Rows[i]["tagid"].ToString() + "\",\"pic\":\"" + dt.Rows[i]["pic"].ToString() + "\"}";

            }  
            dt.Dispose();       
        result += "]}";
        return (result);

    }

    [WebMethod]
    public static string get_category(string kind,string classid)    {
        string result = "{ \"main\":[";
        if (kind == "get")
        {
            string strsql = "SELECT *  FROM  tbl_category  where status<> 'D' and  parentid =0  and classid=@classid";
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("classid", classid);
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            //result = JsonConvert.SerializeObject(dt);
            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {
                if (i != 0) result += ",";
                result += "{\"name\":\"" + dt.Rows[i]["title"].ToString() + "\",\"id\":\"" + dt.Rows[i]["categoryid"].ToString() + "\"";
                result += ",\"detail\":[";
                strsql = "SELECT *  FROM  tbl_category  where status<> 'D' and  parentid ="+ dt.Rows[i]["categoryid"].ToString()   ;
                nvc = new NameValueCollection();
                DataTable dt1 = DbControl.Data_Get(strsql, nvc);
                int j = 0;
                for (j = 0; j < dt1.Rows.Count; j++)
                {
                    if (j != 0) result += ",";
                    result += "{\"name\":\"" + dt1.Rows[j]["title"].ToString() + "\",\"id\":\"" + dt1.Rows[j]["categoryid"].ToString() + "\"}";
                }
                dt1.Dispose();
              
                result += "]}";
            }
            //result = result.Replace("[", "").Replace("]", "").Replace("\r\n", "");
            // result = JsonConvert.SerializeObject(result);
            dt.Dispose();
        }
        result += "]}";
        return (result);

    }
    [WebMethod]
    public static string get_lesson(string kind)
    {
        string result = "{ \"main\":[";

        if (kind == "get")
        {
            string strsql = "SELECT *  FROM tbl_Lesson where status='Y'  ";
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            //result = JsonConvert.SerializeObject(dt);
            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {
                if (i != 0) result += ",";
                result += "{\"name\":\"" + dt.Rows[i]["subject"].ToString() + "\",\"id\":\"" + dt.Rows[i]["lessonid"].ToString() + "\"}";

            }
       
            dt.Dispose();
        }
        result += "]}";
        return (result);

    }
    [WebMethod]
    public static string get_tbl_article(string articleId)
    {
        article.MainData    mainData =  article.DbHandle.Get_article(int.Parse(articleId));
        string  result = JsonConvert.SerializeObject(mainData);
        return (result);
    }
    [WebMethod]
    public static List<article.ItemData> get_tbl_article_item(string articleId)
    {
        List<article.ItemData> ItemData = new List<article.ItemData>();
        ItemData = article.DbHandle.Get_article_item(int.Parse(articleId));
        string result = JsonConvert.SerializeObject(ItemData);
        return (ItemData);
    }

    [WebMethod(EnableSession = true)]
    public static string Set_DB()
    {
        string result = "";
       
        MainData MainData = new MainData();
        MainData = HttpContext.Current.Session["MainData"] as article.MainData ;
        
        if (MainData.Id == 0)
        {
          MainData.Id =  article.DbHandle .Article_Add();
        }
        int i = 0;
       
        i = article.DbHandle.Article_Update(MainData);
        if (HttpContext.Current.Session["ItemData"] != null) { 
            List<article.ItemData> itemDatas = new List<article.ItemData>();
            itemDatas = HttpContext.Current.Session["ItemData"] as List<ItemData>;
            i = article.DbHandle.Article_item_Update(itemDatas);
        }
        return (result);

    }
  
    [WebMethod(EnableSession = true)]
    public static dynamic Set_data(string kind, string Id, string[] Category
        , string Subject, string SubTitle, string Contents, string Pic, string PostDay, string Recommend
        , string[] Tags, string Author, string Keywords, string Status, List<article.Lesson> Lesson
        ,string  YoutubeUrl)
    {
        //如果用dynamic 傳,就會有LIST        postdata = postdata[0];
        string result = "";
        List<Category> ItemData = new List<Category>(); ;
        foreach (string s in Category)
        {

            NameValueCollection nvc = new NameValueCollection();
            string strsql = @"SELECT  categoryid, title as name,
                            kind 
                            FROM tbl_category
                            where  categoryid=@id  ";
            nvc.Add("id", s);
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {

                ItemData.Add(new Category
                {
                    Id = 0,
                    CategoryId = (int)dt.Rows[i]["categoryid"],
                    Name = dt.Rows[i]["name"].ToString(),
                    Kind = dt.Rows[i]["Kind"].ToString(),

                });

            }
            dt.Dispose();
        }

        MainData MainData = new MainData
        {

            Id = int.Parse(Id),
            Subject = Subject,
            SubTitle = SubTitle,
            Contents = Contents,
            Pic = classlib.GetImgNmae(Pic),
            PostDay = DateTime.Parse(PostDay),
            Status = Status,
            Viewcount = 0,
            Keywords = Keywords,
            Tags = Tags,
            Category = ItemData,
            Author = Author,
            Lesson = Lesson,
            Recommend = Recommend,
            kind = kind,
            Tempid = HttpContext.Current.Session["uploadid"].ToString(),
            YoutubeUrl =YoutubeUrl  ,
          //  Category =  postdata["Category"]  ,
          //  Lesson = postdata.Lesson  ,
        };
   
        HttpContext.Current.Session["MainData"] = MainData;     
      
        return (result );

    }
    [WebMethod(EnableSession = true)]
    public static string Set_LessonData( string id, List<article.Lesson> item)
    {
        List<Lesson> ItemData = new List<Lesson>();
        ItemData = item;
        //ItemData.Add(new ItemData
        //{

        //});
        HttpContext.Current.Session["LessonData"] = ItemData;
        //  var json = new JavaScriptSerializer().Serialize(ItemData);
        string result = "";
        return (result); ;

    }
    [WebMethod(EnableSession = true)]
    public static string Set_ItemData(string kind, string id , List<article.ItemData> item)
    {
        List<ItemData> ItemData = new List<ItemData>();
        ItemData = item;
        //ItemData.Add(new ItemData
        //{
            
        //});
        HttpContext.Current.Session["ItemData"] = ItemData;
        //  var json = new JavaScriptSerializer().Serialize(ItemData);
        string result = "";
        return (result); ;

    }
}