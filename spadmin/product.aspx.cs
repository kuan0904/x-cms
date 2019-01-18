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
    public string keywords = "";
    public productController.ProductData ProductData;
    protected void Page_Init(object sender, EventArgs e)
    {
        //DropDownList1.DataBound  += new EventHandler(DropDownList1_DataBound);
        DropDownList1.Items.Add(new ListItem("不區分", ""));
        string strsql = "select * from tbl_category where parentid =0 and classid=@classid  and status<>'D' ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("classid", "2");
        DataTable dt =DbControl .Data_Get(strsql, nvc);                 
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string name = dt.Rows[i]["title"].ToString();
            string id = dt.Rows[i]["categoryid"].ToString();
            categoryid.Items.Add(new ListItem(name, id));
            DropDownList1 .Items.Add(new ListItem(name, id));
        }
        dt.Dispose();
        categoryid.Items.Insert(0, new ListItem("請選擇", ""));

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
        Selected_id.Value   = obj.CommandArgument;
        ProductData = productController.GetProduct(Selected_id.Value);
        price.Text = ProductData.Price.ToString();
        p_id.Text = ProductData.P_id .ToString();
        productname.Text = ProductData.Productname;
        storage.Text = ProductData.Storage.ToString ();
        description.Text = ProductData.Description ;
        status.SelectedValue = ProductData.Status;
        categoryid.SelectedIndex = categoryid.Items.IndexOf (categoryid.Items.FindByValue (ProductData.Categoryid .ToString ()));
        stringArray[1] = ProductData.Pic1;
        stringArray[2] = ProductData.Pic2;
        stringArray[3] = ProductData.Pic3;
        stringArray[0] = ProductData.Logo ;
        keywords = ProductData.Keyword;
        sort.Text = ProductData.Sort ;
        memo.Text = ProductData.Memo ;
        videourl.Text = ProductData.Videourl;
        productcode.Text = ProductData.Productcode;
        supplierid.SelectedIndex = supplierid.Items.IndexOf(supplierid.Items.FindByValue(ProductData.Supplierid.ToString ()));

        Image1.ImageUrl = "/upload/" + stringArray[1] + "?" + DateTime.Now.ToString("yyyyMMddhhmmss");
        Image2.ImageUrl = "/upload/" + stringArray[2] + "?" + DateTime.Now.ToString("yyyyMMddhhmmss");
        Image3.ImageUrl = "/upload/" + stringArray[3] + "?" + DateTime.Now.ToString("yyyyMMddhhmmss");
        Imagelogo.ImageUrl = "/upload/" + stringArray[0] + "?" + DateTime.Now.ToString("yyyyMMddhhmmss");
        spec.Text = ProductData.Spec;
        viewcount.Text = ProductData.Viewcount.ToString ();
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
                strsql = "insert into tbl_productdata (viewcount) values (@viewcount ) ";
                nvc.Add("viewcount", "0");
                i = DbControl.Data_add(strsql, nvc);
                strsql = "select max(p_id ) from tbl_productdata  where p_id >@p_id ";
                nvc.Clear();
                nvc.Add("p_id", "0");
                DataTable dt = DbControl.Data_Get(strsql, nvc);
                p_id.Text = dt.Rows[0][0].ToString();
            }
            else
            {
                ProductData = productController.GetProduct(Selected_id.Value);
                stringArray[1] = ProductData.Pic1;
                stringArray[2] = ProductData.Pic2;
                stringArray[3] = ProductData.Pic3;
                stringArray[0] = ProductData.Logo;

            }

        string img_path = "../upload/";       
        string picname = DateTime.Now.ToString("yyyyMMddhhmmssfff");
        if (FileUpload1.FileName != "")
            {
                FileUpload1.SaveAs(Server.MapPath(img_path + picname + "-1.jpg"));
                stringArray[1] = picname + "-1.jpg";
            }
        if (FileUpload2.FileName != "")
        {
            FileUpload2.SaveAs(Server.MapPath(img_path + picname + "-2.jpg"));
            stringArray[2] = picname + "-2.jpg";
        }
        if (FileUpload3.FileName != "")
        {
            FileUpload3.SaveAs(Server.MapPath(img_path + picname + "-3.jpg"));
            stringArray[3] = picname + "-3.jpg";
        }
        if (FileUploadlogo.FileName != "")
        {
            FileUploadlogo.SaveAs(Server.MapPath(img_path + picname + "-logo.jpg"));
            stringArray[0] = picname + "-logo.jpg";
        }
        if (sort.Text == "") sort.Text = "0";

            strsql = @"UPDATE  tbl_productdata  SET productname=@productname,price=@price
                ,productcode=@productcode,videourl=@videourl
                ,description = @description, storage = @storage, pic1 = @pic1, pic2 = @pic2
                , pic3 = @pic3 ,keyword = @keyword,memo=@memo,
                categoryid = @categoryid,  status = @status,sort=@sort,logo=@logo
              ,kindid=@kindid, supplierid=@supplierid,spec=@spec where p_id=@id ";
            nvc.Clear();
            nvc.Add("productname", productname.Text);
            nvc.Add("price", price.Text);
            nvc.Add("productcode", productcode.Text);
            nvc.Add("videourl", videourl.Text);
            nvc.Add("storage", storage.Text);
            nvc.Add("description", Server.HtmlDecode ( description.Text));
            nvc.Add("status", status.SelectedValue);
            nvc.Add("categoryid", categoryid.SelectedValue);
            nvc.Add("logo", stringArray[0] == null ? "" : stringArray[0]);
            nvc.Add("pic1", stringArray[1] == null ? "" : stringArray[1]);
            nvc.Add("pic2", stringArray[2] == null ? "" : stringArray[2]);
            nvc.Add("pic3", stringArray[3] == null ? "" : stringArray[3]);
            nvc.Add("keyword", Request["keywords"]);
            nvc.Add("memo", memo.Text);
            nvc.Add("spec",  spec.Text );
            nvc.Add("sort", sort.Text);          
            nvc.Add ("supplierid", supplierid.SelectedValue);         
            nvc.Add("kindid", "1");
    
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
      
        string strsql = " SELECT  * ,(select title from  tbl_category  where tbl_category.categoryid =  tbl_productdata.categoryid) as title   from  tbl_productdata    where status <> 'D' ";
    
        if (search_txt.Text != "")
        {
            int n;
            bool isNumeric = int.TryParse(search_txt.Text, out n);          
                strsql += @" and (memo like '%'+@S+'%'    or productname like '%'+@S+'%'   or description like '%'+@S+'%')  ";
            
        }
        if (DropDownList1.SelectedIndex >0) strsql += " and  categoryid = @categoryid";
               
        strsql += " ORDER BY  sort," + sortColumn + " " + sorttype;
      
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("S", search_txt.Text);
        nvc.Add("categoryid", DropDownList1.SelectedValue);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        ListView1.DataSource   = dt;
        ListView1.DataBind();
        dt.Dispose();
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
        cmd = new SqlCommand("update tbl_productdata set status = 'D' where p_id = @p_id ", conn);
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

   
}