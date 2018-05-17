using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// xnet 的摘要描述
/// </summary>
public class authority
{
    public authority()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    public static string check_power(string unitid, string userid)
    {
        string flag = "";
        using (SqlConnection conn = new SqlConnection(dbcontrol.dbConnectionString))
        {
            string strsql = "SELECT   * FROM Powerlist where user_id=@userid and unitid=@unitid";
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;
            conn.Open();
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@userid", SqlDbType.VarChar).Value = userid;
            cmd.Parameters.Add("@unitid", SqlDbType.VarChar).Value = unitid;
            rs = cmd.ExecuteReader();
            if (rs.Read()) flag = "Y";
            cmd.Dispose();
            conn.Close();

        }
        return flag;
    }

}