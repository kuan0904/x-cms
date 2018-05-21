using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
using System.Collections.Specialized;
public partial class spadmin_Edit_article : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
       
       
        string strsql = "SELECT *  FROM tbl_tag where status='Y' and unitid=13 ";
        NameValueCollection nvc = new NameValueCollection();       
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        int i = 0;
        for (i = 0; i < dt.Rows.Count; i++)
        {
            tag.Items.Add(new ListItem(dt.Rows[i]["tagname"].ToString(),dt.Rows[i]["tagid"].ToString()));
        }
        dt.Dispose();
        strsql ="SELECT *  FROM tbl_tag where status='Y' and unitid=14 ";
        dt = admin_contrl.Data_Get(strsql, nvc);
        
        for (i = 0; i < dt.Rows.Count; i++)
        {
            writer.Items.Add(new ListItem(dt.Rows[i]["tagname"].ToString(), dt.Rows[i]["tagid"].ToString()));
        }
        dt.Dispose();
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


        string strsql = "SELECT *  FROM tbl_article order by  articleid desc ";
        NameValueCollection nvc = new NameValueCollection();      
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();
        dt.Dispose();
        nvc.Clear();

    }

    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        selectSQL();
    }
    //編輯
    protected void link_edit(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        Selected_id.Value = obj.CommandArgument;
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";
        string strsql = "";

        SqlConnection conn = new SqlConnection(unity.classlib.dbConnectionString);
        SqlDataReader rs = default(SqlDataReader);
        SqlCommand cmd = new SqlCommand();
        conn.Open();

        strsql = "select * from    tbl_tag where tagid  = @classid ";
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("classid", SqlDbType.NVarChar).Value = Selected_id.Value;
        rs = cmd.ExecuteReader();
        if (rs.Read())
        {
           
            status.SelectedValue = rs["status"].ToString();

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
            strsql = " insert into  tbl_tag( tagname, status, unitid) values ";
            strsql += "(@tagname, @status, @unitid ) ";
        }
        else
        {
            strsql = @"update  tbl_tag set tagname=@tagname,status=@status
            where tagid =@tagid";
        }


        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();
        conn.Open();
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("status", SqlDbType.VarChar).Value = status.SelectedValue;
      
        if (Btn_save.CommandArgument == "add")
        {
        
        }
        else
        {
            cmd.Parameters.Add("tagid", SqlDbType.VarChar).Value = Selected_id.Value;
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
    }
    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
    }
    public void cleaninput()
    {
        Selected_id.Value = "";
        
    }
    protected void btn_del_Click(object sender, System.EventArgs e)
    {

        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();

        conn.Open();

        cmd = new SqlCommand("update  tbl_category set status = 0 where categoryid = '" + Selected_id.Value + "' ", conn);
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
        cmd = new SqlCommand("update  tbl_category set status = 0 where categoryid = '" + obj.CommandArgument + "' ", conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();
        selectSQL();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Button obj = sender as Button;
        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();

        conn.Open();
        cmd = new SqlCommand("update  from   tbl_tag  set status ='D' where  tagid = '" + obj.CommandArgument + "' ", conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();

        selectSQL();
    }
}