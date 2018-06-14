﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;
using System.Reflection;
using System.Text;

namespace article
{
    public static class DataTableExtensions
    {
        public static IList<T> ToList<T>(this DataTable table) where T : new()
        {
            IList<PropertyInfo> properties = typeof(T).GetProperties().ToList();
            IList<T> result = new List<T>();

            //取得DataTable所有的row data
            foreach (var row in table.Rows)
            {
                var item = MappingItem<T>((DataRow)row, properties);
                result.Add(item);
            }

            return result;
        }

        private static T MappingItem<T>(DataRow row, IList<PropertyInfo> properties) where T : new()
        {
            T item = new T();
            foreach (var property in properties)
            {
                if (row.Table.Columns.Contains(property.Name))
                {
                    //針對欄位的型態去轉換
                    if (property.PropertyType == typeof(DateTime))
                    {
                        DateTime dt = new DateTime();
                        if (DateTime.TryParse(row[property.Name].ToString(), out dt))
                        {
                            property.SetValue(item, dt, null);
                        }
                        else
                        {
                            property.SetValue(item, null, null);
                        }
                    }
                    else if (property.PropertyType == typeof(decimal))
                    {
                        decimal val = new decimal();
                        decimal.TryParse(row[property.Name].ToString(), out val);
                        property.SetValue(item, val, null);
                    }
                    else if (property.PropertyType == typeof(double))
                    {
                        double val = new double();
                        double.TryParse(row[property.Name].ToString(), out val);
                        property.SetValue(item, val, null);
                    }
                    else if (property.PropertyType == typeof(int))
                    {
                        int val = new int();
                        int.TryParse(row[property.Name].ToString(), out val);
                        property.SetValue(item, val, null);
                    }
                    else
                    {
                        if (row[property.Name] != DBNull.Value)
                        {
                            property.SetValue(item, row[property.Name], null);
                        }
                    }
                }
            }
            return item;
        }
    }
    public class Web
    {
        public static string Get_Keyword_link(string id)
        {
            if (id == null) id = "";
            string result = "";

            string[] k = id.Split(',');
            foreach (string s in k)
            {
                result += "<a href = \"#\">" + s + "</a>";
            }
            return result;
        }
        public static string Get_author_link(string id)
        {
            if (id == null) id = "";
            string result = "";

            string[] k = id.Split(',');
            foreach (string s in k)
            {
                result += "<a href = \"#\">" + s + "</a>";
            }
            return result;
        }
        public static string Get_tag_link(string[] tags)
        {
            List<Tags> ItemData = new List<Tags>();
            ItemData = DbHandle.Get_tag_list(tags);
            string result = "";
            foreach (var s in ItemData)
            {
                result += result == "" ? "" : "/";
                result +=  s.Name ;
            }
            return result;
        }
        public static string Get_category_link(int id)
        {
            List<Category > ItemData = new List<Category>();
            ItemData = (List <Category>)  DbHandle.Get_article_category(id, "list");
            string result = "";
            foreach (var s in ItemData)
            {
                result += result == "" ? "" : "/";
                result += s.Name;
           
            }
            return result ;
        }
    }
    public class DbHandle
    {
        public static int Add_views(int id)
        {
            string strsql = @"update  tbl_article  set  Viewcount=Viewcount + 1 
            where  articleid=@id ";
            NameValueCollection nvc = new NameValueCollection
            {
                { "id", id.ToString() }
            };
            id = DbControl.Data_add(strsql, nvc);
            nvc.Clear();
            return id;
        }
        public static MainData Get_article(int id)
        {
            MainData MainData = new MainData();
            string strsql = @"select * from    tbl_article   tbl_article LEFT OUTER JOIN
                            tbl_article_lesson ON tbl_article.articleId = tbl_article_lesson.lessonId
                            where articleid =@id";
            NameValueCollection nvc = new NameValueCollection
            {
                { "id", id.ToString() }
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);

            string[] tags;
            string[] categoryid;
            string[] Lecture;
         
            if (dt.Rows.Count > 0)
            {
                MainData.Id = id;
                MainData.Subject = dt.Rows[0]["Subject"].ToString();
                MainData.SubTitle = dt.Rows[0]["SubTitle"].ToString();
                MainData.Contents = dt.Rows[0]["Contents"].ToString().Replace("\r", "").Replace("\n", "");
                MainData.Pic = dt.Rows[0]["pic"].ToString();
                MainData.PostDay = DateTime.Parse(dt.Rows[0]["PostDay"].ToString());
                MainData.Status = dt.Rows[0]["Status"].ToString();
                MainData.Keywords = dt.Rows[0]["Keywords"].ToString();
                MainData.Author = dt.Rows[0]["Author"].ToString();
                MainData.Viewcount = (int)dt.Rows[0]["Viewcount"];
                MainData.Price = dt.Rows[0]["price"].ToString () == "" ? 0:(int)dt.Rows[0]["price"];
                MainData.Sellprice = dt.Rows[0]["Sellprice"].ToString() == ""  ? 0 : (int)dt.Rows[0]["Sellprice"];
                MainData.Address  = dt.Rows[0]["address"].ToString();
                MainData.Lessontime = dt.Rows[0]["Lessontime"].ToString();
                MainData.StartDay = dt.Rows[0]["StartDay"].ToString() =="" ? DateTime.Today  : DateTime.Parse(dt.Rows[0]["StartDay"].ToString());
                MainData.EndDay = dt.Rows[0]["EndDay"].ToString() == "" ? DateTime.Today : DateTime.Parse(dt.Rows[0]["EndDay"].ToString());
                MainData.Lesson = dt.Rows[0]["lesson"].ToString();
            }
            dt.Dispose();
            nvc.Clear();

            List<string> termsList = new List<string>();
            strsql = "select * from  tbl_article_tag  where articleid =@id and unitid=13";
            nvc.Add("id", id.ToString());
            dt = DbControl.Data_Get(strsql, nvc);
            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {
                termsList.Add(dt.Rows[i]["tagid"].ToString());
            }
            tags = termsList.ToArray();
            termsList.Clear();
            MainData.Tags = tags;
            nvc.Clear();
            dt.Dispose();

            //取目錄
            strsql = "select * from Tbl_article_category  where articleid =@id  ";
            nvc.Add("id", id.ToString());
            dt = DbControl.Data_Get(strsql, nvc);
            for (i = 0; i < dt.Rows.Count; i++)
            {
                termsList.Add(dt.Rows[i]["categoryid"].ToString());
            }
            categoryid = termsList.ToArray();
            termsList.Clear();
            MainData.Category = categoryid;
            dt.Dispose();
            nvc.Clear();

            //取講師
            termsList.Clear();
            strsql = "select * from  tbl_article_tag  where articleid =@id and unitid=14";
            nvc.Add("id", id.ToString());
            dt = DbControl.Data_Get(strsql, nvc);           
            for (i = 0; i < dt.Rows.Count; i++)
            {
                termsList.Add(dt.Rows[i]["tagid"].ToString());
            }
            tags = termsList.ToArray();
            termsList.Clear();
            MainData.Lecturer = tags;
            nvc.Clear();
            dt.Dispose();
            return MainData;

        }
        public static DataTable Get_tbl_tag(int id)
        {
            NameValueCollection nvc = new NameValueCollection();
            string strsql = "select * from       tbl_tag  where tagid =@id  ";
            nvc.Add("id", id.ToString());
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            return dt;
        }
        public static object   Get_article_category(int id,string kind="dt")
        {
            List<Category> ItemData = new List<Category>();
            NameValueCollection nvc = new NameValueCollection();
            string strsql = @"SELECT      Tbl_article_category.articleId as id
                            , Tbl_article_category.categoryid, tbl_category.title as name
                            FROM Tbl_article_category INNER JOIN
                            tbl_category ON Tbl_article_category.categoryid = tbl_category.categoryid
                            where  Tbl_article_category.articleId=@id  ";
            nvc.Add("id", id.ToString());
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (kind == "dt")
                return dt;
            else { 
                var obj = dt.ToList<Category>();
                return obj;
            }


            //使用方式: datatable to list
            //List<UserInfo> list = new List<UserInfo>();
            //DataTable dt = GetDataTable();
            //var result = DataTableExtensions.ToList<UserInfo>(dt).ToList();
            //list = result.OrderBy(c => c.UpdateDate).ToList();
        }
        public static List<Tags> Get_tag_list(string[] id)
        {
            List<Tags> ItemData = new List<Tags>();
            if (id != null)
            {

                foreach (string s in id)
                {
                    DataTable dt = Get_tbl_tag(int.Parse(s));
                    ItemData.Add(new Tags
                    {
                        TagId = (int)dt.Rows[0]["tagid"],
                        Name = dt.Rows[0]["tagName"].ToString()
                    });
                }
            }
            return ItemData;
        }
        public static List<article.MainData> Get_article_list(string cid, string KeyWords, int rows = 10, int page = 0)
        {

            List<article.MainData> MainData = new List<article.MainData>();
            DataTable dt;
            string strsql = @"select  * from  tbl_article  where tbl_article.status='Y'  ";
            if (cid != "")
            {
                strsql += @" and articleId  in (select articleId FROM Tbl_article_category
                          WHERE categoryid IN(SELECT categoryid  FROM   tbl_category  WHERE parentid = @cid  
                    or   categoryid = @cid ))";

            }
            NameValueCollection nvc = new NameValueCollection
            {
                { "cid", cid }
            };
            dt = DbControl.Data_Get(strsql, nvc);

            string[] tags;
            string[] categoryid;
            int idx = 0;
            int Id = 0;

            int totalrow = dt.Rows.Count;
            dt = DbControl.GetPagedTable(dt, page, rows);
            for (idx = 0; idx < dt.Rows.Count; idx++)
            {
                Id = (int)dt.Rows[idx]["articleid"];
                MainData.Add(new MainData
                {
                    TotalRows = totalrow,
                    Id = Id,
                    Subject = dt.Rows[idx]["Subject"].ToString(),
                    SubTitle = dt.Rows[idx]["SubTitle"].ToString(),
                    Contents = dt.Rows[idx]["Contents"].ToString().Replace("\r", "").Replace("\n", ""),
                    Pic = dt.Rows[idx]["pic"].ToString(),
                    PostDay = DateTime.Parse(dt.Rows[idx]["PostDay"].ToString()),
                    Status = dt.Rows[idx]["Status"].ToString(),
                    Keywords = dt.Rows[idx]["Keywords"].ToString(),
                    Viewcount = (int)dt.Rows[idx]["viewcount"],
                    Author = dt.Rows[idx]["Author"].ToString()
                });
                nvc.Clear();
                nvc = new NameValueCollection
                {
                    { "id", Id.ToString() }
                };
                DataTable dt1;
                List<string> termsList = new List<string>();
                strsql = "select * from  tbl_article_tag  where articleid =@id and unitid=13";
                dt1 = DbControl.Data_Get(strsql, nvc);
                int i = 0;
                for (i = 0; i < dt1.Rows.Count; i++)
                {
                    termsList.Add(dt1.Rows[i]["tagid"].ToString());

                }
                tags = termsList.ToArray();
                dt1.Dispose();
                strsql = "select * from Tbl_article_category  where articleid =@id  ";
                dt1 = DbControl.Data_Get(strsql, nvc);
                for (i = 0; i < dt1.Rows.Count; i++)
                {
                    termsList.Add(dt1.Rows[i]["categoryid"].ToString());

                }
                categoryid = termsList.ToArray();
                dt1.Dispose();
                nvc.Clear();

                //if (MainData.Exists(x =>  x.Id  == (int)dt.Rows[idx]["articleid"]) == true)
                // {
                var s = MainData.Find(p => p.Id == Id);
                s.Tags = tags;
                s.Category = categoryid;

                //}

            }
            dt.Dispose();

            return MainData;

        }
        public static List<article.ItemData> Get_article_item(int id)
        {
            List<article.ItemData> ItemData = new List<article.ItemData>();
            string strsql = "select * from  tbl_article_item where articleid =@id";
            NameValueCollection nvc = new NameValueCollection
            {
                { "id", id.ToString() }
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ItemData.Add(new ItemData
                {
                    Title = dt.Rows[i]["subject"].ToString(),
                    Secno = (int)dt.Rows[i]["secno"],
                    Contents = dt.Rows[i]["contents"].ToString(),
                    Image = "",
                    Layout = ""
                });
            }

            return ItemData;

        }
        public static int Article_Add()
        {
            int id = 0;
            string strsql = @"insert into tbl_article ( Viewcount) 
        values (0);";//SELECT SCOPE_IDENTITY();
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
                    keywords=@keywords,status=@status,author=@author,startday=@startday,endday=@endday
                    ,lesson=@lesson
                    where articleId =@id ";
            NameValueCollection nvc = new NameValueCollection
            {
                { "subject", ad.Subject },
                { "pic", ad.Pic },
                { "subtitle", ad.SubTitle },
                { "postday", ad.PostDay.ToString("yyyy/MM/dd") },
                { "contents", ad.Contents },
                { "keywords", ad.Keywords },
                { "author", ad.Author },
                { "status", ad.Status },
                { "lesson", ad.Lesson },
                { "startday",ad.StartDay.ToString("yyyy/MM/dd")  },
                { "endday",ad.EndDay.ToString("yyyy/MM/dd") },
              
            };
            int i = DbControl.Data_Update(strsql, nvc, ad.Id.ToString());
            nvc.Clear();
            strsql = "delete from tbl_article_tag where articleId =@id and unitid =13 ";
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

            strsql = "delete from tbl_article_tag  where articleId =@id and unitid =14" ;
            i = DbControl.Data_delete(strsql, ad.Id.ToString());

            string[] lecturer = ad.Lecturer ;
            foreach (string s in lecturer)
            {
                nvc.Clear();
                strsql = @"insert into tbl_article_tag (articleId,tagid,unitid)
                    values (@articleId,@tagid,@unitid)";
                nvc.Add("articleId", ad.Id.ToString());
                nvc.Add("tagid", s);
                nvc.Add("unitid", "14");
                i = DbControl.Data_add(strsql, nvc);
            }
            nvc.Clear();

            strsql = "delete from  tbl_article_lesson where  lessonId =@id";
            i = DbControl.Data_delete(strsql, ad.Id.ToString());
            if (ad.Lesson  == "Y") {          
               
                strsql = @"insert into tbl_article_lesson ( lessonId, lessontime, address, price, sellprice)
                    values (@lessonId, @lessontime, @address, @price, @sellprice)";
                nvc.Add("lessonId", ad.Id.ToString());
                nvc.Add("lessontime", ad.Lessontime );
                nvc.Add("address", ad.Address );
                nvc.Add("price", ad.Price.ToString());
                nvc.Add("sellprice", ad.Sellprice .ToString());
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
        public DateTime StartDay { get; set; }
        public DateTime EndDay { get; set; }
        public string Contents { get; set; }
        public int Viewcount { get; set; }     
        public string Status { get; set; }
        public string Author { get; set; }
        public string[] Category { get; set; }
        public string[] Tags { get; set; }
        public string[] Lecturer { get; set; }
        public string Lessontime { get; set; }
        public string Keywords { get; set; }
        public string Address { get; set; }
        public int Price { get; set; }
        public int Sellprice { get; set; }
        public int TotalRows { get; set; }
        public string Lesson { get; set; }
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
  
    public class Category
    {
        public int Id { get; set; }
        public int CategoryId { get; set; }
        public string Name { get; set; }

    }
    public class Tags
    {
        public int Id { get; set; }      
        public int TagId { get; set; }
        public string Name { get; set; }
    }
    public class KeyWords
    {
        public int Id { get; set; }      
        public string World { get; set; }
    }
    public class Lecture
    {
        public int Id { get; set; }
        public int Tagid { get; set; }
        public string Subject { get; set; }
        public string Title { get; set; }
        public string Pic { get; set; }
        public string Contents { get; set; }
    }

}