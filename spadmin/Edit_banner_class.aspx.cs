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
    public string unitid = "";

    protected void Page_Init(object sender, EventArgs e)
    {
        string strsql = @"SELECT  upperid FROM      UnitData WHERE (unitid = @id) ";
        NameValueCollection nvc = new NameValueCollection
        {
            { "id", Request.QueryString["unitid"] }
        };
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        unitid = dt.Rows[0][0].ToString();
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

    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        var pager = (DataPager)ListView1.FindControl("DataPager1");
        pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        selectSQL();
    }
    public void selectSQL()
    {

        strsql = @"SELECT * FROM tbl_banner_class
                    WHERE unitid =  @unitid  ORDER BY   sort ";
        NameValueCollection nvc = new NameValueCollection
        {
            { "unitid", unitid }
        };
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


            class_title.Text = rs["title"].ToString();
            class_sort.Text = rs["sort"].ToString();

            rs.Close();
            cmd.Dispose();
            conn.Close();
        }
       


    }



    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
        string strsql = "";

        //-----------------------------------------------------------------------

        if (Btn_save.CommandArgument == "add")
        {
            strsql = " insert into  tbl_banner_class( title,unitid, createdate, createuserid, sort) values ";
            strsql += "(@title, @unitid,  getdate(), '" + Session["userid"].ToString() + "', @sort ) ";
        }
        else {
            strsql = "update  tbl_banner_class set title=@title";
            strsql += ",sort=@sort ";
            strsql += " where classId =@classId";
        }






        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();
        conn.Open();
        cmd = new SqlCommand(strsql, conn);


       
        cmd.Parameters.Add("title", SqlDbType.NVarChar).Value = class_title.Text;    
        cmd.Parameters.Add("sort", SqlDbType.NVarChar).Value = class_sort.Text;
        if (Btn_save.CommandArgument == "add")
        {
        cmd.Parameters.Add("unitid", SqlDbType.NVarChar).Value =unitid;
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
        class_title.Text  = "";              
       

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