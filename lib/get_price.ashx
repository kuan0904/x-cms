<%@ WebHandler Language="C#" Class="get_price" %>


using System;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using unity;

public class get_price : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        int p_ID = 1;
        int p_num = 1;
        if ( context.Request["p_ID"] != null) p_ID = int.Parse (context.Request["p_ID"]);
        if ( context.Request["p_num"] != null) p_num = int.Parse (context.Request["p_num"]);
        string p_price = classlib.get_price(p_ID, p_num ).ToString ();  
       
        context.Response.Write(p_price);
        context.Response.End();
    }


    public bool IsReusable {
        get {
            return false;
        }
    }

}