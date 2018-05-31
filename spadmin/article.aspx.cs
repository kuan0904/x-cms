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
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Request.QueryString["articleId"] != null)
        {
            articleId = Request.QueryString["articleId"];
          
        }

    }
    protected void Page_Load(object sender, EventArgs e)
    {
         
        if (Session["MainData"] != null)
        {
           
        }
        //if (Session["ItemData"] != null)
        //{

        //    List<ItemData> ItemData = new List<ItemData>();
        //    ItemData = Session["ItemData"] as List<ItemData>;
        //    foreach (ItemData idx in ItemData)
        //    {
        //        Response.Write(idx.Contents);
        //        //string[] tags = idx.Tags;
        //        //foreach (string s in tags)
        //        //{
        //        //    Response.Write(s);
        //        //}
        //    }
        //}
    }
    [WebMethod]    
    public static string get_tag(string kind)
    {
        string result = "{ \"main\":[";

        if (kind == "get") { 
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
        }
        result += "]}";
       return (result);

    }
 
    [WebMethod]
    public static string get_category(string kind)    {
        string result = "{ \"main\":[";
        if (kind == "get")
        {
            string strsql = "SELECT *  FROM  tbl_category  where status='Y' and  parentid =0  ";
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            //result = JsonConvert.SerializeObject(dt);
            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {
                if (i != 0) result += ",";
                result += "{\"name\":\"" + dt.Rows[i]["title"].ToString() + "\",\"id\":\"" + dt.Rows[i]["categoryid"].ToString() + "\"";
                result += ",\"detail\":[";
                strsql = "SELECT *  FROM  tbl_category  where status='Y' and  parentid ="+ dt.Rows[i]["categoryid"].ToString()   ;
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
    public static string Set_data(string kind, string id,string[] categoryid
        , string subject, string subtitle,string contents, string pic,string postday 
        , string[] tags, string author, string keywords, string status)
    {

        MainData MainData = new MainData
        {
            Id = int.Parse(id),
            Subject = subject,
            SubTitle = subtitle,
            Contents = contents,
            Pic  = pic,
            PostDay = DateTime.Parse ( postday) ,
            Status = status,
            FBcount = 0,
            Googlecount = 0,
            Twittercount = 0,
            Pinterestcount = 0,
            Viewcount = 0,
            Keywords = keywords,
            Tags = tags,
            Category = categoryid,
            Author= author

        };
   
        HttpContext.Current.Session["MainData"] = MainData;
      //  var json = new JavaScriptSerializer().Serialize(MainData);
        string result = "";
        return (result);

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