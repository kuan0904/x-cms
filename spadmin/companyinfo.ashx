<%@ WebHandler Language="C#" Class="companyinfo" %>

using System;
using System.Web;
using unity;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.SessionState;
using System.Collections.Specialized;
using System.Data;

using System.Data.SqlClient;
public class companyinfo : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        if (context.Session["userid"] == null)
        {
              context.Response.End();
        }
        string p_ACTION = context.Request["action"];
        if (p_ACTION == "get") {

            string strsql = "select * from companydata ";
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt =DbControl .Data_Get(strsql, nvc);
            string result= JsonConvert.SerializeObject(dt, Formatting.Indented);
           // result = result.Replace("[", "").Replace("]", "").Replace("\r\n", "");
          //  result = JsonConvert.SerializeObject(result);
            context.Response.Write(result);
            context.Response.End();
        }
        if (p_ACTION == "set") {

            string strsql = @"update companydata set  companyNo=@companyNo,
            companyName=@companyName,systemName=@systemName,
            address=@address,phone=@phone,FacebookAppId=@FacebookAppId,
            FacebookAppSecret=@FacebookAppSecret,googleclientId=@googleclientId,
            googleapiKey=@googleapiKey,logoPic=@logoPic";
            int i = 0;
            using (SqlConnection conn = new SqlConnection(unity.classlib.dbConnectionString))
            {
                SqlCommand cmd = new SqlCommand();
                conn.Open();
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@companyNo", SqlDbType.VarChar).Value = context.Request["companyNo"];
                cmd.Parameters.Add("@companyName", SqlDbType.VarChar).Value = context.Request["companyName"];
                cmd.Parameters.Add("@systemName", SqlDbType.VarChar).Value = context.Request["systemName"];
                cmd.Parameters.Add("@address", SqlDbType.VarChar).Value = context.Request["address"];
                cmd.Parameters.Add("@phone", SqlDbType.VarChar).Value = context.Request["phone"];
                cmd.Parameters.Add("@FacebookAppId", SqlDbType.VarChar).Value = context.Request["FacebookAppId"];
                cmd.Parameters.Add("@FacebookAppSecret", SqlDbType.VarChar).Value = context.Request["FacebookAppSecret"];
                cmd.Parameters.Add("@googleapiKey", SqlDbType.VarChar).Value = context.Request["googleapiKey"];     
                cmd.Parameters.Add("@googleclientId", SqlDbType.VarChar).Value = context.Request["googleclientId"];   
                cmd.Parameters.Add("@logoPic", SqlDbType.VarChar).Value = context.Request["logoPic"];
                i=cmd.ExecuteNonQuery();
                cmd.Dispose();
                conn.Close();

            }


            context.Response.Write(i);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}