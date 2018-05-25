using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;


namespace article
{
    public class DbHandle {

    public static MainData Get_article(int id)
        {
            MainData MainData = new MainData();
            string strsql= "select * from  tbl_article where articleid =@id";
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("id", id.ToString());
            DataTable dt = DbControl.Data_Get (strsql, nvc);
           
            string[] tags;
            string[] writer;
            string[] categoryid;

            if (dt.Rows.Count > 0)
            {
                MainData.Id = id;
                MainData.Subject = dt.Rows[0]["Subject"].ToString();
                MainData.SubTitle = dt.Rows[0]["SubTitle"].ToString();
                MainData.Contents = dt.Rows[0]["Contents"].ToString().Replace("\r", "").Replace("\n", "");
                MainData.Pic = dt.Rows[0]["pic"].ToString();
                MainData.PostDay = DateTime.Parse ( dt.Rows[0]["PostDay"].ToString());
                MainData.Status = dt.Rows[0]["Status"].ToString();
                MainData.Keywords = dt.Rows[0]["Keywords"].ToString();
             
             
            }
            dt.Dispose();
            nvc.Clear();

            List<string > termsList = new List<string>();
            strsql = "select * from  tbl_article_tag  where articleid =@id and unitid=13";
            nvc.Add("id", id.ToString());
            dt = DbControl.Data_Get(strsql, nvc);
            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {
                termsList.Add(dt.Rows[i]["tagid"].ToString ());
               
            }
            tags = termsList.ToArray();
            nvc.Clear();
            dt.Dispose();

            strsql = "select * from  tbl_article_tag  where articleid =@id and unitid=14";
            nvc.Add("id", id.ToString());
            dt = DbControl.Data_Get(strsql, nvc);
            MainData.Tags = tags;
            termsList.Clear();    
            
            for (i = 0; i < dt.Rows.Count; i++)
            {
                termsList.Add(dt.Rows[i]["tagid"].ToString());

            }
            writer  = termsList.ToArray();
            MainData.Writer = writer;
            termsList.Clear();
            nvc.Clear();
            dt.Dispose();

            strsql = "select * from Tbl_article_category  where articleid =@id  ";
            nvc.Add("id", id.ToString());
            dt = DbControl.Data_Get(strsql, nvc);  
            for (i = 0; i < dt.Rows.Count; i++)
            {
                termsList.Add(dt.Rows[i]["categoryid"].ToString());

            }
            categoryid = termsList.ToArray();
            MainData.Category  = categoryid ;
            nvc.Clear();
            dt.Dispose();

            return MainData;

        }
     
        public static List<article.ItemData> Get_article_item(int id)
        {
            List <article.ItemData> ItemData = new List<article.ItemData>();
            string strsql = "select * from  tbl_article_item where articleid =@id";
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("id", id.ToString());
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            for (int i =0;i< dt.Rows.Count;i++)
            {
                ItemData.Add(new ItemData
                {
                    Title = dt.Rows[i]["subject"].ToString(),
                     Secno = (int) dt.Rows [i]["secno"],
                    Contents = dt.Rows[i]["contents"].ToString(),
                    Image = "",
                    Layout =""
                });
            }
            
            return ItemData;

        }
        public static int Article_Add()
    {
        int id = 0;
        string strsql = "insert into tbl_article ( Viewcount, FBCount, GoogleCount,PinterestCount) values (0,0,0,0);SELECT SCOPE_IDENTITY();";
        NameValueCollection nvc = new NameValueCollection();
        id = DbControl.Data_add(strsql, nvc);
        nvc.Clear();
        strsql = "select max(articleId) from  tbl_article ";
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0) id = (int)dt.Rows[0][0];
        dt.Dispose();
        return id;
    }

    public static int Article_Update(article.MainData ad)
    {
        string strsql = @"update  tbl_article set 
                subject =@subject,pic=@pic,subtitle=@subtitle,postday=@postday,contents=@contents ,
                keywords=@keywords,status=@status
                where articleId =@id ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("subject", ad.Subject  );
        nvc.Add("pic", ad.Pic);
        nvc.Add("subtitle", ad.SubTitle);
        nvc.Add("postday", ad.PostDay.ToString("yyyy/MM/dd"));
        nvc.Add("contents", ad.Contents);
        nvc.Add("keywords", ad.Keywords);
        nvc.Add("status", ad.Status);
        int i =DbControl. Data_Update(strsql, nvc, ad.Id.ToString());
        nvc.Clear();
        strsql = "delete from tbl_article_tag where articleId =@id";
        i = DbControl.Data_delete(strsql, ad.Id.ToString());

        string[] tags = ad.Tags;
        foreach (string s in tags)
        {
            nvc.Clear();
            strsql = @"insert into tbl_article_tag (articleId,tagid,unitid)
                values (@articleId,@tagid,@unitid)";
            nvc.Add("articleId", ad.Id.ToString());
            nvc.Add("tagid", s);
            nvc.Add("unitid", "13");
            i = DbControl.Data_add(strsql, nvc);
        }

        tags = ad.Writer;
        foreach (string s in tags)
        {
            nvc.Clear();
            strsql = @"insert into tbl_article_tag (articleId,tagid,unitid)
                values (@articleId,@tagid,@unitid)";
            nvc.Add("articleId", ad.Id.ToString());
            nvc.Add("tagid", s);
            nvc.Add("unitid", "14");
            i = DbControl.Data_add(strsql, nvc);
        }
        strsql = "delete from Tbl_article_category where articleId =@id";
        i = DbControl.Data_delete(strsql, ad.Id.ToString());

        string[] categoryid = ad.Category;
        foreach (string s in categoryid)
        {
            nvc.Clear();
            strsql = @"insert into Tbl_article_category (articleId,categoryid)
                values (@articleId,@categoryid)";
            nvc.Add("articleId", ad.Id.ToString());
            nvc.Add("categoryid", s);
            i = DbControl.Data_add(strsql, nvc);
        }
        nvc.Clear();


        return i;



    }

    public static int Article_item_Update(List<article.ItemData> itemData)
    {
        string strsql = "delete from tbl_article_item where articleId =@id";
        NameValueCollection nvc = new NameValueCollection();
        int i = 0;

        foreach (article.ItemData idx in itemData)

        {
            if (i == 0)
            {
                i = DbControl.Data_delete(strsql, idx.Id.ToString());
            }
            i++;
            nvc.Clear();
            strsql = @"insert into tbl_article_item (articleId,secno,subject,contents)
                values (@articleId,@secno,@subject,@contents)";
            nvc.Add("articleId", idx.Id.ToString());
            nvc.Add("secno", idx.Secno.ToString());
            nvc.Add("subject", idx.Title);
            nvc.Add("contents", idx.Contents);
            i = DbControl.Data_add(strsql, nvc);
        }

        return i;



    }
}
    public class MainData
    {
        public int Id { get; set; }
        public string Subject { get; set; }
        public string Pic { get; set; }
        public string SubTitle { get; set; }
        public DateTime PostDay { get; set; }
        public string Contents { get; set; }
        public int Viewcount { get; set; }
        public int FBcount { get; set; }
        public int Googlecount { get; set; }
        public int Twittercount { get; set; }
        public int Pinterestcount { get; set; }
        public string Status { get; set; }
        public string[] Writer { get; set; }
        public string[] Category { get; set; }
        public string[] Tags { get; set; }
        public string Keywords { get; set; }
    }
    public class ItemData
    {
        public int Id { get; set; }
        public int Secno { get; set; }
        public string Title { get; set; }
        public string Image { get; set; }  
        public string Contents { get; set; }
        public string Layout { get; set; }

    }
    public class Writer
    {
        public int Id { get; set; }
        public int Secno { get; set; }
        public int WriterId { get; set; }
    }
    public class Category
    {
        public int Id { get; set; }
        public int categoryId { get; set; }
       
    }
    public class Tags
    {
        public int Id { get; set; }
        public int Secno { get; set; }
        public int TagId { get; set; }
    }
    public class KeyWords
    {
        public int Id { get; set; }      
        public string World { get; set; }
    }
}