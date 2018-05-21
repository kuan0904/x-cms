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
    protected void Page_Init(object sender, EventArgs e)
    {

     
    
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["MainData"] != null)
        {
            List<MainData> MainData = new List<MainData>();
            MainData = Session["MainData"] as List<MainData>;
           
            foreach (MainData idx in MainData)
            {
               string[] tags =idx.Tags;
                foreach (string s in tags)
                {
                    Response.Write(s );
                }
            }
        }
    }

   
    [WebMethod]    
    public static string get_tag(string kind)
    {
        string result = "{ \"main\":[";

        if (kind == "get") { 
            string strsql = "SELECT *  FROM tbl_tag where status='Y' and unitid=13 ";
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = admin_contrl.Data_Get(strsql, nvc);
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
    
    [WebMethod()]
    public static string get_writer(string kind)
    {
        string result = "{ \"main\":[";

        if (kind == "get")
        {
            string strsql = "SELECT *  FROM tbl_tag where status='Y' and unitid=14 ";
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = admin_contrl.Data_Get(strsql, nvc);
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
    public static string get_category(string kind)
    {
        string result = "{ \"main\":[";

        if (kind == "get")
        {
            string strsql = "SELECT *  FROM  tbl_category  where status='Y' and  parentid =0  ";
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = admin_contrl.Data_Get(strsql, nvc);
            //result = JsonConvert.SerializeObject(dt);
            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {
                if (i != 0) result += ",";
                result += "{\"name\":\"" + dt.Rows[i]["title"].ToString() + "\",\"id\":\"" + dt.Rows[i]["categoryid"].ToString() + "\"";
                result += ",\"detail\":[";
                strsql = "SELECT *  FROM  tbl_category  where status='Y' and  parentid ="+ dt.Rows[i]["categoryid"].ToString()   ;
                nvc = new NameValueCollection();
                DataTable dt1 = admin_contrl.Data_Get(strsql, nvc);
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

    [WebMethod(EnableSession = true)]
    public static string Set_data(string kind, string id,string[] categoryid
        , string title, string subtitle,string contents, string pic
        , string[] tags, string[] writer,string keywords, string status)
    {
        List<MainData> MainData = new List<MainData>();
        MainData.Add(new MainData
        {
            Id = int.Parse(id),
            Title = title,
            SubTitle = subtitle,
            Contents = contents,
            Image = pic,
            Status = status,
            FBShare = 0,
            GoogleShare =0,
            TwitterShare=0,
            PinterestShare=0,
            Viewcount =0,
            Keywords =keywords ,
            Tags =tags,
            Category = categoryid,
            Writer= writer 


        });
        //Session["MainData"] = articledata;
        HttpContext.Current.Session["MainData"] = MainData;
        var json = new JavaScriptSerializer().Serialize(MainData);

        string result = json;
        return (result);

    }
    public int Id { get; set; }
    public string Title { get; set; }
    public string Image { get; set; }
    public string Content { get; set; }
    public string Layout { get; set; }
    [WebMethod(EnableSession = true)]
    public static string Set_ItemData(string kind, string id
      , string title, string contents, string pic ,string secno     )
    {
        List<ItemData> ItemData = new List<ItemData>();
        ItemData.Add(new ItemData
        {
            Id = int.Parse(id),
            Title = title,           
            Contents = contents,
            Image = pic,
            Secno =int.Parse (secno )
        });       
        HttpContext.Current.Session["ItemData"] = ItemData;
        var json = new JavaScriptSerializer().Serialize(ItemData);
        string result = json;
        return (result);

    }
}