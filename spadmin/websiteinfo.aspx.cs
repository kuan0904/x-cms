using System;

using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
using System.Collections.Specialized;
public partial class spadmin_websiteinfo : System.Web.UI.Page
{
    static string strsql = "";
    protected void Page_Init(object sender, EventArgs e)
    {

    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            selectSQL();

        }

    }
    public void selectSQL()
    {
        string strsql = "SELECT *  FROM WebSiteInfo  ";
        NameValueCollection nvc = new NameValueCollection();
      
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();
        dt.Dispose();
        nvc.Clear();
        ListView1.DataBind();

    }

    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        selectSQL();
    }

    //編輯
    protected void link_edit(object sender, System.EventArgs e)
    {
        WebId.ReadOnly = true;
        LinkButton obj = sender as LinkButton;
        Selected_id.Value = obj.CommandArgument;
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";
        string strsql = "";
        SqlConnection conn = new SqlConnection(unity.classlib.dbConnectionString);
        SqlDataReader rs = default(SqlDataReader);
        SqlCommand cmd = new SqlCommand();
        conn.Open();
        strsql = "select * from   WebSiteInfo where Webid  = @Webid ";
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("Webid", SqlDbType.NVarChar).Value = Selected_id.Value;
        rs = cmd.ExecuteReader();
        if (rs.Read())
        {

            WebId.Text = rs["WebId"].ToString();
            value.Text = rs["value"].ToString();

        }
        rs.Close();
        cmd.Dispose();
        conn.Close();
    }



    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
        string strsql = "";

        //-----------------------------------------------------------------------

        if (Btn_save.CommandArgument == "add")
        {
            strsql = " insert into WebSiteInfo( WebId , value) values ";
            strsql += "(@WebId,@value ) ";
        }
        else
        {
            strsql = "update WebSiteInfo set value=@value where WebId =@WebId";
        }

        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();
        conn.Open();
        cmd = new SqlCommand(strsql, conn);

        cmd.Parameters.Add("value", SqlDbType.NVarChar).Value = value.Text;
        cmd.Parameters.Add("WebId", SqlDbType.NVarChar).Value = WebId.Text;
        if (Btn_save.CommandArgument == "add")
        {

        }
        else
        {
            cmd.Parameters.Add("ps_id", SqlDbType.VarChar).Value = Selected_id.Value;
        }


        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();

        MultiView1.ActiveViewIndex = 0;

        cleaninput();
        selectSQL();
    }




    protected void Btn_add_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "add";
        cleaninput();
        WebId.ReadOnly = false;
    }

    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
    }


    public void cleaninput()
    {
        Selected_id.Value = "";
        WebId.Text = "";
        value.Text = "";


    }

    protected void btn_del_Click(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();

        conn.Open();

        cmd = new SqlCommand("delete from  WebSiteInfo  where WebId = '" + obj.CommandArgument + "' ", conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();


        selectSQL();
    }



    //刪除
    protected void link_delete(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        //string[] arg = obj.CommandArgument.ToString.Split(",");
        //sql_delete(arg[0], arg[1]);

        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();

        conn.Open();
        cmd = new SqlCommand("delete from  WebSiteInfo  where WebId = '" + obj.CommandArgument + "' ", conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();


        selectSQL();

    }




}