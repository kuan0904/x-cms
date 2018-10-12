using System;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.SessionState;
using System.Collections.Specialized;
using System.Data;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Web.Services;

public partial class spadmin_companyInfo : System.Web.UI.Page
{
    static string strsql = "";
    protected void Page_Init(object sender, EventArgs e)
    {
        string strsql = "select * from companydata ";
        NameValueCollection nvc = new NameValueCollection();
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0)
        {
            companyName.Text = dt.Rows[0]["companyName"].ToString();
            systemName.Text = dt.Rows[0]["systemName"].ToString();
            companyNo.Text = dt.Rows[0]["companyNo"].ToString();
            phone.Text = dt.Rows[0]["phone"].ToString();
            address.Text = dt.Rows[0]["address"].ToString();
            FacebookAppId.Text = dt.Rows[0]["FacebookAppId"].ToString();
            FacebookAppSecret.Text = dt.Rows[0]["FacebookAppSecret"].ToString();
            googleapiKey.Text = dt.Rows[0]["googleapiKey"].ToString();
            googleclientId.Text = dt.Rows[0]["googleclientId"].ToString();

        }

    }
    protected void Page_Load(object sender, EventArgs e)
    {

  

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile )
            FileUpload1.SaveAs(Server.MapPath ("/images/logo.png"));
        if (FileUpload2.HasFile)
            FileUpload2.SaveAs(Server.MapPath("/images/logo-m.png"));
    }





    protected void update_Click(object sender, EventArgs e)
    {
        string strsql = @"update companydata set  companyNo=@companyNo,
            companyName=@companyName,systemName=@systemName,
            address=@address,phone=@phone,FacebookAppId=@FacebookAppId,
            FacebookAppSecret=@FacebookAppSecret,googleclientId=@googleclientId,
            googleapiKey=@googleapiKey";
        int i = 0;
        using (SqlConnection conn = new SqlConnection(unity.classlib.dbConnectionString))
        {
            SqlCommand cmd = new SqlCommand();
            conn.Open();
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@companyNo", SqlDbType.VarChar).Value = companyNo.Text;
            cmd.Parameters.Add("@companyName", SqlDbType.VarChar).Value = companyName.Text;
            cmd.Parameters.Add("@systemName", SqlDbType.VarChar).Value = systemName.Text;
            cmd.Parameters.Add("@address", SqlDbType.VarChar).Value = address.Text;
            cmd.Parameters.Add("@phone", SqlDbType.VarChar).Value = phone.Text;
            cmd.Parameters.Add("@FacebookAppId", SqlDbType.VarChar).Value = FacebookAppId.Text;
            cmd.Parameters.Add("@FacebookAppSecret", SqlDbType.VarChar).Value = FacebookAppSecret.Text;
            cmd.Parameters.Add("@googleapiKey", SqlDbType.VarChar).Value = googleapiKey.Text;
            cmd.Parameters.Add("@googleclientId", SqlDbType.VarChar).Value = googleclientId.Text;

            i = cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }
    }
}