<%@ WebHandler Language="C#" Class="registemail" %>

using System;
using System.Web;

public class registemail : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string msg = DbControl.EmailRegist(context.Request["email"]);
        context.Response.Write("Y");
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}