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
        public static Mmemberdata Update(Mmemberdata m )
        {

            string strsql = @"update tbl_MemberData set email=@email,
            username=@username
            ,phone=@phone
            ,mobile=@mobile
            ,cityid=@cityid 
            ,countyid=@countyid
            ,zip=@zip
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
                { "id", id.ToString() }
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count != 0)
                result = GetData(dt.Rows[0]["memberid"].ToString()) ;
            dt.Dispose();
            return result;        

        }
        public static Mmemberdata Add(string email, string password, string fbid = ""
                , string googleid = "", string username = "", string phone = "")
        {
            Mmemberdata result = new Mmemberdata();
            result = Check_exist(email);
            if (result.Memberid == 0)
            {
                string strsql = @"insert  into tbl_MemberData ( email,password ,fbid,googleid,phone)
                values  ( @email,@password,@fbid,@googleid,@phone ) ";
                NameValueCollection nvc = new NameValueCollection
                {
                    { "email", email  },
                    { "password", password  },
                    { "fbid", fbid  },
                    { "googleid", googleid  },
                    { "phone", phone  }
                };
                DbControl.Data_add(strsql, nvc);
            }
            if (googleid != "") { 
                result = GoogleLogin(googleid, email, username);
          
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
        public static Mmemberdata GoogleLogin(string googleid,string email, string displayName)
        {
            Mmemberdata result = new Mmemberdata();
            string strsql = @"select memberid from tbl_MemberData  where  (googleid=@googleid ) "; 
            NameValueCollection nvc = new NameValueCollection
            {       
                {"googleid",googleid }
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count > 0) result = GetData(dt.Rows[0]["memberid"].ToString());
            else
            {
                MemberLib.Member.Add(email, email, "", googleid, displayName, "");
                dt = DbControl.Data_Get(strsql, nvc);
                if (dt.Rows.Count > 0) result = GetData(dt.Rows[0]["memberid"].ToString());
            }
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
    }

    public class Mmemberdata {

        public int Memberid { get; set; }
        public string Phone { get; set; }
        public string Mobile { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string FBid { get; set; }
        public string Googleid { get; set; }
        public DateTime Birthday { get; set; }
        public int Countyid { get; set; }
        public int Cityid { get; set; }
        public string Zip { get; set; }
        public string Address { get; set; }
    }

}