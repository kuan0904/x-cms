using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Diagnostics;
using System.Data.SqlClient;
using unity;
using System.Collections.Specialized;


public partial class spadmin_edit_tag : System.Web.UI.Page
{
    static string strsql = "";
    string unitid = "";
    public static string unitname = "";
    protected void Page_Init(object sender, EventArgs e)
    {

        unitid = Request.QueryString["unitid"];   
        unitname = unitlib.Get_UnitName(int.Parse(unitid));  

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

      
        string strsql = "SELECT *  FROM tbl_tag where unitid =  @unitid  ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("unitid", unitid);
        DataTable dt =DbControl.Data_Get(strsql, nvc);
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
            tagname.Text = rs["tagname"].ToString();
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
        cmd.Parameters.Add("tagname", SqlDbType.NVarChar).Value = tagname.Text;
        if (Btn_save.CommandArgument == "add")
        {
            cmd.Parameters.Add("unitid", SqlDbType.VarChar).Value =unitid;
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
        tagname.Text = "";
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
