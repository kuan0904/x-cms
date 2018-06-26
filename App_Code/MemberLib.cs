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
    public class Member
    {
        public static  String Check_exist(string id,string fbid ="")
        {
            string result = "";
            string strsql = "select email from  MemberData where  email =@id or fbid=@id ";

            NameValueCollection nvc = new NameValueCollection
            {
                { "id", id.ToString() }
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count != 0) result = "Y";
            dt.Dispose();
            return result;        

        }
        public static Mmemberdata Add(string email,string password, string fbid = ""
                ,string googleid="", string username="",string phone="")
        {
            string result = "";
            string strsql = @"insert  into MemberData ( email,password ,fbid,googleid,phone)
            values  ( @email,@password,@fbid,@googleid,@phone ) ";
            NameValueCollection nvc = new NameValueCollection
            {
                { "email", email  },
                { "password", password  },
                { "fbid", fbid  },
                { "googleid", googleid  },
                { "phone", phone  }
            };
            DbControl.Data_add (strsql, nvc);
            if (googleid != "")
                result = GoogleLogin(googleid, email, username);
            else
                result = Login(email, password, fbid);           
            return GetData (result );

        }
        public static  string  Login(string email, string password,string fbid="")
        {
            string result = "";
            string strsql = @"select memberid from MemberData  where  (email=@email and password=@password ) ";
            if (fbid != "") {strsql = @"select memberid from MemberData  where  (fbid=@fbid ) "; }
         
            NameValueCollection nvc = new NameValueCollection
            {
                { "fbid", fbid  },
                { "email", email  },
                { "password", password  },
              
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count > 0) result = dt.Rows[0]["memberid"].ToString();
            dt.Dispose();
            return result;

        }
        public static string GoogleLogin(string googleid,string email, string displayName)
        {
            string result = "";
            string strsql = @"select memberid from MemberData  where  (googleid=@googleid ) "; 
            NameValueCollection nvc = new NameValueCollection
            {       
                {"googleid",googleid }
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count > 0) result = dt.Rows[0]["memberid"].ToString();
            else
            {
                MemberLib.Member.Add(email, email, "", googleid, displayName, "");
                dt = DbControl.Data_Get(strsql, nvc);
                if (dt.Rows.Count > 0) result = dt.Rows[0]["memberid"].ToString();
            }
            dt.Dispose();
        
            return result;

        }
        public static Mmemberdata GetData(string memberid)
        {
            
            string strsql = @"select * from MemberData  where  (memberid =@memberid) ";
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
                m.Password = dt.Rows[0]["Password"].ToString();
                m.Username = dt.Rows[0]["Username"].ToString();
            }
            return m ;

        }
    }

    public class Mmemberdata {

        public int Memberid { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string FBid { get; set; }
        public string Googleid { get; set; }
    }

}