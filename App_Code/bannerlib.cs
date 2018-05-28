using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;

namespace Banner {
    public class DbHandle
    {

        public static List<Banner.MainData> Banner_Get_list(int ClassId)
        {
            List< Banner.MainData > MainData = new List<Banner.MainData>();       
            string strsql = "select * from  tbl_banner where ClassId =@ClassId and status='Y'";
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("ClassId", ClassId.ToString());
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            int i = 0;
            for (i=0;i<dt.Rows.Count;i++)
            {
                MainData.Add(new MainData
                {
                   Subject = dt.Rows[i]["title"].ToString(),
                    Id = (int)dt.Rows[i]["bannerid"],
                    Contents = dt.Rows[i]["contents"].ToString(),
                    Pic = dt.Rows[i]["filename"].ToString(),
                    Path = dt.Rows[i]["path"].ToString(),
                    Url = dt.Rows[i]["url"].ToString(),
                });              
            }
            dt.Dispose();
            nvc.Clear();      
            return MainData;

        }


        public static int Banner_Add()
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

        public static int Banner_Update(article.MainData ad)
        {
            string strsql = @"update  tbl_article set 
                subject =@subject,pic=@pic,subtitle=@subtitle,postday=@postday,contents=@contents ,
                keywords=@keywords,status=@status
                where articleId =@id ";
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("subject", ad.Subject);
            nvc.Add("pic", ad.Pic);
            nvc.Add("subtitle", ad.SubTitle);
            nvc.Add("postday", ad.PostDay.ToString("yyyy/MM/dd"));
            nvc.Add("contents", ad.Contents);
            nvc.Add("keywords", ad.Keywords);
            nvc.Add("status", ad.Status);
            int i = DbControl.Data_Update(strsql, nvc, ad.Id.ToString());
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

       
    }

    public class MainData
        {
            public int Id { get; set; }
            public string Subject { get; set; }
            public string Pic { get; set; }
            public string Contents { get; set; }
            public int Viewcount { get; set; }          
            public string Status { get; set; }
            public string Url { get; set; }
            public int ClassId { get; set; }
            public string Path { get; set; }
       
    }
}