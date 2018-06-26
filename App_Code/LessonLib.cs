using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;
using System.Reflection;
using System.Text;


/// <summary>
/// LessonLib 的摘要描述
/// </summary>
public class LessonLib
{
    public LessonLib()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    public class Web
    {

        public static object Tbl_article_tag(int id, string kind = "dt")
        {
            NameValueCollection nvc = new NameValueCollection();
            string strsql = @"select tbl_article_tag.articleId, tbl_article_tag.tagid, tbl_article_tag.unitid,
            tbl_tag.tagname, tbl_tag.pic, tbl_tag.contents, tbl_tag.title
                FROM     tbl_article_tag INNER JOIN tbl_tag ON tbl_article_tag.tagid = tbl_tag.tagid
                where tbl_article_tag.articleId=@id ";
            nvc.Add("id", id.ToString());
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            {
                if (kind == "dt") {
                    return dt;
                }
                else
                {
                    List<Lecture> Lecture = new List<Lecture>();
                    int i = 0;
                    for (i = 0; i < dt.Rows.Count; i++)
                    {
                        Lecture.Add(new Lecture
                        {
                            Id = (int)dt.Rows[i]["tagid"],
                            Title = (string)dt.Rows[i][" Title"],
                            Subject = (string)dt.Rows[i]["tagname"],
                            Contents = (string)dt.Rows[i]["Contents"],
                            Pic = (string)dt.Rows[i]["Contents"]
                        });
                    }
                    dt.Dispose();
                    return Lecture;
                }

            }
        }

    }
    public class DbHandle
    {
        public static string JoinAdd(JoinData  item)
        {
            using (SqlConnection conn = new SqlConnection(DbControl.dbConnectionString))
            {
                string strsql = @"insert into Tbl_LessonJoin (username,email,phone,LessonId) values   
                (@username,@email,@phone,@LessonId) ";

                NameValueCollection nvc = new NameValueCollection
            {
                { "username", item.Usermame },
                { "email",item.Email  },
                { "phone", item.Phone  },
                { "Lessonid",item.LessonId   },
                { "status", item.Status  }
                //{ "endday",ad.EndDay.ToString("yyyy/MM/dd") },
              
            };
                DbControl.Data_add(strsql, nvc);


            }
            return "Y";
        }
        public static object Get_Lesson(string id = "", string kind = "dt")
        {
            NameValueCollection nvc = new NameValueCollection();
            string strsql = "select * from    tbl_Lesson  ";
            if (id != "")
            {
                strsql += "where lessonId =@id";
                nvc.Add("id", id);
            }
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (kind == "dt")
            {
                dt.Dispose();
                return dt;
            }
            else
            {
                LessonLib.MainData MainData = new LessonLib.MainData();
                int i = 0;
                for (i = 0; i < dt.Rows.Count; i++)
                {

                    MainData.Id = (int)dt.Rows[i]["lessonId"];
                    MainData.Startday = dt.Rows[i]["startday"].ToString();
                    MainData.Endday = dt.Rows[i]["Endday"].ToString();
                    MainData.Subject = (string)dt.Rows[i]["subject"];
                    MainData.Contents = (string)dt.Rows[i]["Contents"];
                    MainData.Address = (string)dt.Rows[i]["Address"];
                    MainData.Lessontime = (string)dt.Rows[i]["Lessontime"];
                    MainData.Status = (string)dt.Rows[i]["Status"];


                }
                dt.Dispose();
                return MainData;
            }
        }

        public static object Get_lecturer(string kind = "dt")
        {
            NameValueCollection nvc = new NameValueCollection();
            string strsql = "select * from       tbl_tag  where unitid=14 ";
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (kind == "dt")
            {
                dt.Dispose();
                return dt;
            }
            else
            {
                List<Lecture> Lecture = new List<Lecture>();
                int i = 0;
                for (i = 0; i < dt.Rows.Count; i++)
                {
                    Lecture.Add(new Lecture
                    {
                        Id = (int)dt.Rows[i]["tagid"],

                        Subject = (string)dt.Rows[i]["tagname"],
                        Contents = (string)dt.Rows[i]["Contents"],
                        Pic = (string)dt.Rows[i]["Contents"]
                    });
                }
                dt.Dispose();
                return Lecture;
            }
        }


    }
    public class JoinData{
        public int Id { get; set; }
        public string LessonId { get; set; }
        public string Usermame { get; set; }
        public string Email { get; set; }     
        public string Status { get; set; }
        public string Phone { get; set; }
      

    }


    public class MainData
    {
        public int Id { get; set; }
        public string Subject { get; set; }
        public string Pic { get; set; }
        public string Contents { get; set; }
        public int Price { get; set; }
        public int Sellprice { get; set; }
        public string Status { get; set; }
        public string Address { get; set; }
        public string Lessontime { get; set; }
        public string Startday { get; set; }
        public string Endday { get; set; }
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