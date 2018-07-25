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

public partial class spadmin_product : System.Web.UI.Page
{

    public string[] stringArray = new string[5];
    
    protected void Page_Init(object sender, EventArgs e)
    {
        DropDownList1.DataBound  += new EventHandler(DropDownList1_DataBound);
        string strsql = "select * from tbl_category where status <> 'D' and categoryid>@id ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", "0");
        DataTable dt =DbControl .Data_Get(strsql, nvc);                 
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string name = dt.Rows[i]["title"].ToString();
            string id = dt.Rows[i]["categoryid"].ToString();
            categoryid.Items.Add(new ListItem(name, id));
                
        }
        dt.Dispose();

        strsql = "select * from productData where status <> 'D'  ";  
        dt = DbControl.Data_Get(strsql, nvc);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string name = dt.Rows[i]["productname"].ToString();
            string id = dt.Rows[i]["p_id"].ToString();
            CheckBoxList1.Items.Add (new ListItem(name, id));

        }
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
    protected void link_edit(object sender, System.EventArgs e)
    {
        Image2.Visible = true;
        Image3.Visible = true ;
        LinkButton obj = sender as LinkButton;
        Selected_id.Value   = obj.CommandArgument;
      
        string strsql = "select * from productdata where p_id  = @p_id";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("p_id", Selected_id.Value  );
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        price .Text = dt.Rows[0]["price"].ToString();
        p_id.Text = dt.Rows[0]["p_id"].ToString();
        productname.Text = dt.Rows[0]["productname"].ToString();
        storage.Text = dt.Rows[0]["storage"].ToString();
        description.Text = dt.Rows[0]["description"].ToString();
        status.SelectedValue = dt.Rows[0]["status"].ToString();
        categoryid.SelectedValue = dt.Rows[0]["categoryid"].ToString();
        stringArray[1] = dt.Rows[0]["pic1"].ToString();
        stringArray[2] = dt.Rows[0]["pic2"].ToString();
        stringArray[3] = dt.Rows[0]["pic3"].ToString();
        stringArray[0] = dt.Rows[0]["logo"].ToString();
        stringArray[4] = dt.Rows[0]["banner"].ToString();
        sort.Text = dt.Rows[0]["sort"].ToString();
        memo.Text = dt.Rows[0]["memo"].ToString();
        videourl.Text   = dt.Rows[0]["videourl"].ToString();
        productcode.Text  = dt.Rows[0]["productcode"].ToString();
        shippingfee.Text = dt.Rows[0]["shippingfee"].ToString();
        freeship.Text = dt.Rows[0]["freeship"].ToString();
        shippingKind.Text = dt.Rows[0]["shippingKind"].ToString();
        Image1.ImageUrl = "../upload/" + stringArray[1] + "?" + DateTime.Now.ToString("yyyyMMddhhmmss");
        if (stringArray[2] != "") 
            Image2.ImageUrl = "../upload/" + stringArray[2] + "?" + DateTime.Now.ToString("yyyyMMddhhmmss"); 
        else
            Image2.Visible = false;
        if (stringArray[3] != "")
            Image3.ImageUrl = "../upload/" + stringArray[3] + "?" + DateTime.Now.ToString("yyyyMMddhhmmss"); 
        else
            Image3.Visible = false;
     
        viewcount.Text = dt.Rows[0]["viewcount"].ToString();
        if (dt.Rows[0]["kindid"].ToString() == "2") { kindid.SelectedValue = "2"; }
        else { kindid.SelectedValue = "1"; }
        string[] strary = dt.Rows[0]["id_list"].ToString().Split(';');
            int i = 0;    
            int j = 0;
            for (j = 0;j < CheckBoxList1.Items.Count; j++)
            {
            CheckBoxList1.Items[j].Selected = false;
                for (i=0;i<strary.Length - 1; i++)
                  {
                        if (CheckBoxList1.Items[j].Value == strary[i]) CheckBoxList1.Items[j].Selected = true;

                }

            }

        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";
        if (obj.CommandName == "copy")
        {
      
            Btn_save.CommandArgument = "copy";
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
                strsql = "insert into productdata (viewcount) values (@viewcount ) ";
                nvc.Add("viewcount", "0");
                i = DbControl.Data_add(strsql, nvc);
                strsql = "select max(p_id ) from productdata  where p_id >@p_id ";
                nvc.Clear();
                nvc.Add("p_id", "0");
                DataTable dt = DbControl.Data_Get(strsql, nvc);
                p_id.Text = dt.Rows[0][0].ToString();
            }

            string img_path = "../upload/";
            if (Image1.ImageUrl != "") stringArray[1] = p_id.Text + "-1.jpg";
            if (Image2.ImageUrl != "" &&  Image2.Visible == true ) stringArray[2] = p_id.Text + "-2.jpg";
            if (Image3.ImageUrl != "" && Image3.Visible == true) stringArray[3] = p_id.Text + "-3.jpg";

            if (FileUpload1.FileName != "")
            {
                FileUpload1.SaveAs(Server.MapPath(img_path + p_id.Text + "-1.jpg"));
                stringArray[1] = p_id.Text + "-1.jpg";
            }
            if (FileUpload2.FileName != "" )
            {
                FileUpload2.SaveAs(Server.MapPath(img_path + p_id.Text + "-2.jpg"));
                stringArray[2] = p_id.Text + "-2.jpg";
            }
            if (FileUpload3.FileName != "")
            {
                FileUpload3.SaveAs(Server.MapPath(img_path + p_id.Text + "-3.jpg"));
                stringArray[3] = p_id.Text + "-3.jpg";
            }
            if (sort.Text == "") sort.Text = "0";

            strsql = @"UPDATE  productdata  SET productname=@productname,price=@price,productcode=@productcode,videourl=@videourl
                ,description = @description, storage = @storage, pic1 = @pic1, pic2 = @pic2,pic3 = @pic3,memo=@memo,
                categoryid = @categoryid,  status = @status,sort=@sort,shippingfee=@shippingfee,shippingKind=@shippingKind,freeship=@freeship
               ,kindid=@kindid, id_list=@id_list where p_id=@id ";
            nvc.Clear();
            nvc.Add("productname", productname.Text);
            nvc.Add("price", price.Text);
            nvc.Add("productcode", productcode.Text);
            nvc.Add("videourl", videourl.Text);
            nvc.Add("storage", storage.Text);
            nvc.Add("description", description.Text);
            nvc.Add("status", status.SelectedValue);
            nvc.Add("categoryid", categoryid.SelectedValue);
            nvc.Add("pic1", stringArray[1] == null ? "" : stringArray[1]);
            nvc.Add("pic2", stringArray[2] == null ? "" : stringArray[2]);
            nvc.Add("pic3", stringArray[3] == null ? "" : stringArray[3]);
            nvc.Add("memo", memo.Text);
            nvc.Add("sort", sort.Text);
            nvc.Add("shippingfee", shippingfee.Text);
            nvc.Add("freeship", freeship.Text);
            nvc.Add("shippingKind", shippingKind.Text);
            nvc.Add("kindid", kindid.SelectedValue);
            string id_list = "";
            for (i = 0; i < CheckBoxList1.Items.Count; i++)
            {
                if (CheckBoxList1.Items[i].Selected == true)
                    id_list += CheckBoxList1.Items[i].Value + ";";
            }
            nvc.Add("id_list", id_list);
            i = DbControl.Data_Update (strsql, nvc, p_id.Text);    
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
    public void selectSQL(string sorttype = "desc", string sortColumn = "p_id")
    {
        viewDataSource.SelectParameters.Clear();
        string strsql = " SELECT  * ,(select title from  tbl_category  where tbl_category.categoryid =  productdata.categoryid) as title   from  productdata    where status <> 'D' ";
    
        if (search_txt.Text != "")
        {
            int n;
            bool isNumeric = int.TryParse(search_txt.Text, out n);     
      
                strsql += @" and (memo like '%'+@S+'%'    or productname like '%'+@S+'%'   or description like '%'+@S+'%')  ";
            viewDataSource.SelectParameters.Add("S", search_txt.Text);
        }
        if (DropDownList1.SelectedIndex >0)
        {
            strsql += " and  categoryid = @categoryid";
            viewDataSource.SelectParameters.Add("categoryid",  DropDownList1.SelectedValue );

        }
    
        strsql += " ORDER BY  sort," + sortColumn + " " + sorttype;
        viewDataSource.SelectCommand = strsql;
        ListView1.DataSourceID  = viewDataSource.ID;
        ListView1.DataBind();

        MultiView1.ActiveViewIndex = 0;
    }
    protected void ContactsListView_PagePropertiesChanging(object sender,  PagePropertiesChangingEventArgs e)
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
        p_id.Text = "";
    
        ContentPlaceHolder mp;       
        mp =          (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
        MultiView mu1;
        mu1 = (MultiView) mp.FindControl ("MultiView1");
        View vi2 =(View ) mu1.FindControl("view2");
        foreach (Control x in vi2.Controls)
        {
           
            if (x is TextBox)
            {
            
                ((TextBox)x).Text ="";
            }
            if (x is DropDownList )
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
        cmd = new SqlCommand("update productdata set status = 'D' where p_id = @p_id ", conn);
        cmd.Parameters.Add("@p_id", SqlDbType.Int).Value = obj.CommandArgument ;
        cmd.ExecuteNonQuery();
        cmd.Dispose();        
        conn.Close();

        selectSQL();
   

    }




    protected void img_del(object sender, EventArgs e)
    {
        LinkButton  obj = (LinkButton)sender;
      
        obj.CommandArgument = Selected_id.Value ;
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            string strsql = @"update productdata set " + obj.CommandName + " = '' where p_id =" + obj.CommandArgument;
          
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
}