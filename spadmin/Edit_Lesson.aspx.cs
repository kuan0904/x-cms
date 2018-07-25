using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
using System.Collections.Specialized;
public partial class spadmin_Edit_Lesson : System.Web.UI.Page
{
    public string articleId = "0";
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


        string strsql = @"SELECT *  FROM tbl_article where status <> 'D' and  kind='Y' ";
        if (searchtxt.Text != "")
        {
            strsql += " and ( subject like @s or keywords like @s or contents like @s or author like @s ) ";
        }
        strsql += " order by  articleid desc";

        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("s", "%" + searchtxt.Text + "%");
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();
        dt.Dispose();
        nvc.Clear();

    }

    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        selectSQL();
    }

    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
    }
    public void cleaninput()
    {
        Selected_id.Value = "";

    }
    protected void btn_del_Click(object sender, System.EventArgs e)
    {
        Button obj = sender as Button;
        SqlConnection conn = new SqlConnection(classlib.dbConnectionString);
        SqlCommand cmd = new SqlCommand();

        conn.Open();

        cmd = new SqlCommand("update  tbl_article set status = 'D'  where  articleId = @id ", conn);
        cmd.Parameters.Add("@id", SqlDbType.Int).Value = obj.CommandArgument;
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
        cmd = new SqlCommand("update  tbl_article set status = 'D'  where  articleId = @id ", conn);
        cmd.Parameters.Add("@id", SqlDbType.Int).Value = obj.CommandArgument;
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();
        selectSQL();

    }


    protected void btn_add_Click(object sender, EventArgs e)
    {
        string id = DateTime.Now.ToString("MMddhhmmss");
        //Guid.NewGuid().ToString("N");
        Session["uploadid"] = id;
        MultiView1.ActiveViewIndex = 1;
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        LinkButton obj = (LinkButton)sender;
        articleId = obj.CommandArgument;
        Session["uploadid"] = articleId;
    }

    protected void Btn_save_Click(object sender, EventArgs e)
    {
        //MultiView1.ActiveViewIndex = 0;
        //selectSQL();
    }

    protected void Btn_find_Click(object sender, EventArgs e)
    {
        selectSQL();
    }

}