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
   

    protected void Page_Init(object sender, EventArgs e)
    {
        string unitid = Request.QueryString["unitid"];
        string classid = "";
        string strsql = "SELECT *  FROM tbl_category_class where classid > @classid  ";
      
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("classid", classid);
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);

        for (int i = 0; i< dt.Rows.Count; i++){
            DropDownList1.Items.Add(new ListItem(dt.Rows [i]["title"].ToString (), dt.Rows[i]["classId"].ToString()));
        }
        dt.Dispose();

      //  strsql = " SELECT  * FROM tbl_category WHERE classId = 'B' AND parentid = 0 ";


        DropDownList2.DataBound += new EventHandler(DropDownList2_DataBound);
   
       //    DropDownList2.SelectedIndexChanged += new EventHandler(SelectedIndexChanged);
       
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


        ListView1.DataBind();


        //strsql = "select * ,  (SELECT  title   FROM tbl_category  WHERE (b.parentid = categoryid)) AS upname  from tbl_category as b  where  classid <> '' " ;
        //if (DropDownList1.SelectedValue !="") 
        //{
        //    strsql += " and classid  = '" + DropDownList1.SelectedValue + "' ";
        //}
        //strsql += " order by priority ";
        //把PagedDataSource 對象賦給Repeater控制項 



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

        strsql = "select * from    tbl_category where categoryid  = @classid ";
        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("classid", SqlDbType.NVarChar).Value = Selected_id.Value;
        rs = cmd.ExecuteReader();

        if (rs.Read())
        {
         
        
           class_name.Text  = rs["title"].ToString();
            parentid.Value  = rs["parentid"].ToString();    
            priority.Text = rs["priority"].ToString();
          
        }
        rs.Close();
        cmd.Dispose();
        conn.Close();
        DropDownList2.SelectedIndex = DropDownList2.Items.IndexOf(DropDownList2.Items.FindByValue(parentid.Value ));
       
    }



    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
        string strsql = "";

        //-----------------------------------------------------------------------

        if (Btn_save.CommandArgument == "add")
        {
            strsql = " insert into  tbl_category( parentid, classId, priority, status, status_mobile, title, createdate, createuserid, filename, top1, top2, top3, url, url_mobile, push, hot) values ";
            strsql += "(@parentid, @classId, @priority, @status, @status_mobile, @title, getdate(), '"+ Session["userid"].ToString() + "', @filename, @top1, @top2, @top3, @url, @url_mobile, @push, @hot ) ";
        }
        else {
            strsql = "update  tbl_category set parentid=@parentid,classId=@classId,priority=@priority,status=@status,status_mobile=@status_mobile, title=@title";
            strsql += ",filename=@filename,top1=@top1,top2=@top2,top3=@top3,url=@url,url_mobile=@url_mobile,push=@push,hot=@hot  ";
            strsql += " where categoryid =@categoryid";
        }


        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();
    
        conn.Open();



        cmd = new SqlCommand(strsql, conn);
        cmd.Parameters.Add("parentid", SqlDbType.NVarChar).Value = DropDownList2.SelectedValue;
        cmd.Parameters.Add("classId", SqlDbType.NVarChar).Value = DropDownList1.SelectedValue;
        cmd.Parameters.Add("priority", SqlDbType.NVarChar).Value = priority.Text;
        cmd.Parameters.Add("status", SqlDbType.NVarChar).Value = status.SelectedValue;
        cmd.Parameters.Add("status_mobile", SqlDbType.NVarChar).Value = status.SelectedValue; ;
        cmd.Parameters.Add("title", SqlDbType.NVarChar).Value =class_name.Text;       
        cmd.Parameters.Add("filename", SqlDbType.NVarChar).Value ="";

        cmd.Parameters.Add("push", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("hot", SqlDbType.VarChar).Value = "";

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

        priority.Text = "1";
        class_name.Text = "";

      //  Page.ClientScript.RegisterStartupScript(this.GetType(), "", "addlist();", true);


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
        ;
    }
   
    protected void DropDownList2_DataBound(object sender, EventArgs e)
    {
        DropDownList2.Items.Insert(0, new ListItem("設為上層", "0"));
        DropDownList2.SelectedIndex = DropDownList2.Items.IndexOf(DropDownList2.Items.FindByValue(parentid.Value  ));

    }
    public string statusTotxt(string str)
    {
        if (str == "1")
        {
            return "開啟";
        }
        if (str == "0")
        {
            return "關閉";
        }
        return "";

    }
    
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList2.DataBind();
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