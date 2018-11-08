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
/// MemberLib 的摘要描述
/// </summary>
public class MemberLib
{
    public MemberLib()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    public class Member : System.Collections.Specialized.NameObjectCollectionBase
    {
        public static Mmemberdata Update(Mmemberdata m )
        {

            string strsql = @"update tbl_MemberData set email=@email,
            username=@username
            ,phone=@phone
            ,mobile=@mobile
            ,cityid=@cityid 
            ,countyid=@countyid
            ,zip=@zip,birthday=@birthday
            ,address=@address,password=@password where  memberid=@memberid";

            NameValueCollection nvc = new NameValueCollection
            {
                { "username", m.Username  },
                { "email", m.Email },
                { "phone", m.Phone },
                { "mobile", m.Mobile },
                { "cityid", m.Cityid.ToString () },
                { "countyid", m.Countyid .ToString () },
                { "zip", m.Zip },
                { "address", m.Address },
                { "birthday", m.Birthday .ToString ("yyyy/MM/dd")},
                { "password", m.Password  },
                { "memberid", m.Memberid.ToString ()  }
            };
            DbControl.Data_add(strsql, nvc);
            return m;

        }
        public static Mmemberdata Check_exist(string id,string fbid ="")
        {
           
            Mmemberdata result = new Mmemberdata ();
            result.Memberid = 0;
            string strsql = "select memberid from  tbl_MemberData where  email =@id or fbid=@id ";

            NameValueCollection nvc = new NameValueCollection
            {
                { "id", id  }
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count != 0)
                result = GetData(dt.Rows[0]["memberid"].ToString()) ;
            dt.Dispose();
            return result;        

        }
        public static Mmemberdata Add(string email, string password, string fbid = ""
                ,  string username = "", string phone = "")
        {
            Mmemberdata result = new Mmemberdata();
            result = Check_exist(email);
            if (result.Memberid == 0)
            {
                string strsql = @"insert  into tbl_MemberData ( email,password ,fbid,phone)
                values  ( @email,@password,@fbid,@phone ) ";
                NameValueCollection nvc = new NameValueCollection
                {
                    { "email", email  },
                    { "password", password  },
                    { "fbid", fbid  },
                 
                    { "phone", phone  }
                };
                DbControl.Data_add(strsql, nvc);
                result = Login(email, password, "");
                Mail.Join_member(result.Memberid);
            }

            return result  ;

        }
        public static Mmemberdata Login(string email, string password,string fbid="")
        {
            Mmemberdata result = new Mmemberdata();
            string strsql = @"select memberid from tbl_MemberData  where  (email=@email and password=@password ) ";
            if (fbid != "") {strsql = @"select memberid from tbl_MemberData  where  (fbid=@fbid ) "; }
         
            NameValueCollection nvc = new NameValueCollection
            {
                { "fbid", fbid  },
                { "email", email  },
                { "password", password  },
              
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count > 0) result =  GetData ( dt.Rows[0]["memberid"].ToString());
            dt.Dispose();
            return result;

        }
    
        public static Mmemberdata GetData(string memberid)
        {
           
            string strsql = @"select * from tbl_MemberData  where  (memberid =@memberid) ";
            NameValueCollection nvc = new NameValueCollection
            {
                { "memberid", memberid  }
               
            };
            DataTable dt=  DbControl.Data_Get (strsql, nvc);
            Mmemberdata m = new Mmemberdata();
            if (dt.Rows.Count >0)
            {
                m.Email = dt.Rows[0]["email"].ToString();
                m.Memberid = (int) dt.Rows[0]["memberid"];
                m.Phone = dt.Rows[0]["Phone"].ToString();
                m.Password =MySecurity.SimpleTripleDes(  dt.Rows[0]["Password"].ToString());
                m.Username = dt.Rows[0]["Username"].ToString();
                m.Address = dt.Rows[0]["Address"].ToString();
                m.Zip = dt.Rows[0]["zip"].ToString();
                m.Countyid = dt.Rows[0]["Countyid"].ToString() ==""? 0:(int)dt.Rows[0]["Countyid"];
                m.Cityid  = dt.Rows[0]["Cityid"].ToString() == "" ? 0 : (int)dt.Rows[0]["Cityid"];
                m.Password = dt.Rows[0]["password"].ToString();
                m.Birthday = dt.Rows[0]["Birthday"].ToString() == "" ? DateTime.Parse ("1911/1/1") : (DateTime )dt.Rows[0]["Birthday"];
            }
            return m ;

        }
        public static  string Is_collection(string memberid, string articleId)
        {
            string result = "";
            string strsql = @"select * from     tbl_articleCollection where articleId =@articleId 
                and memberid =@memberid";

            NameValueCollection nvc = new NameValueCollection
            {
                { "memberid", memberid },
                { "articleId", articleId }
            };

            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count == 0)
                result = "";

            else result = "Y";
            dt.Dispose();

            return result;

        }
        public static dynamic MyOrderData(string memberid)
        {

            string strsql = @" select  * FROM  tbl_OrderData INNER JOIN
                            tbl_OrderDetail ON tbl_OrderData.ord_id = tbl_OrderDetail.ord_id    
             where memberid =@memberid";

            NameValueCollection nvc = new NameValueCollection
            {
                { "memberid", memberid },

            };

            DataTable result = DbControl.Data_Get(strsql, nvc);


            return result;


        }
        public static dynamic MyJoinLesson(string memberid)
        {

            string strsql = @"SELECT      tbl_lesson.startday,  tbl_lesson.address, tbl_lesson.lessontime, tbl_OrderData.ord_code, tbl_OrderData.memberid, tbl_Joindata.joinid, 
                            tbl_OrderData.paymode, tbl_OrderData.TotalPrice, tbl_OrderData.ordname, tbl_OrderData.ordphone, 
                            tbl_OrderData.ord_date, tbl_article.articleId, tbl_article.subject, tbl_article.pic, tbl_lesson.endday

FROM              tbl_OrderData INNER JOIN
                            tbl_Joindata ON tbl_OrderData.ord_code = tbl_Joindata.ord_code INNER JOIN
                            tbl_article ON tbl_Joindata.Articleid = tbl_article.articleId INNER JOIN
                            tbl_lesson ON tbl_Joindata.Articleid = tbl_lesson.articleId
WHERE          (tbl_OrderData.memberid = @memberid)
ORDER BY   tbl_OrderData.ord_code DESC ";

            NameValueCollection nvc = new NameValueCollection
            {
                { "memberid", memberid },

            };

            DataTable result = DbControl.Data_Get(strsql, nvc);


            return result;


        }
        public static dynamic MyCollection(string memberid ){
          
            string strsql = @" select  tbl_article.*
FROM              tbl_article INNER JOIN
                            tbl_articleCollection ON tbl_article.articleId = tbl_articleCollection.articleid
 where memberid =@memberid";

            NameValueCollection nvc = new NameValueCollection
            {
                { "memberid", memberid },
              
            };

            DataTable result = DbControl.Data_Get(strsql, nvc);
           

            return result;


        }
    }
    public class Mail
    {
        public static string Join_member(int memberid)

        {
            string site_name = "";
            Mmemberdata result = new Mmemberdata();
            result = Member.GetData(memberid.ToString());
            string filename = HttpContext.Current.Server.MapPath("/templates/letter.html");
            string mailbody = unity.classlib.GetTextString(filename);
            DataTable dt = unity.classlib.Get_Message(5);
            string msg = "";
            if (dt.Rows.Count > 0)
            {
     
                site_name = HttpContext.Current.Application["site_name"].ToString();
                string textbody = dt.Rows[0]["contents"].ToString().Replace("@site_name@", site_name);
                string subject = dt.Rows[0]["title"].ToString().Replace("@site_name@", site_name); ;
                mailbody = mailbody.Replace("@title@", subject);
                textbody = textbody.Replace("@email@", result.Email);
                textbody = textbody.Replace("@password@", result.Password);
                mailbody = mailbody.Replace("@mailbody@", textbody);
                msg = unity.classlib.SendsmtpMail(result.Email , subject, mailbody, "gmail");

            }
            if (result.Memberid == 0)
            {
                return "-1";
            }
            else
            {
                return msg;
            }

        }
        public static string Get_password(string email)

        {
            string site_name = "";
            Mmemberdata result = new Mmemberdata();
            result = Member.Check_exist(email);
            string filename = HttpContext.Current.Server.MapPath("/templates/letter.html");
            string mailbody = unity.classlib.GetTextString(filename);
            DataTable dt = unity.classlib.Get_Message(6);
            string msg = "";
            if (dt.Rows.Count > 0)
            {
                //foreach (var o in obj)
                // {
                //     if (o.Key == "site_name") site_name = o.Value;
                // }
                site_name = HttpContext.Current.Application["site_name"].ToString();
                string textbody = dt.Rows[0]["contents"].ToString().Replace("@site_name@", site_name);
                string subject = dt.Rows[0]["title"].ToString().Replace("@site_name@", site_name); ;
                mailbody = mailbody.Replace("@title@", subject);
                textbody = textbody.Replace("@password@", result.Password);
                mailbody = mailbody.Replace("@mailbody@", textbody);
                msg = unity.classlib.SendsmtpMail(email, subject, mailbody, "gmail");

            }
            if (result.Memberid == 0)
            {
                return "-1";
            }
            else
            {
                return msg;
            }

        }
    }
    public class Mmemberdata {

        public int Memberid { get; set; }
        public string Phone { get; set; }
        public string Mobile { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string FBid { get; set; }
      
        public DateTime Birthday { get; set; }
        public int Countyid { get; set; }
        public int Cityid { get; set; }
        public string Zip { get; set; }
        public string Address { get; set; }
    }

}