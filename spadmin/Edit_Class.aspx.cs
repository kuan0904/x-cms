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


public partial class admin_EditClass : System.Web.UI.Page
{
    static string  strsql  = "";
    public string classid= "";

    protected void Page_Init(object sender, EventArgs e)
    {
        string unitid = Request.QueryString["unitid"];


        string strsql = "SELECT *  FROM    tbl_category_class where unitid =@unitid  ";      
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("unitid", unitid);
        
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        classid = dt.Rows[0]["classid"].ToString();
       
        strsql = "SELECT *  FROM tbl_category where parentid =0 and classid=@classid ";
        nvc.Clear();
        nvc.Add("classid", classid);
        dt = DbControl.Data_Get(strsql, nvc);
        DropDownList2.Items.Add(new ListItem("設為上層", "0"));
        DropDownList1.Items.Add(new ListItem("第一層", "0"));
        for (int i = 0; i< dt.Rows.Count; i++){
            DropDownList1.Items.Add(new ListItem(dt.Rows [i]["title"].ToString (), dt.Rows[i]["categoryid"].ToString()));
            DropDownList2.Items.Add(new ListItem(dt.Rows[i]["title"].ToString(), dt.Rows[i]["categoryid"].ToString()));

        }
        dt.Dispose();
        
   
      
    }
    protected void Page_Load(object sender, EventArgs e)
    {
     

        if (!IsPostBack)
        {
            if (Request.QueryString["q1"] != null)
            {             
                DropDownList1.SelectedValue  = (Request.QueryString["q1"]);
             }
         
            MultiView1.ActiveViewIndex = 0;
           selectSQL();

        }

    }
    public void selectSQL()
    {

        string strsql = @"SELECT * ,
(select title from tbl_category a where a.categoryid = b.parentid ) as upname
            FROM tbl_category b where b.parentid =@parentid  and classid=@classid ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("parentid", DropDownList1.SelectedValue);
        nvc.Add("classid",classid);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();
        dt.Dispose();


    }

    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        var pager = (DataPager)ListView1.FindControl("DataPager1");
        pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
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

        strsql = "select * from    tbl_category where categoryid  = @classid ";
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("classid", SqlDbType.NVarChar).Value = Selected_id.Value;
        rs = cmd.ExecuteReader();

        if (rs.Read())
        {


            class_name.Text = rs["Title"].ToString();
            parentid.Value  = rs["parentid"].ToString();    
            sort.Text = rs["sort"].ToString();
            pagename.Text = rs["pagename"].ToString();
            kind.SelectedValue = rs["kind"].ToString();
        }
        rs.Close();
        cmd.Dispose();
        conn.Close();
        DropDownList2.SelectedIndex = DropDownList2.Items.IndexOf(DropDownList2.Items.FindByValue(parentid.Value ));
       
    }



    protected void Btn_save_Click(object sender, System.EventArgs e)
    {

       
        
       
     
        //-----------------------------------------------------------------------

        if (Btn_save.CommandArgument == "add")
        {
            strsql = " insert into  tbl_category( parentid, classId, sort, status,  title, createdate, createuserid,kind,pagename) values ";
            strsql += "(@parentid, @classId, @sort, @status,  @title, getdate(), '"+ Session["userid"].ToString() + "',@kind,@pagename) ";
        }
        else {
            strsql = "update  tbl_category set parentid=@parentid,sort=@sort,status=@status, title=@title";
            strsql += ",kind=@kind,pagename=@pagename where categoryid =@categoryid";
        }
        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();    
        conn.Open();
        cmd = new SqlCommand(strsql, conn);



        cmd.Parameters.Add("parentid", SqlDbType.NVarChar).Value = DropDownList2.SelectedValue;
        cmd.Parameters.Add("classId", SqlDbType.NVarChar).Value = classid;
        cmd.Parameters.Add("sort", SqlDbType.NVarChar).Value = sort.Text;
        cmd.Parameters.Add("status", SqlDbType.NVarChar).Value = status.SelectedValue;
        cmd.Parameters.Add("title", SqlDbType.NVarChar).Value =class_name.Text;
        cmd.Parameters.Add("kind", SqlDbType.NVarChar).Value = kind .SelectedValue;
        cmd.Parameters.Add("pagename", SqlDbType.NVarChar).Value = pagename.Text;
        if (Btn_save.CommandArgument == "add")
        {
       
        }
        else {
            cmd.Parameters.Add("categoryid", SqlDbType.VarChar).Value = Selected_id.Value ;
        }


        cmd.ExecuteNonQuery();
        cmd.Dispose();     
        conn.Close();  
        MultiView1.ActiveViewIndex = 0;      
        cleaninput();
        selectSQL();
        Session["webmenu"] = Unitlib.Get_menu();
    }




    protected void Btn_add_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "add";
        cleaninput();
        DropDownList2.SelectedValue = DropDownList1.SelectedValue;
        strsql = "select max(sort)+1 from tbl_category where parentid = @parentid";
        using (SqlConnection conn = new SqlConnection(unity.classlib.dbConnectionString))
        {
            SqlDataReader rs = default(SqlDataReader);
            SqlCommand cmd = new SqlCommand();
            conn.Open();
          
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("parentid", SqlDbType.VarChar).Value = DropDownList1.SelectedValue ;
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
          
                    sort.Text= rs[0].ToString ();
            }
         
            rs.Close();
            cmd.Dispose();
            conn.Close();
        }
        if (sort.Text == "") sort.Text = "1";
     }

    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
    }


    public void cleaninput()
    {
        Selected_id.Value = "";
        sort.Text = "1";
        class_name.Text = "";
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
        cmd = new SqlCommand("update  tbl_category set status = 0 where categoryid = '" + obj.CommandArgument  + "' ", conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();
        selectSQL();
       
    }
   
  
   
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        selectSQL();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Button  obj = sender as Button;  
        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();

        conn.Open();
        cmd = new SqlCommand("delete from   tbl_category where  status = 0 and  categoryid = '" + obj.CommandArgument + "' ", conn);
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();


        selectSQL();
    }
}