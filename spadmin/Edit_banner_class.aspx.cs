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

public partial class spadmin_Edit_banner_class : System.Web.UI.Page

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

    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        var pager = (DataPager)ListView1.FindControl("DataPager1");
        pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        selectSQL();
    }
    public void selectSQL()
    {

        strsql = "select * from   tbl_banner_class ";
        strsql += " where   classId >@id   order by  classId ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", "0");
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();
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

        strsql = "select * from    tbl_banner_class where    classid =@classid ";
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("classid", SqlDbType.NVarChar).Value = Selected_id.Value;
        rs = cmd.ExecuteReader();

        if (rs.Read())
        {

            
            class_title .Text = rs["title"].ToString();
            class_sort.Text = rs["sort"].ToString();
            class_ads.SelectedValue  = rs["ads"].ToString();
           class_fx.SelectedValue = rs["fx"].ToString();
          class_speed.SelectedValue = rs["speed"].ToString();
           class_title .Text = rs["title"].ToString();
            class_rotator.SelectedValue  = rs["rotator"].ToString();
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
            strsql = " insert into  tbl_banner_class( title, rotator, ads, fx,speed, createdate, createuserid, sort) values ";
            strsql += "(@title, @rotator, @ads,@fx,@speed,  getdate(), '" + Session["userid"].ToString() + "', @sort ) ";
        }
        else {
            strsql = "update  tbl_banner_class set title=@title,rotator=@rotator,ads=@ads,fx=@fx,speed=@speed";
            strsql += ",sort=@sort ";
            strsql += " where classId =@classId";
        }


        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();

        conn.Open();



        cmd = new SqlCommand(strsql, conn);


        cmd.Parameters.Add("rotator", SqlDbType.NVarChar).Value = class_rotator.SelectedValue;
        cmd.Parameters.Add("title", SqlDbType.NVarChar).Value = class_title.Text;       
        cmd.Parameters.Add("ads", SqlDbType.NVarChar).Value = class_ads.Text;
        cmd.Parameters.Add("fx", SqlDbType.NVarChar).Value = class_fx.Text;
        cmd.Parameters.Add("speed", SqlDbType.NVarChar).Value = class_speed.Text;
        cmd.Parameters.Add("sort", SqlDbType.NVarChar).Value = class_sort.Text;
        if (Btn_save.CommandArgument == "add")
        {

        }
        else {
             cmd.Parameters.Add("classId", SqlDbType.Int ).Value =Selected_id.Value ;
        }


        cmd.ExecuteNonQuery();
        cmd.Dispose();



        conn.Close();
        selectSQL();


        MultiView1.ActiveViewIndex = 0;

        cleaninput();
     
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

        class_fx.SelectedIndex =-1;
        class_ads.SelectedIndex = -1;
        class_speed.SelectedIndex = -1;
        class_title.Text  = "";
        class_rotator.SelectedIndex = -1;
       

       
       

    }

    protected void btn_del_Click(object sender, System.EventArgs e)
    {

        selectSQL();
    }



    //刪除
    protected void link_delete(object sender, System.EventArgs e)
    {
     

        selectSQL();


    }

    
   
  



}