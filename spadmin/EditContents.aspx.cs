using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;


public partial class spadmin_EditContents : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string strsql = "select * from unitdata where unitid = @unitid";

            SqlConnection conn = new SqlConnection(classlib.dbConnectionString );
          
         
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs = default(SqlDataReader);
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("unitid", SqlDbType.Int).Value = Request.QueryString["unitid"];
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                contents.Text = rs["contents"].ToString();
                Label1.Text = "<h2>" + rs["unitname"].ToString() + "管理</h2>";
            }
            cmd.Dispose();
            rs.Close();
            conn.Close();





        }
    }

    protected void Btn_save_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);

        string strsql = "update unitdata set contents =@contents where unitid = @unitid";
        conn.Open();
        SqlCommand cmd = new SqlCommand();
        contents.Text = Server.HtmlDecode(contents.Text);
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("unitid", SqlDbType.Int ).Value = Request.QueryString ["unitid"] ;
        cmd.Parameters.Add("contents", SqlDbType.NVarChar).Value =  contents.Text ;
       cmd.ExecuteNonQuery ();
       
        cmd.Dispose();
       
        conn.Close();

    }
}