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


public partial class spadmin_memberList : System.Web.UI.Page
{
    public string memberid = "";
    public  string sorttype ="";
    public  string sortColumn ="";
    public static  ArrayList zipcode = new ArrayList();
    protected void Page_Init(object sender, EventArgs e)
    {

       

        DataTable dt = classlib.Get_county();
        for (int i=0; i < dt.Rows.Count; i++)
        {
            countyid.Items.Add(new ListItem(dt.Rows[i]["countyname"].ToString(), dt.Rows[i]["countyid"].ToString()));
        }
        countyid.Items.Insert(0, new ListItem("請選擇", ""));
       
    }
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

            string strsql = "select * from MemberData where memberid = @memberid";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("memberid", SqlDbType.Int).Value = Selected_id.Value;
            memberid = Selected_id.Value;
            rs = cmd.ExecuteReader();

            if (rs.Read()) {
                Email.Text = rs["email"].ToString();
                passwd.Text = rs["password"].ToString();
                username.Text = rs["username"].ToString();
                phone.Text = rs["phone"].ToString();
                zip.Text = rs["zip"].ToString(); ;
                lastlogin.Text = rs["lastlogin"].ToString();                              
                registdate.Text = rs["crtdat"].ToString();
                Hiddencity.Value =rs["cityid"].ToString ();
                Hiddencounty.Value =rs["countyid"].ToString ();
                address.Text =rs["address"].ToString ();
                zip.Text = rs["zip"].ToString();
                birthday .Text = rs["birthday"].ToString()=="" ? "": DateTime.Parse(rs["birthday"].ToString()).ToString("yyyy/MM/dd") ;
                if (rs["gender"].ToString () != "") gender.SelectedIndex = gender.Items.IndexOf(gender.Items.FindByValue(rs["gender"].ToString()));
            }
            rs.Close();
            cmd.Dispose();

            strsql = @" SELECT *    FROM   OrderData  where OrderData.memberid=@memberid order by ord_id desc ";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@memberid", SqlDbType.Int).Value = Selected_id.Value;
            rs = cmd.ExecuteReader();
            Repeater1.DataSource = rs;
            Repeater1.DataBind();
            conn.Close();
        }


     
        
        


   
        countyid.SelectedIndex = countyid.Items.IndexOf(countyid.Items.FindByValue(Hiddencounty.Value));
       
        get_city();
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";
      
    }
    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            SqlCommand cmd = new SqlCommand();
            conn.Open();
           string strsql = @"update  MemberData set username=@username,gender=@gender,
                phone=@phone,zip=@zip,cityid=@cityid,countyid=@countyid,address=@address
,birthday=@birthday
            WHERE  memberid=@memberid";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@memberid", SqlDbType.VarChar).Value = Selected_id.Value;
            cmd.Parameters.Add("@username", SqlDbType.NVarChar).Value = username.Text ;
            cmd.Parameters.Add("@gender", SqlDbType.NVarChar).Value = gender.SelectedValue ;
            cmd.Parameters.Add("@phone", SqlDbType.VarChar).Value = phone.Text ;
            cmd.Parameters.Add("@zip", SqlDbType.VarChar).Value = zip.Text ;
            cmd.Parameters.Add("@cityid", SqlDbType.VarChar).Value = cityid.SelectedValue ;
            cmd.Parameters.Add("@countyid", SqlDbType.VarChar).Value = countyid.SelectedValue ;
            cmd.Parameters.Add("@address", SqlDbType.NVarChar).Value = address.Text ;
            cmd.Parameters.Add("@birthday", SqlDbType.NVarChar).Value = birthday.Text;
            // cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = passwd.Text ;
            cmd.ExecuteNonQuery();         
            cmd.Dispose();
            conn.Close();
        }

        selectSQL();
        MultiView1.ActiveViewIndex = 0;
    }
    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {

        MultiView1.ActiveViewIndex = 0;
    }
    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        var pager = (DataPager)ListView1.FindControl("DataPager1");
        pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        selectSQL(sorttype, sortColumn);
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        selectSQL(sorttype, sortColumn);
    }
    protected void sortdata(object sender, EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        sorttype = obj.CommandArgument;
        sortColumn = obj.CommandName;
        sorttype = (sorttype == "desc") ? "asc" : "desc";
        obj.CommandArgument = sorttype;
        selectSQL(sorttype, sortColumn);

    }
    public void selectSQL(string sorttype = "desc", string sortColumn = "memberid")
    {
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", "0");
        string strsql = "select  * from  memberdata where   memberid >@id ";
        if (keyword.Text != "")
        {
            strsql += " and (  username like '%' + @keyword + '%'  or email like '%' + @keyword + '%' or phone like '%' + @keyword + '%' )";
            nvc.Add("keyword", keyword.Text);
        }
        if (sortColumn !="")
            strsql += " ORDER BY  " + sortColumn + " " + sorttype;
        else
            strsql += " ORDER BY  memberid desc ";

        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();





    }
    protected void countyid_DataBound(object sender, EventArgs e)
    {
        // zip.Text = "";

        //countyid.Items.Insert(0, new ListItem("請選擇", ""));
        //countyid.SelectedIndex = countyid.Items.IndexOf(countyid.Items.FindByValue(Hiddencounty.Value));
        //get_city();
    }
    protected void countyid_SelectedIndexChanged(object sender, EventArgs e)
    {
        get_city();
    }
    public void get_city()
    {

      
        MultiView1.ActiveViewIndex = 1;      
        cityid.Items.Clear();
        cityid.Items.Add(new ListItem("請選擇", "0"));

        zipcode.Clear();
        zipcode.Add("");
        if (countyid.SelectedIndex > 0) {
            DataTable dt = classlib.Get_city(countyid.SelectedValue);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                cityid.Items.Add(new ListItem(dt.Rows[i]["cityname"].ToString(), dt.Rows[i]["cityid"].ToString()));
            }        
            cityid.SelectedIndex = cityid.Items.IndexOf(cityid.Items.FindByValue(Hiddencity.Value));
        }

       
    }

    protected void cityid_SelectedIndexChanged(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex  = 1;
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            SqlCommand cmd = new SqlCommand();
            conn.Open();
            string strsql = @"select * from city       WHERE  cityid=@cityid";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@cityid", SqlDbType.VarChar).Value = cityid.SelectedValue ;
            SqlDataReader rs; 
            rs = cmd.ExecuteReader ();
            if (rs.Read()) zip.Text = rs["zip"].ToString();
            rs.Dispose();
            cmd.Dispose();
            conn.Close();
        }
        //  zip.Text = zipcode[cityid.SelectedIndex].ToString ();
    }

   
}
