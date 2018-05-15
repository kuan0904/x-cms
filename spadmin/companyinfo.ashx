<%@ WebHandler Language="C#" Class="companyinfo" %>

using System;
using System.Web;
using unity;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.SessionState;
using System.Collections.Specialized;
using System.Data;
public class companyinfo : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string p_ACTION = context.Request["action"];
        if (p_ACTION == "get") {

            string strsql = "select * from companydata ";
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = admin_contrl.Data_Get(strsql, nvc);
            string result= JsonConvert.SerializeObject(dt, Formatting.Indented);
            result = result.Replace("[", "").Replace("]", "").Replace("\r\n", "");
            result = JsonConvert.SerializeObject(result);

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