using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Collections.Specialized;


/// <summary>
/// dbcontrol 的摘要描述
/// </summary>
public class DbControl
{
    public static string dbConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["dbconnConnection"].ConnectionString;

    public DbControl()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    // <summary>
    //新增資料
    // </summary>
    // <param name="id">ID</param> 
    public static int Data_add(string strsql, NameValueCollection Parameters)
    {
        int i = 0;
        using (SqlConnection conn = new SqlConnection(dbConnectionString))
        {
            SqlCommand cmd = new SqlCommand();
            conn.Open();
            cmd = new SqlCommand(strsql, conn);

            for (i = 0; i < Parameters.Count; i++)
            {
                if (Parameters[i].Length > 4000)
                {
                    cmd.Parameters.Add("@" + Parameters.Keys[i], SqlDbType.NText ).Value = (Parameters[i] == "DBNull") ? (object)DBNull.Value : Parameters[i]; //(參數,宣考型態,長度)      

                }
                else
                {
                    cmd.Parameters.Add("@" + Parameters.Keys[i], SqlDbType.NVarChar).Value = (Parameters[i] == "DBNull") ? (object)DBNull.Value : Parameters[i]; //(參數,宣考型態,長度)      
                }
            }
            i = cmd.ExecuteNonQuery();           
            cmd.Dispose();
            conn.Close();

        }
        return i;
    }
    // <summary>
    //更新資料
    // </summary>
    // <param name="strsql">strsql</param> 
    public static int Data_Update(string strsql, NameValueCollection Parameters,string key)
    {

        int i = 0;
        using (SqlConnection conn = new SqlConnection(dbConnectionString))
        {
            SqlCommand cmd = new SqlCommand();
            conn.Open();
            cmd = new SqlCommand(strsql, conn);
           
            for (i = 0; i < Parameters.Count; i++)
            {
                cmd.Parameters.Add("@" + Parameters.Keys[i], SqlDbType.NVarChar).Value = Parameters[i]; //(參數,宣考型態,長度)      

            }
            cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = key;
            i = cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();

        }
        return i;

       
    }

    // <summary>
    //刪除資料
    // </summary>
    // <param name="id">ID</param> 
    public static int Data_delete(string strsql, string del_id)
    {
        int i = 0;
        using (SqlConnection conn = new SqlConnection(dbConnectionString))
        {
            SqlCommand cmd = new SqlCommand();
            conn.Open();
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = int.Parse(del_id);

            i = cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();

        }
        return i;
    }
    // <summary>
    //sqldata read
    // </summary>
    // <param name="id">ID</param> 
    public static DataTable Get_rsdata(string strsql, string id)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(dbConnectionString))
        {

            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;
            CMD.Parameters.Add("@id", SqlDbType.Int).Value = id; //(參數,宣考型態,長度)      
            DataSet ds = new DataSet();
            myAdapter.Fill(ds, "tbl");
            dt = ds.Tables["tbl"].DefaultView.ToTable();
            myAdapter.Dispose();
            ds.Dispose();
            conn.Close();

        }
        return dt;
    }

    // <summary>
    //取資料到datatable
    // </summary>
    // <param name="strsql">strsql</param> 
    public static DataTable Data_Get(string strsql, NameValueCollection Parameters)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(dbConnectionString))
        {

            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;
            for (int i = 0; i < Parameters.Count; i++)
            {
                CMD.Parameters.Add("@" + Parameters.Keys[i], SqlDbType.VarChar).Value = Parameters[i]; //(參數,宣考型態,長度)      

            }
            DataSet ds = new DataSet();
            myAdapter.Fill(ds, "tbl");
            dt = ds.Tables["tbl"].DefaultView.ToTable();
            myAdapter.Dispose();
            ds.Dispose();
            conn.Close();

        }
        return dt;
    }


}