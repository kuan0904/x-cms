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

public class member_handle : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest(HttpContext context)
    {

        //安全性,上線要加
        string check = context.Request["_"];
        if (unity.classlib.IsNumeric(check) == false)
        {
            context.Response.End();

        }

        string p_ACTION = context.Request["p_ACTION"];
        string p_VERIFYCODE = context.Request["p_VERIFYCODE"];
        string p_ACCOUNT = context.Request["p_ACCOUNT"];
        string p_PASSWD = context.Request["p_PASSWD"];
        string p_username = context.Request["p_username"];

        string result = "";
        if (p_ACTION == "CheckLogin")
        {


            if (   context.Session["memberid"] == null ||  context.Session["memberid"] .ToString() == "")
                result = "-1";
            else
                result = "Y";
        context.Response.Write(result);
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
            if (result != "")            {

                context.Session["memberid"] = MemberLib.Member.GetData(result);
                result = "Y";
            }
            else
            {
                result = "-1";
            }

            context.Response.Write(result);
            context.Response.End();
        }
        if (p_ACTION == "googleLogin")
        {
      
            result = MemberLib.Member.GoogleLogin (p_ACCOUNT, p_PASSWD,p_username);
            if (result != "")            {

                context.Session["memberid"] = MemberLib.Member.GetData(result);
                result = "Y";
            }
            else
            {
                result = "-1";
            }

            context.Response.Write(result);
            context.Response.End();
        }
        if (p_ACTION == "Register")
        {
            result = MemberLib.Member.Check_exist(p_ACCOUNT);
            if (result == "Y")
            {
                result = "-1";
            }
            else
            {


                context.Session["memberid"] = MemberLib.Member.Add (p_ACCOUNT, p_PASSWD);
                result = "";
            }

            context.Response.Write(result);
            context.Response.End();
        }




    }

    public bool IsReusable {
    get {
        return false;
    }
}

}