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


public partial class spadmin_edit_tabstate : System.Web.UI.Page
{
    static string strsql = "";
    string table_name = "";
    public string unitname = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string unitid = Request.QueryString["unitid"];


        string strsql = "SELECT *  FROM  unitdata where unitid =@unitid  ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("unitid", unitid);

        DataTable dt = DbControl.Data_Get(strsql, nvc);
        table_name = dt.Rows[0]["subject"].ToString();
        unitname = dt.Rows[0]["unitname"].ToString();
        dt.Dispose();
        if (!IsPostBack)
        {
           
            MultiView1.ActiveViewIndex = 0;
            selectSQL();

        }

    }
    public void selectSQL()
    {

        string strsql = @"SELECT * 
            FROM  "+ table_name +" where status <>'D' ";
        NameValueCollection nvc = new NameValueCollection();      
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();
        dt.Dispose();


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
      
        strsql = "select * from    "+ table_name +"  where id  = @classid ";
        NameValueCollection nvc = new NameValueCollection();
    
        nvc.Add("classid", Selected_id.Value );
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0)
        {


            class_name.Text = dt.Rows [0]["name"].ToString();
            status.SelectedValue = dt.Rows[0]["status"].ToString();
        }
        dt.Dispose();

    }



    protected void Btn_save_Click(object sender, System.EventArgs e)
    {





        //-----------------------------------------------------------------------

        if (Btn_save.CommandArgument == "add")
        {
            strsql = " insert into  "+ table_name +"( name,status) values ";
            strsql += "(@name, @status) ";
        }
        else
        {
            strsql = "update   "+ table_name +" set name=@name,status=@status where id=@id";
        }
        NameValueCollection nvc = new NameValueCollection();
      
        nvc.Add("id", Selected_id.Value);
        nvc.Add("name", class_name.Text);
        nvc.Add("status", status.SelectedValue);
        DbControl.Data_add(strsql, nvc);
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
       
        class_name.Text = "";
    }

    protected void btn_del_Click(object sender, System.EventArgs e)
    {

        strsql = "update  "+ table_name +" set status = 'D' where id =@id";
        NameValueCollection nvc = new NameValueCollection();
    
        nvc.Add("id", Selected_id.Value);      
        DbControl.Data_add(strsql, nvc);
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
        selectSQL();
    }



    //刪除
    protected void link_delete(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        strsql = "update  "+ table_name +" set status = 'D' where id =@id";
        NameValueCollection nvc = new NameValueCollection();
      
        nvc.Add("id", obj.CommandArgument);        
        DbControl.Data_add(strsql, nvc);
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
        selectSQL();
     

    }



   

    protected void Button1_Click(object sender, EventArgs e)
    {
        Button obj = sender as Button;
        strsql = "update  "+ table_name +" set status = 'D' where id =@id";
        NameValueCollection nvc = new NameValueCollection();
       
        nvc.Add("id", obj.CommandArgument);
        DbControl.Data_add(strsql, nvc);
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
        selectSQL();
    }
}