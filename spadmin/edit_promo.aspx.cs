using System;

using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;


public partial class spadmin_edit_promo : System.Web.UI.Page
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
        strsql = "select * from    promo_system where ps_id  = @ps_id ";
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("ps_id", SqlDbType.NVarChar).Value = Selected_id.Value;
        rs = cmd.ExecuteReader();
        if (rs.Read())
        {
            status.SelectedValue = rs["status"].ToString();
            ps_name.Text = rs["ps_name"].ToString();
            ps_condition.Text = rs["ps_condition"].ToString();
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
            strsql = " insert into promo_system( ps_condition, status,  ps_name,contents ) values ";
            strsql += "(@ps_condition, @status, @ps_name,@contents ) ";
        }
        else {
            strsql = "update promo_system set ps_condition=@ps_condition,status=@status, ps_name=@ps_name";
            strsql += ",contents=@contents where ps_id =@ps_id";
        }


        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();
        conn.Open();
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("ps_condition", SqlDbType.NVarChar).Value = ps_condition.Text;
        cmd.Parameters.Add("status", SqlDbType.NVarChar).Value = status.SelectedValue;
        cmd.Parameters.Add("ps_name", SqlDbType.NVarChar).Value = ps_name.Text;
        cmd.Parameters.Add("contents", SqlDbType.NVarChar).Value = contents.Text;
        if (Btn_save.CommandArgument == "add")
        {

        }
        else {
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
    }

    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
    }


    public void cleaninput()
    {
        Selected_id.Value = "";
        ps_condition.Text = "1";
        ps_name.Text = "";


    }

    protected void btn_del_Click(object sender, System.EventArgs e)
    {

        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();

        conn.Open();

        cmd = new SqlCommand("update  promo_system set status = 'D' where ps_id = '" + Selected_id.Value + "' ", conn);
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
        cmd = new SqlCommand("update  promo_system set status = 'D' where ps_id = '" + obj.CommandArgument + "' ", conn);
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