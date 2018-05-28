<%@ WebHandler Language="C#" Class="Get_data" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;

using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

using System.Collections.Specialized;
using article;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
public class Get_data : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string kind = context.Request["kind"];
        string tbl = context.Request["tbl"];
        string id = context.Request["id"];
        string result = "";
        if (kind == "list" && tbl == "banner" && id != null)
        {
            result = Get_banner_list("1");
            context.Response.Write(result);
        }
    }
    public static string Get_banner_list(string ClassId)
    {
        List<Banner.MainData> MainData = new List<Banner.MainData>();
        MainData = Banner.DbHandle.Banner_Get_list (int.Parse(ClassId));
        string result = JsonConvert.SerializeObject(MainData);
       
        return(result);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}