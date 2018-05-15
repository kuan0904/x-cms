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

public partial class spadmin_Edit_diary : System.Web.UI.Page
{
    public string fname = ""; 

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

            string strsql = "select * from diary where d_id = @d_id";           
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("d_id", SqlDbType.Int ).Value = Selected_id.Value;
           
            rs = cmd.ExecuteReader();

           if (rs.Read())
            {
                hot.SelectedValue = rs["hot"].ToString();
                fname = rs["pic"].ToString();
                subject.Text = rs["subject"].ToString ();
                contents.Text  = rs["contents"].ToString();
                post_date .Text = DateTime.Parse(rs["post_day"].ToString()).ToString("yyyy/MM/dd");
                status.SelectedValue = rs["status"].ToString();
                Image1.ImageUrl = "../upload/" + fname;
                Image1.Visible = true;
                Image1.Width = 300;
                HiddenField1.Value = fname;
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
        if (FileUpload1.FileName !="")
        {
            string  img_path = "../upload/";
            fname = DateTime.Now.ToString("yyyyMMddHHmmssff") + unity.classlib.GetFileExt(FileUpload1.FileName);
            //新檔案(重新命名)
            //filex.SaveAs(Server.MapPath(img_path + filex.FileName));
            FileUpload1.SaveAs(Server.MapPath(img_path + fname));
        }


        if (fname == "" && HiddenField1.Value != "") fname = HiddenField1.Value;

        Image1 .ImageUrl = "../upload/" + fname;
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            conn.Open();
            string strsql = "";
            SqlCommand cmd = new SqlCommand();
            if (hot.SelectedValue != "")
            {
                strsql = "update diary set hot ='' where hot=@hot";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("hot", SqlDbType.VarChar).Value = hot.SelectedValue;
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }



                if (Btn_save.CommandArgument == "add")
            {
                strsql = @"insert into diary ( subject , contents,post_day,status,pic,hot ) values
                ( @subject , @contents,@post_day,@status,@pic,@hot )";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("subject", SqlDbType.VarChar).Value = subject.Text;
                cmd.Parameters.Add("contents", SqlDbType.VarChar).Value = contents.Text ;
                cmd.Parameters.Add("post_day", SqlDbType.VarChar).Value = post_date.Text;
                cmd.Parameters.Add("hot", SqlDbType.VarChar).Value =hot.SelectedValue ;
                cmd.Parameters.Add("pic", SqlDbType.VarChar).Value =fname ;
                cmd.Parameters.Add("status", SqlDbType.VarChar).Value = status.SelectedValue;


            }
            else
            {
                strsql = @"update  diary set  subject=@subject ,contents=@contents,
                post_day=@post_day,status=@status,pic=@pic,hot=@hot where d_id = @d_id";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("subject", SqlDbType.VarChar).Value = subject.Text;
                cmd.Parameters.Add("contents", SqlDbType.VarChar).Value = contents.Text;
                cmd.Parameters.Add("post_day", SqlDbType.VarChar).Value = post_date.Text;
                cmd.Parameters.Add("status", SqlDbType.VarChar).Value = status.SelectedValue;
                cmd.Parameters.Add("d_id", SqlDbType.Int).Value = Selected_id.Value;
                cmd.Parameters.Add("hot", SqlDbType.VarChar).Value = hot.SelectedValue;
                cmd.Parameters.Add("pic", SqlDbType.VarChar).Value = fname;

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
        //    LinqDataSource1.Where = "subject.Contains(\"" + keyword.Text + "\")   ";
        selectSQL();
        // LinqDataSource1.Where = "account.Contains(""new"")"
    }
    public void selectSQL()
    {
        string strsql = "select * from diary where status ='Y'  ";
        if (keyword.Text != "")
        {
            strsql += " and (subject like '%" + keyword.Text + "%' or contents like '%" + keyword.Text + "%')" ;
        }
        strsql += "order by d_id desc";
        SqlDataSource1.SelectCommand = strsql;
       
        ListView1.DataBind();
        MultiView1.ActiveViewIndex = 0;

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
        cmd = new SqlCommand("update diary set status = 'D' where d_id = '" + obj.CommandArgument + "' ", conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();


        selectSQL();

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
        hot.SelectedValue = "";
        subject.Text  = "";
        contents.Text= "";
        post_date.Text = ""; 
        status.SelectedIndex = -1 ;
        Image1.Visible = false;

    }
}