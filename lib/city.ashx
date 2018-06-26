<%@ WebHandler Language="C#" Class="city" %>

using System;
using System.Web;

using System.Data;
using System.Data.SqlClient;

public class city : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string check = context.Request["_"];
        if (unity.classlib.IsNumeric( check ) == false)
        {
            context.Response.End();

        }
        int p_COUNTYID= int.Parse ( context.Request["p_COUNTYID"]);

        using (SqlConnection conn = new SqlConnection(unity.classlib.dbConnectionString))
        {
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;
            conn.Open();
            string strsql = "SELECT  * from tbl_city where countyid =@countyid ";
             context.Response.Write("<option value=\"\">請選擇</option>");
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("countyid", SqlDbType.Int ).Value = p_COUNTYID ;
            rs = cmd.ExecuteReader();
            while (rs.Read())
            {
                context.Response.Write("<option value=\"" + rs["cityid"].ToString () + "-" + rs["zip"].ToString () +  "\">" + rs["cityname"].ToString () + "</option>");
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