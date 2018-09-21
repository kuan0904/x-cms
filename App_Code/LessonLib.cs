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
        public static object  JoinAdd(JoinData  item)
        {
         
                string strsql = @"INSERT  into Tbl_Joindata( username, email, phone,  memberid, 
                status, paymode,ticketkind, Articleid,totalprice)   values
                ( @username, @email, @phone,  @memberid, @status, @paymode,@ticketkind, @Articleid,@totalprice) ";

                NameValueCollection nvc = new NameValueCollection
            {
                { "username", item.Name  },
                { "email",item.Email  },
                { "phone", item.Phone  },
                { "memberid","0" },
                { "status","Y" },
                { "paymode",item.Paymode  },
                { "ticketkind",item.TicketKind  },
                { "Articleid",item.Articleid .ToString ()   },
                { "totalprice", item.TotalPrice.ToString () },
            
              
            };
                DbControl.Data_add(strsql, nvc);
                int joinid = 0;
                strsql = "select max (joinid) from  Tbl_Joindata";
                nvc.Clear();
                DataTable dt = DbControl.Data_Get(strsql, nvc);
                joinid = (int)dt.Rows[0][0];
                 item.Id = joinid;
                foreach (JoinList j in item.JoinLists)
                {
                    strsql = @"INSERT INTO tbl_joindetail(joinid, username, phone, email, lessonid,amount)
                        VALUES (@joinid, @username, @phone, @email, @lessonid,@amount)";
                    nvc.Clear();
                    nvc.Add("joinid", joinid.ToString());
                    nvc.Add("username", j.Name);
                    nvc.Add("phone", j.Phone);
                    nvc.Add("email", j.Email);
                    nvc.Add("amount", j.Amount .ToString ());
                    nvc.Add("lessonid", j.LessonId .ToString());
                DbControl.Data_add(strsql, nvc);

            };          

            return item ;
        }
        public static object Get_Lesson(string id = "")
        {
            NameValueCollection nvc = new NameValueCollection();
            string strsql = "select * from    tbl_Lesson  ";
            if (id != "")
            {
                strsql += "where lessonId =@id";
                nvc.Add("id", id);
            }
            DataTable dt = DbControl.Data_Get(strsql, nvc);
        
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
        public static object Get_LessonClass(int id)
        {
            NameValueCollection nvc = new NameValueCollection();
            string strsql = "select * from   tbl_lesson_class  ";
            
                strsql += "where lessonId =@id";
                nvc.Add("id", id.ToString ());
         
            DataTable dt = DbControl.Data_Get(strsql, nvc);

            LessonLib.ItemData   MainData = new LessonLib.ItemData();
            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {

                MainData.Id = (int)dt.Rows[i]["lessonId"];            
                MainData.Price = (int)dt.Rows[i]["Price"];
                MainData.Description = (string)dt.Rows[i]["description"];
                MainData.Sellprice  = (int)dt.Rows[i]["Sellprice"];
                MainData.Num  = (int)dt.Rows[i]["limitnum"];


            }
            dt.Dispose();
            return MainData;

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
    public class JoinData {
        public int Id { get; set; }
        public int Articleid { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Status { get; set; }
        public string Phone { get; set; }
        public string Paymode { get; set; }
        public string TicketKind { get; set; }
        public List<JoinList> JoinLists { get; set; }
        public int TotalPrice {get;set ;}
    }
    public class JoinList
    {
        public int LessonId { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
      
        public string Phone { get; set; }
        public int Price { get; set; }
        public int Amount { get; set; }
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
        public int Num { get; set; }
    }
    public class ItemData
    {
        public int Id { get; set; }
        public string Description { get; set; }      
        public int Price { get; set; }
        public int Sellprice { get; set; }   
        public int Num { get; set; }

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