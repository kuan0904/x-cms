using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;

namespace Banner {
    public  class Web
    {
       public static  string Get_url(string url,string cate, string id)
        {
            if (id != "" && id != "0")
                return "/Article/" + id;
            else if (cate != "" && cate != "0")
                return "/" + cate + "/catalog";
            else
                return url;


        }

    }
    public class DbHandle
    {
        public static List<Banner.MainData> AD_Get_list(int ClassId, string flag = "")
        {
            List<Banner.MainData> MainData = new List<Banner.MainData>();
            string strsql = "select * from  tbl_banner  where  ClassId =@ClassId  ";
            if (flag == "")
                strsql += " and status='Y'";
            else
                strsql += " and status <> 'D' ";

            strsql += "order by sort desc ";
            NameValueCollection nvc = new NameValueCollection
            {
                { "ClassId", ClassId.ToString() }
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {
                MainData.Add(new MainData
                {
                    Subject = dt.Rows[i]["title"].ToString(),
                    Id = (int)dt.Rows[i]["bannerid"],
                    Contents = dt.Rows[i]["contents"].ToString(),
                    Pic = "/webimages/banner/" + dt.Rows[i]["filename"].ToString(),
                    Path = dt.Rows[i]["path"].ToString(),
                    Url = Web.Get_url(dt.Rows[i]["url"].ToString(), dt.Rows[i]["categoryid"].ToString(), dt.Rows[i]["articleId"].ToString()),
                
                    Categoryid = dt.Rows[i]["Categoryid"].ToString(),
                    ArticleId = dt.Rows[i]["ArticleId"].ToString(),
                    Strdat = (DateTime)dt.Rows[i]["enabledate"],
                    Enddat = dt.Rows[i]["disabledate"].ToString() == "" ? DateTime.Parse("1911/1/1") : (DateTime)dt.Rows[i]["disabledate"]
                });
            }
            dt.Dispose();
            nvc.Clear();
            return MainData;

        }
        public static List<Banner.MainData> Banner_Get_list(int ClassId,string flag ="")
        {
            List< Banner.MainData > MainData = new List<Banner.MainData>();
            string strsql = "select * from  tbl_banner where bannerid in (select bannerid from tbl_recommend where  ClassId =@ClassId ) ";
            if (flag == "")
                strsql += " and status='Y'";
            else
                strsql += " and status <> 'D' ";

            strsql += "order by sort desc ";
            NameValueCollection nvc = new NameValueCollection
            {
                { "ClassId", ClassId.ToString() }
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            int i = 0;
            for (i=0;i<dt.Rows.Count;i++)
            {
                MainData.Add(new MainData
                {
                   Subject = dt.Rows[i]["title"].ToString(),
                    Id = (int)dt.Rows[i]["bannerid"],
                    Contents = dt.Rows[i]["contents"].ToString(),
                    Pic = "/webimages/banner/" +  dt.Rows[i]["filename"].ToString(),
                    Path = dt.Rows[i]["path"].ToString(),
                    Url = Web.Get_url(dt.Rows[i]["url"].ToString(), dt.Rows[i]["categoryid"].ToString(), dt.Rows[i]["articleId"].ToString()),

                    Categoryid = dt.Rows[i]["Categoryid"].ToString(),
                    ArticleId = dt.Rows[i]["ArticleId"].ToString(),
                    Strdat =(DateTime)dt.Rows[i]["enabledate"],
                    Enddat = dt.Rows[i]["disabledate"].ToString () =="" ?  DateTime.Parse ("1911/1/1"):  (DateTime)dt.Rows[i]["disabledate"]
                });              
            }
            dt.Dispose();
            nvc.Clear();      
            return MainData;

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
            public string Categoryid { get; set; }
            public string ArticleId { get; set; }
            public DateTime Strdat { get; set; }
            public DateTime Enddat { get; set; }
    }
}