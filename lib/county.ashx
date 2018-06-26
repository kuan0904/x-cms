<%@ WebHandler Language="C#" Class="county" %>

using System;
using System.Web;

using System.Data.SqlClient;

public class county : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
                  context.Response.Write("<option value=\"\">請選擇</option>");
              
               using (SqlConnection conn = new SqlConnection(unity.classlib.dbConnectionString))
            {
                SqlCommand cmd = new SqlCommand();
                SqlDataReader rs;
                conn.Open();
                string strsql = "SELECT  * from tbl_county ";
                cmd = new SqlCommand(strsql, conn);
                
                rs = cmd.ExecuteReader();
                while (rs.Read())
                {
                    context.Response.Write("<option value=\"" + rs["countyid"].ToString () +  "\">" + rs["countyname"].ToString () + "</option>");
                }
                rs.Close();
                cmd.Dispose();               
                conn.Close();




            }
     
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}