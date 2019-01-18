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

public partial class spadmin_oneshop : System.Web.UI.Page
{
    public string[] stringArray = new string[5];
    public string keywords = "";
    public string groupproductcode = "";
    protected void Page_Init(object sender, EventArgs e)
    {
        //DropDownList1.DataBound  += new EventHandler(DropDownList1_DataBound);
        DropDownList1.Items.Add(new ListItem("不區分", ""));
        string strsql = "select * from tbl_category where parentid =0 and classid=@classid  and status<>'D' ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("classid", "2");
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string name = dt.Rows[i]["title"].ToString();
            string id = dt.Rows[i]["categoryid"].ToString();
        
            DropDownList1.Items.Add(new ListItem(name, id));
        }
        dt.Dispose();
     
        nvc.Clear();
        nvc.Add("classid", "3");
        dt = DbControl.Data_Get(strsql, nvc);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string name = dt.Rows[i]["title"].ToString();
            string id = dt.Rows[i]["categoryid"].ToString();
            supplierid.Items.Add(new ListItem(name, id));

        }
        dt.Dispose();
        supplierid.Items.Insert(0, new ListItem("請選擇", ""));

        strsql = "select * from  tbl_delivery_kind where status<>'D' ";
        nvc.Add("id", "0");
        dt = DbControl.Data_Get(strsql, nvc);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string name = dt.Rows[i]["name"].ToString();
            string id = dt.Rows[i]["id"].ToString();
            shippingKind.Items.Add(new ListItem(name, id));

        }
        dt.Dispose();
        shippingKind.Items.Insert(0, new ListItem("請選擇", ""));

        strsql = "select * from tbl_productData where status <> 'D'  ";
        nvc.Clear();
        nvc.Add("classid", "2");
        dt = DbControl.Data_Get(strsql, nvc);
        Repeater1.DataSource = dt;
        Repeater1.DataBind();

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

        string strsql = "select * from tbl_package where packageid  = @packageid";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("packageid", Selected_id.Value);
        DataTable dt = DbControl.Data_Get(strsql, nvc);

        packageid.Text = dt.Rows[0]["packageid"].ToString();
        packagename.Text = dt.Rows[0]["packagename"].ToString();
      
        description.Text = dt.Rows[0]["description"].ToString();
        status.SelectedValue = dt.Rows[0]["status"].ToString();



        sort.Text = dt.Rows[0]["sort"].ToString();
     
        shippingfee.Text = dt.Rows[0]["shippingfee"].ToString();
        freeship.Text = dt.Rows[0]["freeship"].ToString();
        supplierid.SelectedIndex = supplierid.Items.IndexOf(supplierid.Items.FindByValue(dt.Rows[0]["supplierid"].ToString()));
      
        shippingKind.SelectedIndex = shippingKind.Items.IndexOf(shippingKind.Items.FindByValue(dt.Rows[0]["shippingKind"].ToString()));
        ReMark.Text = dt.Rows[0]["ReMark"].ToString();
        Refunds.Text = dt.Rows[0]["Refunds"].ToString();

        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";
        if (obj.CommandName == "copy")
        {

            Btn_save.CommandArgument = "copy";
        }

        supplierid_SelectedIndexChanged(sender, e);


        strsql = "Select * from tbl_package_product where packageid=@packageid";
        dt = DbControl.Data_Get(strsql, nvc);
        foreach (DataRow dr in dt.Rows)
        {
            foreach (RepeaterItem  r in Repeater1.Items)
            {
                CheckBox cb = (CheckBox)r.FindControl("CheckBox1");
                HiddenField v1 = (HiddenField)r.FindControl("HiddenField1");
                TextBox t1 = (TextBox)r.FindControl("price");
                TextBox t2 = (TextBox)r.FindControl("storage");
                if (v1.Value == dr["p_id"].ToString())
                {
                    cb.Checked = true;
                    t1.Text = dr["price"].ToString();
                    t2.Text = dr["storage"].ToString();
                
                }
              
            }
        }
    }
    protected void Btn_add_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "add";
        cleaninput();
    }
    protected void Btn_save_Click(object sender, System.EventArgs e)
    {

        int i = 0;
        LinkButton obj = sender as LinkButton;
        NameValueCollection nvc = new NameValueCollection();
        string strsql = "";
        if (Btn_save.CommandArgument == "copy" || Btn_save.CommandArgument == "add")
        {
            strsql = "insert into Tbl_package (viewcount) values (@viewcount ) ";
            nvc.Add("viewcount", "0");
            i = DbControl.Data_add(strsql, nvc);
            strsql = "select max(packageid ) from Tbl_package  ";
            nvc.Clear();
           
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            packageid.Text = dt.Rows[0][0].ToString();
        }

    
        if (sort.Text == "") sort.Text = "0";

        strsql = @"UPDATE  Tbl_package  SET packagename=@packagename,
                status = @status,sort=@sort,shippingfee=@shippingfee
                ,shippingKind=@shippingKind,freeship=@freeship
               ,supplierid=@supplierid ,description=@description
                ,ReMark=@ReMark,Refunds=@Refunds
                where packageid=@packageid ";
        nvc.Clear();
        nvc.Add("packageid", packageid.Text);
        nvc.Add("packagename", packagename.Text);      
        nvc.Add("description", Server.HtmlDecode(description.Text));      
        nvc.Add("status", status.SelectedValue);
        nvc.Add("sort", sort.Text);
        nvc.Add("shippingfee", shippingfee.Text);
        nvc.Add("freeship", freeship.Text);
        nvc.Add("shippingKind", shippingKind.Text);
        nvc.Add("supplierid", supplierid.SelectedValue);
        nvc.Add("ReMark", ReMark.Text);
        nvc.Add("Refunds", Refunds.Text);
        i = DbControl.Data_add (strsql, nvc);

        strsql = @"delete from tbl_package_product where packageid =@packageid";
        i = DbControl.Data_Update(strsql, nvc, packageid.Text);
        foreach (RepeaterItem r in Repeater1.Items)
        {
            CheckBox cb = (CheckBox) r.FindControl("CheckBox1");
            if (cb.Checked)
            {
                HiddenField v1 = (HiddenField)r.FindControl("HiddenField1");
                TextBox t1 = (TextBox)r.FindControl("price");
                TextBox t2 = (TextBox)r.FindControl("storage");
                strsql = @"insert into tbl_package_product (packageid,p_id,price,storage)
                values (@packageid,@p_id,@price,@storage) ";
                nvc.Clear();
                nvc.Add("packageid", packageid.Text);
                nvc.Add("p_id", v1.Value);
                nvc.Add("price", t1.Text);
                nvc.Add("storage", t2.Text);
                i = DbControl.Data_add(strsql, nvc);

            }


        }

        selectSQL();
        MultiView1.ActiveViewIndex = 0;

    }
    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {

        MultiView1.ActiveViewIndex = 0;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //        string.Contains("pattern") is equivalent to LIKE '%pattern%'
        //string.StartsWith("pattern") is equivalent to LIKE 'pattern%'
        //string.EndsWith("pattern") is equivalent to LIKE '%pattern'
    }
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {

        DropDownList obj = sender as DropDownList;
        obj.Items.Insert(0, new ListItem("不區分", ""));

    }
    public void selectSQL(string sorttype = "desc", string sortColumn = "packageid")
    {

        string strsql = @" SELECT (SELECT TOP (1) tbl_productData.logo
                            FROM  tbl_package_product INNER JOIN
                            tbl_productData ON tbl_package_product.p_id = tbl_productData.p_id
                            WHERE tbl_package_product.packageid = Tbl_package.packageid) AS logo,
                            Tbl_package.*
                            FROM   Tbl_package where status <> 'D' ";

        if (search_txt.Text != "")
        {
            int n;
            bool isNumeric = int.TryParse(search_txt.Text, out n);
            strsql += @" and (ReMark like '%'+@S+'%'    or packagename like '%'+@S+'%'   or description like '%'+@S+'%')  ";

        }
        if (DropDownList1.SelectedIndex > 0) strsql += " and  categoryid = @categoryid";

        strsql += " ORDER BY  sort," + sortColumn + " " + sorttype;

        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("S", search_txt.Text);
        nvc.Add("categoryid", DropDownList1.SelectedValue);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();
        dt.Dispose();
        MultiView1.ActiveViewIndex = 0;
    }
    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        var pager = (DataPager)ListView1.FindControl("DataPager1");
        pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        selectSQL();
    }

    protected void btn_search_click(object sender, EventArgs e)
    {
        selectSQL();
    }

    protected void sortdata(object sender, EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        string sorttype = obj.CommandArgument;
        string sortColumn = obj.CommandName;
        sorttype = (sorttype == "desc") ? "asc" : "desc";
        obj.CommandArgument = sorttype;
        selectSQL(sorttype, sortColumn);

    }
    public void cleaninput()
    {
        packageid.Text = "";

        ContentPlaceHolder mp;
        mp = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
        MultiView mu1;
        mu1 = (MultiView)mp.FindControl("MultiView1");
        View vi2 = (View)mu1.FindControl("view2");
        foreach (Control x in vi2.Controls)
        {

            if (x is TextBox)
            {

                ((TextBox)x).Text = "";
            }
            if (x is DropDownList)
            {

                ((DropDownList)x).SelectedIndex = 0;
            }
            if (x is Image)
            {

                ((Image)x).ImageUrl = "";
            }
        }
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
        cmd = new SqlCommand("update tbl_package set status = 'D' where packageid = @packageid ", conn);
        cmd.Parameters.Add("@packageid", SqlDbType.Int).Value = obj.CommandArgument;
        cmd.ExecuteNonQuery();
        cmd.Dispose();
        conn.Close();

        selectSQL();


    }




    protected void img_del(object sender, EventArgs e)
    {
        LinkButton obj = (LinkButton)sender;

        obj.CommandArgument = Selected_id.Value;
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            string strsql = @"update tbl_productdata set " + obj.CommandName + " = '' where p_id =" + obj.CommandArgument;

            conn.Open();
            SqlDataAdapter myAdapter = new SqlDataAdapter();
            SqlCommand cmd = new SqlCommand(strsql, conn);
            // cmd.Parameters.Add("@p_id", SqlDbType.Int).Value = obj.CommandArgument;
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
            link_edit(obj, e);
        }
    }

    protected void supplierid_SelectedIndexChanged(object sender, EventArgs e)
    {
    
        string strsql = @" SELECT  *  from  tbl_productdata    where status <> 'D'  
         and  supplierid = @supplierid and p_id <> @pid";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("pid", Selected_id.Value);
        nvc.Add("supplierid", supplierid.SelectedValue);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string name = dt.Rows[i]["productname"].ToString() + "/NT:" + dt.Rows[i]["price"].ToString();
            string id = dt.Rows[i]["p_id"].ToString();
         


        }
        string[] s = groupproductcode.Split(',');





        dt.Dispose();
    }
}