using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using unity;
using System.Data;
using System.Data.SqlClient;


public partial class spadmin_authority : System.Web.UI.Page
{
    string FILEPATH = "upload/userPhoto/";
    string strsql;
    string unitid = "8";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["unitid"] != null)
        {
            unitid = Request.QueryString["unitid"];
        }
        if (!IsPostBack)
        {
          
            if (classlib.chkPower(Session["userid"].ToString(), unitid))
            {
               
                MultiView1.ActiveViewIndex = 0;
                selectSQL();

                //權限表
                strsql = "SELECT * FROM UnitData where upperid=0 and status<>'D' order by sort  ";
                SqlDataSource_power1.SelectCommand = strsql;
             
                Repeater_power1.DataBind();
            }
            else
            {
                Response.Redirect("noauth.aspx");

            }

        }
    }
    //權限表第二層
 
    protected void Repeater_power1_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
    {
       

        if (e.Item.ItemType != ListItemType.Footer & e.Item.ItemType != ListItemType.Header)
        {
            SqlDataSource sd = (SqlDataSource)e.Item.FindControl("SqlDataSource_power2");
            Repeater rp = (Repeater)e.Item.FindControl("Repeater_power2");
            rp.DataSourceID = sd.ID;
            DataRowView dr = (DataRowView)e.Item.DataItem;

            sd.SelectCommand = "SELECT * FROM UnitData where upperid=" + dr["unitid"].ToString() + "  and status<>'D' order by sort  ";
           
            rp.DataBind();

        }
    }

    public void selectSQL()
    {
        strsql = "SELECT * FROM   admin_account where user_id >0 ";
        if (Session["userid"].ToString() != "1")
        {
            strsql += " and user_id <> '1' ";
        }

        //getgvdata(SqlDataSource1, GridView1, strsql)
     
        SqlDataSource1.SelectCommand = strsql;
        Repeater1.DataBind();
    }


    //編輯
    protected void link_edit(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;

        Selected_id.Value = obj.CommandArgument;


        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";

        string strsql = "";
        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();
        SqlDataReader rs = default(SqlDataReader);
        conn.Open();

        strsql = "select * from  admin_account where user_id= " + Selected_id.Value + " ";

        cmd = new SqlCommand(strsql, conn);
        rs = cmd.ExecuteReader();
        if (rs.Read())
        {
         
            user_name.Text = rs["name"].ToString();
            account_pid.Text = rs["account_pid"].ToString();
            account_pwd.Text = rs["account_pwd"].ToString();
            memo.Text = rs["memo"].ToString();
        }
        rs.Close();
        cmd.Dispose();
        conn.Close();
        conn = new SqlConnection(classlib.dbConnectionString  );
        conn.Open();
        strsql = "select * from  powerlist  where user_id = '" + Selected_id.Value + "' ";
        cmd = new SqlCommand(strsql, conn);
        rs = cmd.ExecuteReader();

        while (rs.Read())
        {
            FindControls(rs["unitid"].ToString());
            //For Each control As Control In Table1.Controls
            //    FindControls(control.Controls, rs)
            //Next
        }
        rs.Close();
        cmd.Dispose();

        conn.Close();
    }



    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
       

        string user_id = "";
        string strsql = "";
        SqlConnection conn = new SqlConnection(classlib.dbConnectionString );
        SqlCommand cmd = new SqlCommand();
        SqlDataReader rs = default(SqlDataReader);
        conn.Open();

        if (Btn_save.CommandArgument == "add")
        {
            strsql = "insert into  admin_account (name, account_pwd, account_pid, memo  ) values ";
            strsql += "(@user_name, @account_pwd, @account_pid, @memo ) ";
        }
        else {
            strsql = "update admin_account set name=@user_name, account_pwd=@account_pwd, account_pid=@account_pid, memo=@memo ";           
            strsql += " where user_id =" + Selected_id.Value + " ";
        }
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("@user_name", SqlDbType.NVarChar).Value = user_name.Text;
        cmd.Parameters.Add("@account_pwd", SqlDbType.VarChar).Value = account_pwd.Text;
        cmd.Parameters.Add("@account_pid", SqlDbType.VarChar).Value = account_pid.Text;
        cmd.Parameters.Add("@memo", SqlDbType.NVarChar).Value = memo.Text;
        cmd.ExecuteNonQuery();
        cmd.Dispose();


        if (Btn_save.CommandArgument == "add")
        {
            strsql = "select max(user_id) from admin_account ";
            cmd = new SqlCommand(strsql, conn);
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                user_id = rs[0].ToString();
                //new user
            }
            rs.Close();
            cmd.Dispose();
            //  InserAction2(Session("UserID").ToString, getIP(Request), "I", "Users", user_id, user_name.Text);

            //update user
        }
        else {
            user_id = Selected_id.Value;
            //    InserAction2(Session("UserID").ToString, getIP(Request), "U", "Users", user_id, user_name.Text);

           
        }
        conn.Close();

        ChangeControl(user_id);

        MultiView1.ActiveViewIndex = 0;
        selectSQL();
        cleaninput();
    }

    protected void btn_del_Click(object sender, System.EventArgs e)
    {
        string strsql = "";
        SqlConnection conn = new SqlConnection(classlib.dbConnectionString );
        SqlCommand cmd = new SqlCommand();
        conn.Open();

        strsql = "delete from  admin_account  where user_id=" + Selected_id.Value + " ";
        cmd = new SqlCommand(strsql, conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();
        conn = new SqlConnection(classlib.dbConnectionString );
        conn.Open();
        //權限表全部清空
        strsql = "delete from  powerlist where user_id = '" + Selected_id.Value + "' ";
        cmd = new SqlCommand(strsql, conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();

        //  InserAction2(Session("UserID").ToString, getIP(Request), "D", "Users", Selected_id.Value, user_name.Text);


        MultiView1.ActiveViewIndex = 0;
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
        user_name.Text = "";
        account_pid.Text = "";
        account_pwd.Text = "";
        account_pid.Text = "";
        memo.Text = "";
       
        selectall(false);
    }

    //flag 全選/全不選
    public void selectall(bool flag)
    {
        foreach (RepeaterItem item in Repeater_power1.Items)
        {
            CheckBox chk = (CheckBox)item.FindControl("chk");
            chk.Checked = flag;

            Repeater Repeater_power2 = (Repeater)item.FindControl("Repeater_power2");
            foreach (RepeaterItem item2 in Repeater_power2.Items)
            {
                CheckBox chk2 = (CheckBox)item2.FindControl("chk");
                chk2.Checked = flag;
            }
        }
    }

    //查詢權限 select

    public void FindControls(string unitid)
    {
        foreach (RepeaterItem item in Repeater_power1.Items)
        {
            //Dim chk As CheckBox = CType(item.FindControl("chk"), CheckBox)
            //Dim Hidden_id As HiddenField = CType(item.FindControl("Hidden_id"), HiddenField)

            //If Hidden_id.Value = unitid Then
            //    chk.Checked = True
            //    Exit Sub
            //End If


            Repeater Repeater_power2 = (Repeater)item.FindControl("Repeater_power2");
            foreach (RepeaterItem item2 in Repeater_power2.Items)
            {
                CheckBox chk2 = (CheckBox)item2.FindControl("chk");
                HiddenField Hidden_id2 = (HiddenField)item2.FindControl("Hidden_id");

                if (Hidden_id2.Value == unitid)
                {
                    chk2.Checked = true;
                    return;
                }
            }
        }
    }

    //更改權限 update

    public void ChangeControl(string user_id)
    {
        string strsql = "";
        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();
        conn.Open();
        //權限表全部清空 再重新新增
        strsql = "delete from  powerlist where user_id = '" + user_id + "' ";
        cmd = new SqlCommand(strsql, conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        foreach (RepeaterItem item in Repeater_power1.Items)
        {
            //Dim chk As CheckBox = CType(item.FindControl("chk"), CheckBox)
            //Dim Hidden_id As HiddenField = CType(item.FindControl("Hidden_id"), HiddenField)

            //If chk.Checked Then
            //    strsql = "insert into powerlist ( user_id, unitid ) "
            //    strsql += " values (" & user_id & ", '" & Hidden_id.Value & "'); "
            //    cmd = New SqlCommand(strsql, conn)
            //    cmd.ExecuteNonQuery()
            //    cmd.Dispose()

            //End If


            Repeater Repeater_power2 = (Repeater)item.FindControl("Repeater_power2");
            foreach (RepeaterItem item2 in Repeater_power2.Items)
            {
                CheckBox chk2 = (CheckBox)item2.FindControl("chk");
                HiddenField Hidden_id2 = (HiddenField)item2.FindControl("Hidden_id");
              
             

                if (chk2.Checked)
                {
                    strsql = "insert into powerlist ( user_id, unitid ) ";
                    strsql += " values (" + user_id + ", '" + Hidden_id2.Value + "'); ";
                    cmd = new SqlCommand(strsql, conn);
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                }
            }
           
        }
        conn.Close();
        
    }


}