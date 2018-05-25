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
    public static int Article_Add()
    {
        int id = 0;
        string strsql = "insert into tbl_article ( Viewcount, FBCount, GoogleCount,PinterestCount) values (0,0,0,0);SELECT SCOPE_IDENTITY();";
        NameValueCollection nvc = new NameValueCollection();
        id = DbControl.Data_add (strsql, nvc);
        nvc.Clear();
        strsql = "select max(articleId) from  tbl_article ";      
        DataTable dt = DbControl.Data_Get (strsql, nvc);
        if (dt.Rows.Count > 0) id = (int)dt.Rows[0][0];
        dt.Dispose();
        return id;
    }

    public static int  Article_Update(article.MainData  ad)
    {
        string strsql = @"update  tbl_article set 
                subject =@subject,pic=@pic,subtitle=@subtitle,postday=@postday,contents=@contents ,
                keyword=@keyword,status=@status
                where articleId =@id ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("subject", ad.Subject );
        nvc.Add("pic", ad.Pic );
        nvc.Add("subtitle", ad.SubTitle );
        nvc.Add("postday", ad.PostDay.ToString ("yyyy/MM/dd"));
        nvc.Add("contents", ad.Contents );
        nvc.Add("keyword", ad.Keywords);
        nvc.Add("status", ad.Status);
        int i = Data_Update(strsql, nvc, ad.Id.ToString());
        nvc.Clear();
        strsql = "delete from tbl_article_tag where articleId =@id";
        i = Data_delete (strsql, ad.Id.ToString ());

        string[] tags = ad.Tags;
        foreach (string s in tags)
        {
            nvc.Clear();
            strsql = @"insert into tbl_article_tag (articleId,tagid,unitid)
                values (@articleId,@tagid,@unitid)";
            nvc.Add("articleId", ad.Id.ToString ());
            nvc.Add("tagid", s);
            nvc.Add("unitid", "13");
            i = Data_add(strsql, nvc);
        }
        
        tags = ad.Writer;
        foreach (string s in tags)
        {
            nvc.Clear();
            strsql = @"insert into tbl_article_tag (articleId,tagid,unitid)
                values (@articleId,@tagid,@unitid)";
            nvc.Add("articleId", ad.Id.ToString());
            nvc.Add("tagid", s);
            nvc.Add("unitid", "14");
            i = Data_add(strsql, nvc);
        }
        strsql = "delete from Tbl_article_category where articleId =@id";
        i = Data_delete(strsql, ad.Id.ToString());
       
        string[] categoryid = ad.Category ;
        foreach (string s in categoryid)
        {
            nvc.Clear();
            strsql = @"insert into Tbl_article_category (articleId,categoryid)
                values (@articleId,@categoryid)";
            nvc.Add("articleId", ad.Id.ToString());
            nvc.Add("categoryid", s);       
            i = Data_add(strsql, nvc);
        }
        nvc.Clear();


        return i;



    }

    public static int Article_item_Update(List< article.ItemData > itemData)
    {
        string strsql = "delete from tbl_article_item where articleId =@id";
        NameValueCollection nvc = new NameValueCollection();
        int i = 0;

        foreach (article.ItemData idx in itemData)
       
        {
            if (i == 0)
            {
                i = Data_delete(strsql, idx.Id.ToString());
            }
            i++;
            nvc.Clear();
            strsql = @"insert into tbl_article_item (articleId,secno,subject,contents)
                values (@articleId,@secno,@subject,@contents)";
            nvc.Add("articleId", idx.Id.ToString () );
            nvc.Add("secno", idx.Secno .ToString ());
            nvc.Add("subject", idx.Title );
            nvc.Add("contents", idx.Contents );
            i = Data_add(strsql, nvc);
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