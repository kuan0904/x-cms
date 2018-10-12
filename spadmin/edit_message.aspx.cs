using System;

using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
using System.Collections.Specialized;

public partial class spadmin_edit_message : System.Web.UI.Page
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
        string strsql = @"SELECT *  FROM tbl_message where status <> 'D' order by  msg_id  ";

        NameValueCollection nvc = new NameValueCollection();
     
        DataTable dt = DbControl.Data_Get(strsql, nvc);

        ListView1.DataSource = dt;
        ListView1.DataBind();

     

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
        strsql = "select * from    tbl_message where msg_id = @msg_id";
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("msg_id", SqlDbType.NVarChar).Value = Selected_id.Value;
        rs = cmd.ExecuteReader();
        if (rs.Read())
        {
            status.SelectedValue = rs["status"].ToString();
            title.Text = rs["title"].ToString();
            condition.Text = rs["condition"].ToString();
            contents.Text  = rs["contents"].ToString();
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
            strsql = " insert into tbl_message( condition, status,  title,contents ) values ";
            strsql += "(@condition, @status, @title,@contents ) ";
        }
        else {
            strsql = "update tbl_message set condition=@condition,status=@status, title=@title";
            strsql += ",contents=@contents where msg_id=@msg_id";
        }


        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();
        conn.Open();
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("condition", SqlDbType.NVarChar).Value = condition.Text;
        cmd.Parameters.Add("status", SqlDbType.NVarChar).Value = status.SelectedValue;
        cmd.Parameters.Add("title", SqlDbType.NVarChar).Value = title.Text;
        cmd.Parameters.Add("contents", SqlDbType.NVarChar).Value = contents.Text;
        if (Btn_save.CommandArgument == "add")
        {

        }
        else {
            cmd.Parameters.Add("msg_id", SqlDbType.VarChar).Value = Selected_id.Value;
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
        condition.Text = "1";
        title.Text = "";


    }

    protected void btn_del_Click(object sender, System.EventArgs e)
    {

        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();

        conn.Open();

        cmd = new SqlCommand("update  tbl_message set status = 'D' where tbl_message= '" + Selected_id.Value + "' ", conn);
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
        cmd = new SqlCommand("update  tbl_message set status = 'D' where tbl_message= '" + obj.CommandArgument + "' ", conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();


        selectSQL();

    }


    public string statusTotxt(string str)
    {
        if (str == "Y")
        {
            return "開啟";
        }
        if (str == "N")
        {
            return "關閉";
        }
        return "";

    }


}