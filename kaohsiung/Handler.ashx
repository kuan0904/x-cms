<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using unity;
public class Handler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string email = context.Request["email"];
        string msg = context.Request["msg"];
        string name = context.Request["name"];
        msg = "姓名:" + name + "<br>email:" + email + "<br>內容:" + msg;
        string s = classlib.SendsmtpMail("event@xnet.world", "我有問題", msg);
        context.Response.Write(s);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}