using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

using System.Collections.Specialized;

/// <summary>
/// admin_contrl 的摘要描述
/// </summary>
public class admin_contrl
{
    static string dbConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["dbconnConnection"].ConnectionString;
     public admin_contrl()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    public static DataTable Get_by_productcode(string productcode)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(dbConnectionString))
        {
            string strsql = @"SELECT * FROM         tbl_product INNER JOIN
                      tbl_product_kind ON tbl_product.KindId = tbl_product_kind.KindId  where productcode =@productcode  ";
            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;
            CMD.Parameters.Add("@productcode", SqlDbType.VarChar).Value = productcode;//(參數,宣考型態,長度)                  
            DataSet ds = new DataSet();
            myAdapter.Fill(ds, "tbl");
            dt = ds.Tables["tbl"].DefaultView.ToTable();
            myAdapter.Dispose();
            ds.Dispose();
            conn.Close();

        }
        return dt;
    }

    public static string check_power(string unitid,  string userid)
    {
        string flag = "";
        using (SqlConnection conn = new SqlConnection(dbConnectionString))
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
        return flag ;
    }

    // <summary>
    //新增資料
    // </summary>
    // <param name="id">ID</param> 
    public static int Data_update(string strsql, NameValueCollection Parameters,string id)
    {
        int i = 0;
        using (SqlConnection conn = new SqlConnection(dbConnectionString))
        {
            SqlCommand cmd = new SqlCommand();
            conn.Open();
            cmd = new SqlCommand(strsql, conn);

            for (i = 0; i < Parameters.Count; i++)
            {

                cmd.Parameters.Add("@" + Parameters.Keys[i], SqlDbType.VarChar).Value = (Parameters[i] == "DBNull") ? (object)DBNull.Value : Parameters[i]; //(參數,宣考型態,長度)      

            }
            cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;  
            i = cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();

        }
        return i;
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

                cmd.Parameters.Add("@" + Parameters.Keys[i], SqlDbType.VarChar).Value =  (Parameters[i] == "DBNull") ? (object)DBNull.Value : Parameters[i] ; //(參數,宣考型態,長度)      

            }
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
    public static int  Data_delete(string strsql, string del_id) {
        int i=0;
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
    public static DataTable   get_rsdata(string strsql, string id)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(dbConnectionString))
        {

            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;           
            CMD.Parameters.Add("@id" , SqlDbType.Int ).Value = id; //(參數,宣考型態,長度)      
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
    public static DataTable  Data_Get(string strsql, NameValueCollection Parameters)
    {
        DataTable dt=  new DataTable();  
        using (SqlConnection conn = new SqlConnection(dbConnectionString))
        {

            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand CMD = new SqlCommand(strsql, conn);
            myAdapter.SelectCommand = CMD;
            for (int i =0;i< Parameters.Count; i++) {
                CMD.Parameters.Add("@"+ Parameters.Keys[i], SqlDbType.VarChar).Value = Parameters[i]; //(參數,宣考型態,長度)      
        
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