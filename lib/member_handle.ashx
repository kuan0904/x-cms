<%@ WebHandler Language="C#" Class="member_handle" %>

using System;
using System.Web;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using unity;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.SessionState;
using System.Collections.Specialized;
public class member_handle : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest(HttpContext context)
    {

        //安全性,上線要加
        string check = context.Request["_"];


        string p_ACTION = context.Request["p_ACTION"];
        string p_VERIFYCODE = context.Request["p_VERIFYCODE"];
        string p_ACCOUNT = context.Request["p_ACCOUNT"];
        string p_PASSWD = context.Request["p_PASSWD"];
        string p_username = context.Request["p_username"];
   
        if (unity.classlib.IsNumeric(check) == false)
        {
            context.Response.End();

        }
        MemberLib.Mmemberdata  result = new MemberLib.Mmemberdata ();
        string status = "";

        if (p_ACTION == "CheckLogin")
        {


            if (   context.Session["memberdata"] == null ||  context.Session["memberdata"] .ToString() == "")
                status = "";
            else
                status = JsonConvert.SerializeObject(context.Session["memberdata"]);
            context.Response.Write(status);
            context.Response.End();
        }
        if (p_ACTION == "Login")
        {
            //if (context.Session["CAPTCHA"] != null & context.Session["CAPTCHA"].ToString() != p_VERIFYCODE)
            //{
            //    context.Response.Write("-1");
            //    context.Response.End();
            //}
            result = MemberLib.Member.Login(p_ACCOUNT, p_PASSWD);

            if (result.Memberid  != 0)            {
                context.Session["memberdata"] = result;
                status = "Y";
            }
            else
            {
                status = "-1";
            }

            context.Response.Write(status);
            context.Response.End();
        }
     
        if (p_ACTION == "Register")
        {
            result = MemberLib.Member.Check_exist(p_ACCOUNT);

            if (result.Memberid  != 0)
            {
                status  = "-1";
            }
            else
            {


                context.Session["memberdata"] = MemberLib.Member.Add (p_ACCOUNT, p_PASSWD,"");
                status = "Y";
            }

            context.Response.Write(status);
            context.Response.End();
        }
        if (p_ACTION == "Update")
        {
            if (context.Session["memberdata"] != null)
            {
                MemberLib.Mmemberdata o = (MemberLib.Mmemberdata)context.Session["memberdata"];
                MemberLib.Mmemberdata m = new MemberLib.Mmemberdata();
                m.Memberid = o.Memberid;
                m.Address = context.Request["address"];
                m.Phone = context.Request["phone"];
                m.Mobile = context.Request["mobile"];
                m.Username = context.Request["username"];
                m.Birthday =DateTime.Parse ( context.Request["birthday"]);
                m.Cityid = int.Parse(context.Request["cityid"]);
                m.Countyid = int.Parse(context.Request["countyid"]);
                m.Zip = context.Request["zip"];
                m.Password  = context.Request["Password"];
                m.Email = context.Request["Email"];

                m= MemberLib.Member.Update(m);
                context.Session["memberdata"] = m;
                status = JsonConvert.SerializeObject(context.Session["memberdata"]);
                context.Response.Write(status);
            }
            else
            {
                context.Response.Write(status);
            }



        }
        if (p_ACTION== "forget_password")
        {


            string msg = MemberLib.Mail .Get_password(p_ACCOUNT);
            if (msg == "") msg = "Y";
            context.Response.Write(msg);
        }


    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}