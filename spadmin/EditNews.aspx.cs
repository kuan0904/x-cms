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

public partial class spadmin_EditNews : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;

            selectSQL();
        }

    }
    protected void link_edit(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        Selected_id.Value = obj.CommandArgument;

        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;

            string strsql = "select * from tbl_news where n_id = @n_id";           
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("n_id", SqlDbType.Int ).Value = Selected_id.Value;
           
            rs = cmd.ExecuteReader();

           if (rs.Read())
            {

                subject.Text = rs["n_title"].ToString ();
                contents.Text  = rs["n_cont"].ToString();
                post_date .Text = DateTime.Parse(rs["n_date"].ToString()).ToString("yyyy/MM/dd");
                status.SelectedValue = rs["n_status"].ToString(); 
            }
             

            cmd.Dispose();
            rs.Close();
            conn.Close();
        }

        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";

    }
    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            conn.Open();
            string strsql = "";
            SqlCommand cmd = new SqlCommand();
            if (Btn_save.CommandArgument == "add")
            {
                strsql = @"insert into tbl_news ( n_title , n_cont,n_date,n_status ) values
                ( @n_title , @n_cont,@n_date,@n_status )";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("n_title", SqlDbType.VarChar).Value = subject.Text;
                cmd.Parameters.Add("n_cont", SqlDbType.VarChar).Value = contents.Text ;
                cmd.Parameters.Add("n_date", SqlDbType.VarChar).Value = post_date.Text;
                cmd.Parameters.Add("n_status", SqlDbType.VarChar).Value = status.SelectedValue;


            }
            else
            {
                strsql = @"update  tbl_news set  n_title=@n_title ,n_cont=@n_cont,
                n_date=@n_date,n_status=@n_status where n_id = @n_id";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("n_title", SqlDbType.VarChar).Value = subject.Text;
                cmd.Parameters.Add("n_cont", SqlDbType.VarChar).Value = contents.Text;
                cmd.Parameters.Add("n_date", SqlDbType.VarChar).Value = post_date.Text;
                cmd.Parameters.Add("n_status", SqlDbType.VarChar).Value = status.SelectedValue;
                cmd.Parameters.Add("n_id", SqlDbType.Int).Value = Selected_id.Value;

                
            }
            cmd.ExecuteNonQuery();
            conn.Close();

        }

        selectSQL();
            MultiView1.ActiveViewIndex = 0;
        }
      protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {

        MultiView1.ActiveViewIndex = 0;
    }

 
    protected void Button1_Click1(object sender, EventArgs e)
    {
        //    LinqDataSource1.Where = "n_title.Contains(\"" + keyword.Text + "\")   ";
        selectSQL();
        // LinqDataSource1.Where = "account.Contains(""new"")"
    }
    public void selectSQL()
    {
        string strsql = "select * from tbl_news    ";
        if (keyword.Text != "")
        {
            strsql += " where n_title like '%" + keyword.Text + "%'";
        }
        strsql += "order by n_id desc";
        SqlDataSource1.SelectCommand = strsql;
       
        ListView1.DataBind();

    }

    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        var pager = (DataPager)ListView1.FindControl("DataPager1");
        pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        selectSQL();
    }

    protected void Btn_add_Click(object sender, EventArgs e)
    {
        Btn_save.CommandArgument = "add";
        MultiView1.ActiveViewIndex = 1;
        cleaninput();
    }

    public void cleaninput()
    {
        Selected_id.Value = "";

       subject.Text  = "";
        contents.Text= "";
        post_date.Text = ""; 
        status.SelectedIndex = -1 ;


    }
}