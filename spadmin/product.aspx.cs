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
using System.Text;
using System.IO;
public partial class spadmin_product : System.Web.UI.Page
{

    public string yuurl = "";
    public string addcart   ="0";
    public string fcount = "0";
    protected void Page_Init(object sender, EventArgs e)
    {
        DropDownList1.DataBound  += new EventHandler(DropDownList1_DataBound);
        string strsql = "select * from tbl_product_kind where kindid >   @id";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", "0");
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);                 
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string name = dt.Rows[i]["name"].ToString();
            string id = dt.Rows[i]["KindId"].ToString();
            kindid.Items.Add(new ListItem(name, id));
                
        }
        dt.Dispose();
        groupproductcode.Items.Clear();
        groupproductcode.Items.Add(new ListItem("無", ""));
       strsql = "select * from tbl_product  where  isgroup =   @id  order by p_id desc";
        nvc.Clear ();
        nvc.Add("id", "Y");
       dt = admin_contrl.Data_Get(strsql, nvc);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string name = dt.Rows[i]["productname"].ToString();
            string id = dt.Rows[i]["p_id"].ToString();
            groupproductcode.Items.Add(new ListItem(name, id));

        }
        dt.Dispose();

        for (int i = 0; i <= 23; i++)
        {
            enabledatetime.Items.Add(i.ToString ());
            disabledatetime.Items.Add(i.ToString());
        }




     }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
            selectSQL();

//            string out_csv = "商品序號,產品品號,產品類別,產品名稱,庫存量, 收藏數 加入次數,會員價,優惠價,生效日,失效日" + "\r\n";
//            string filenname = Server.MapPath("report/report_product.csv");
//            using (SqlConnection conn = new SqlConnection(unity.classlib.dbConnectionString))
//            {
//                string strsql = @" SELECT *,
//(select count(*) from tbl_goods_follow  where productid = p_id  ) as fcount  
//from tbl_product INNER JOIN tbl_product_kind ON tbl_product.KindId = tbl_product_kind.KindId
//order by p_id desc";     
     
//                conn.Open();
//                SqlDataReader rs;
//                SqlCommand cmd = new SqlCommand();
//                cmd = new SqlCommand(strsql, conn);
//                rs = cmd.ExecuteReader();
//                while (rs.Read())  {
//                    out_csv += rs["p_id"].ToString() + "," + rs["productcode"].ToString() + ","
//                        + rs["productname"].ToString() + ","+ rs["storage"].ToString() + ","
//                          + rs["fcount"].ToString() + "," + rs["addcart"].ToString() + ","
//                        + rs["price2"].ToString() + "," + rs["price3"].ToString() + ","
//                       + rs["enabledate"].ToString() + "," + rs["disabledate"].ToString() + "\r\n";
//                }
//                cmd.Dispose();
//                rs.Close();
//                conn.Close();
//            }
//            using (StreamWriter file =
//            new StreamWriter(filenname, false, Encoding.UTF8))
//            {
//                file.WriteLine(out_csv);
//                file.Close();
//                file.Dispose();
//            }
      }

    }
    protected void link_edit(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        Selected_id.Value = obj.CommandArgument;

        string strsql = "select * ,(select count(*) from tbl_goods_follow  where productid = p_id  ) as fcount from tbl_product where p_id  = @p_id";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("p_id", Selected_id.Value );
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        addcart = dt.Rows[0]["addcart"].ToString();
        fcount = dt.Rows[0]["fcount"].ToString();
        price1.Text = dt.Rows[0]["price1"].ToString();
        price2.Text = dt.Rows[0]["price2"].ToString();
        price3.Text = dt.Rows[0]["price3"].ToString();
        fbprice.Text = dt.Rows[0]["fbprice"].ToString();
        p_id.Text = dt.Rows[0]["p_id"].ToString();
        channel.Checked = dt.Rows[0]["channel"].ToString() != "" ? true : false;

        usecash.Checked = dt.Rows[0]["usecash"].ToString() == "Y" ? true : false;
        productname.Text = dt.Rows[0]["productname"].ToString ();
        productcode.Text = dt.Rows[0]["productcode"].ToString();
        if (dt.Rows[0]["isgroup"].ToString() == "")
            isgroup.SelectedValue = "N";
        else
            isgroup.SelectedValue = dt.Rows[0]["isgroup"].ToString();    
        groupproductcode.SelectedIndex = groupproductcode.Items.IndexOf(groupproductcode.Items .FindByValue(dt.Rows[0]["groupproductcode"].ToString()));
        storage.Text = dt.Rows[0]["storage"].ToString();
        enabledate.Text = DateTime.Parse(dt.Rows[0]["enabledate"].ToString()).ToString("yyyy/MM/dd");
        enabledatetime.SelectedValue  = DateTime.Parse(dt.Rows[0]["enabledate"].ToString()).Hour.ToString ();
        if (dt.Rows[0]["disabledate"].ToString () != "")
        { 
            disabledate.Text = DateTime.Parse(dt.Rows[0]["disabledate"].ToString()).ToString("yyyy/MM/dd");
            disabledatetime.SelectedValue = DateTime.Parse(dt.Rows[0]["disabledate"].ToString()).Hour.ToString();
        }
        videourl .Text = dt.Rows[0]["videourl"].ToString();
        briefcont.Text = dt.Rows[0]["briefcont"].ToString();
        spec.Text = dt.Rows[0]["spec"].ToString();
        description.Text = dt.Rows[0]["description"].ToString();
        howtouse.Text = dt.Rows[0]["howtouse"].ToString();
        memo.Text = dt.Rows[0]["memo"].ToString();
        keyword.Text = dt.Rows[0]["keyword"].ToString();
        status.SelectedValue = dt.Rows[0]["status"].ToString();
        kindid.SelectedValue = dt.Rows[0]["KindId"].ToString();
        ship.SelectedValue = dt.Rows[0]["ship"].ToString();
        Remarks.Text = dt.Rows[0]["Remarks"].ToString();
        preorder.Checked = dt.Rows[0]["preorder"].ToString() == "Y" ? true : false;
        pd_imglist.Text = "";
        if (dt.Rows[0]["file1"].ToString() != "")  {
            pd_imglist.Text += "<li><a href=\"#\">刪除</a><br><image src=\"/webimages/product/" + dt.Rows[0]["file1"].ToString() + "\"><input type =\"hidden\" name=\"pd_img\" value=\"" + dt.Rows[0]["file1"].ToString() + "\"></li>";
        }
        if (dt.Rows[0]["file2"].ToString() != "")
        {
            pd_imglist.Text += "<li><a href=\"#\">刪除</a><br><image src=\"/webimages/product/" + dt.Rows[0]["file2"].ToString() + "\"><input type =\"hidden\" name=\"pd_img\" value=\"" + dt.Rows[0]["file2"].ToString() + "\"></li>";
        }
        if (dt.Rows[0]["file3"].ToString() != "")
        {
            pd_imglist.Text += "<li><a href=\"#\">刪除</a><br><image src=\"/webimages/product/" + dt.Rows[0]["file3"].ToString() + "\"><input type =\"hidden\" name=\"pd_img\" value=\"" + dt.Rows[0]["file3"].ToString() + "\"></li>";
        }
        if (dt.Rows[0]["file4"].ToString() != "")
        {
            pd_imglist.Text += "<li><a href=\"#\">刪除</a><br><image src=\"/webimages/product/" + dt.Rows[0]["file4"].ToString() + "\"><input type =\"hidden\" name=\"pd_img\" value=\"" + dt.Rows[0]["file4"].ToString() + "\"></li>";
        }
        if (dt.Rows[0]["file5"].ToString() != "")
        {
            pd_imglist.Text += "<li><a href=\"#\">刪除</a><br><image src=\"/webimages/product/" + dt.Rows[0]["file5"].ToString() + "\"><input type =\"hidden\" name=\"pd_img\" value=\"" + dt.Rows[0]["file5"].ToString() + "\"></li>";
        }
        dt.Dispose();
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";
        if (obj.CommandName == "copy")
        {
      
            Btn_save.CommandArgument = "copy";
        }

        strsql = "select * from tbl_product where groupproductcode  = @p_id";
        nvc.Clear();
        nvc.Add("p_id", Selected_id.Value);
       dt = admin_contrl.Data_Get(strsql, nvc);
        int i = 0;
        groupproductlabel.Text = "";
        for (i = 0; i < dt.Rows.Count; i++)
        {
            groupproductlabel.Text += dt.Rows[i]["productname"].ToString() + "(" + dt.Rows[i]["productcode"].ToString() + "/庫存數:" + dt.Rows[i]["storage"].ToString() + ")<Br>";

        }

        if (videourl.Text != "")
        {
            yuurl = classlib.get_youtubeid(videourl.Text);
            yuurl = "<Br><div class=\"video-container\"><iframe class=\"media\" width = \"854\" height = \"480\" src = \"https://www.youtube.com/embed/" + yuurl + "?rel=0\" frameborder = \"0\" allowfullscreen></iframe></div>";
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
        int num =0 ;
        LinkButton obj = sender as LinkButton;
        string[] myvals;
        if (Request["pd_img"] != null)
        {
            myvals = Request["pd_img"].Split(',');
           
        }
        else
        {
            myvals = new string[] { "" };
        }        
    
        string[] stringArray = new string[100];
        for (i = 0; i <= myvals.GetUpperBound(0); i++)
        {
            stringArray[i] = myvals[i].ToString();
        }

      //  Remarks.Text = Remarks.Text.Replace("：", ":").Replace("「", "[").Replace("」", "]");
         NameValueCollection nvc = new NameValueCollection();
        string strsql = "";
        if (Btn_save.CommandArgument == "copy" || Btn_save.CommandArgument == "add")
        {
            strsql = "insert into tbl_product(enabledate,price1,createdate ,createuserid ) values (getdate(),@price,getdate(),@createuserid ) ";
           
            nvc.Add("price", "0");
            nvc.Add("createuserid", Session ["userid"].ToString ());
            i = admin_contrl.Data_add (strsql, nvc);
           
            strsql = "select max(p_id ) from tbl_product where p_id >@p_id ";
            nvc.Clear();
            nvc.Add("p_id", "0");
            DataTable dt = admin_contrl.Data_Get(strsql, nvc);
            p_id.Text = dt.Rows[0][0].ToString();           
        }
      
        strsql = @"UPDATE  tbl_product SET  productcode=@productcode,productname=@productname,price1=@price1,price2 =@price2, 
                price3=@price3,spec= @spec, description = @description, howtouse = @howtouse, memo = @memo, storage = @storage,
                updatetime =getdate(), file1 = @file1, file2 = @file2, file3 = @file3, file4 = @file4, file5 = @file5,
                KindId = @KindId, briefcont = @briefcont,  status = @status, ship = @ship, fbprice=@fbprice, videourl =@videourl,
                enabledate = @enabledate, disabledate = @disabledate, isgroup = @isgroup, groupproductcode = @groupproductcode,
                groupproductlabel = @groupproductlabel, keyword = @keyword,channel=@channel,Remarks=@Remarks 
                ,    preorder=@preorder,usecash=@usecash where p_id=@id ";

     
     
            string groupproductlabel = "";
     
            nvc.Clear();
            nvc.Add("price1", price1.Text);
            nvc.Add("price2", price2.Text);
            nvc.Add("price3", (price3.Text) =="" ? "0": price3.Text);
            nvc.Add("fbprice", (fbprice.Text) == "" ? "0" : fbprice.Text);
            nvc.Add("videourl", videourl.Text ) ;
            nvc.Add("productname", productname.Text);
            nvc.Add("productcode",  productcode.Text );
            nvc.Add("storage",  storage.Text);
            nvc.Add("enabledate", enabledate.Text + " " + enabledatetime.SelectedValue + ":00:00");

            if (disabledate.Text != "" )            
               nvc.Add("disabledate  ", disabledate.Text + " " +  disabledatetime.SelectedValue + ":00:00");
            else
                nvc.Add("disabledate", "DBNull");
            string tmp = channel.Checked == true ? "Y" : "";
            nvc.Add("channel", tmp);
            nvc.Add("briefcont",briefcont.Text)  ;
            nvc.Add("spec", spec.Text) ;
            nvc.Add("description", description.Text);
            nvc.Add("howtouse",howtouse.Text ) ;
            nvc.Add("memo",memo.Text)  ;
            nvc.Add("keyword",keyword.Text)  ;
            nvc.Add("status",  status.SelectedValue ) ;
            nvc.Add("KindId", kindid.SelectedValue) ;
            nvc.Add("ship",ship.SelectedValue ) ;                 
            nvc.Add("file1", stringArray[0] == null ? "" : stringArray[0]);
            nvc.Add("file2", stringArray[1] == null ? "" : stringArray[1]);
            nvc.Add("file3", stringArray[2] == null ? "" : stringArray[2]);
            nvc.Add("file4", stringArray[3] == null ? "" : stringArray[3]);
            nvc.Add("file5", stringArray[4] == null ? "" : stringArray[4]);
            nvc.Add("isgroup", isgroup.SelectedValue );
            nvc.Add("groupproductcode", groupproductcode.SelectedValue );
            nvc.Add("groupproductlabel", groupproductlabel);
            nvc.Add("Remarks", Remarks.Text);
            nvc.Add ("preorder",    preorder.Checked  == true  ? "Y" : "N");
             nvc.Add("usecash",  usecash  .Checked == true ? "Y" : "N");
            i = admin_contrl.Data_update(strsql, nvc, p_id.Text);

      
            string[] CATEGORY_CLASS1 = new string[10];
            string[] CATEGORY_CLASS2 = new string[10];
            string[] CATEGORY_CLASS3 = new string[10];
            CATEGORY_CLASS3 = Request["CATEGORY_CLASS3"].Split(',');
            CATEGORY_CLASS2 = Request["CATEGORY_CLASS2"].Split(',');
            CATEGORY_CLASS1 = Request["CATEGORY_CLASS1"].Split(',');
            strsql = "delete FROM  tbl_category_link_product where productid=@id";
            num = admin_contrl.Data_delete(strsql, p_id.Text);

        
        for ( i = 0; i <= CATEGORY_CLASS2.GetUpperBound(0); i++)
        {
            nvc.Clear();
            strsql = @"INSERT INTO tbl_category_link_product  (categoryid, productid, sort, createdate)
                        VALUES(@categoryid, @productid, @sort,getdate()) ";
            if (CATEGORY_CLASS2[i] != "0")
            {
                nvc.Add("sort", i.ToString ());
                nvc.Add("productid", p_id.Text);
               

                if (CATEGORY_CLASS3[i].ToString() != "0")                  
                    nvc.Add("categoryid", CATEGORY_CLASS3[i]);                
                else                                
                    nvc.Add("categoryid", CATEGORY_CLASS2[i]);

                num = admin_contrl.Data_add(strsql, nvc);
               
            }
        }

  
      
        selectSQL();
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
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

        string strsql = @" SELECT p_id,productcode,productname,tbl_product.kindid,addcart,price2,price3
, storage, status,tbl_product_kind.name,channel,enabledate,disabledate,
(select count(*) from tbl_goods_follow  where productid = p_id  ) as fcount , 
 (select top 1title from tbl_category_link_product INNER JOIN
                      tbl_category ON tbl_category_link_product.categoryid = tbl_category.categoryid INNER JOIN
                      tbl_product ON tbl_category_link_product.productid = tbl_product.p_id) as title 
from  tbl_product INNER JOIN tbl_product_kind ON tbl_product.KindId = tbl_product_kind.KindId";     
        strsql += "  where p_id > 0 ";
        if (DropDownList2.SelectedValue != "")
            strsql += " and storage " + DropDownList2.SelectedValue + num.Text;
        if (search_txt.Text != "")
        {
            int n;
            bool isNumeric = int.TryParse(search_txt.Text, out n);
            string S = search_txt.Text;
            if (isNumeric)
                strsql += " and ( p_id like '%" + S + "%'  or productcode like '%" + S+"%' or productname like '%"+ S+"%'  or groupproductcode like '%"+ S +"%' ) ";
            else
            {
                strsql += @" and ( p_id like '%" + S + "%'  or productcode like '%" + S + "%'";

                strsql += " or productname like '%" + S + "%' or description like '%" + S + "%' or briefcont like '%" + S + "%'";
                strsql += " or groupproductcode like '%" + S + "%' or memo like '%" + S + "%' or spec like '%" + S + "%') ";
            }
          //  viewDataSource.SelectParameters.Add("S", search_txt.Text);
        }
        if (DropDownList1.SelectedIndex >0)
        {
            strsql += " and ( tbl_product.KindId =  " + DropDownList1.SelectedValue;
            if (DropDownList1.SelectedValue =="12")  strsql += " or isgroup ='Y'   ";
            strsql += " )";
         //   viewDataSource.SelectParameters.Add("kindid",  DropDownList1.SelectedValue );
        }      
        strsql += " ORDER BY  " + sortColumn + " " + sorttype;
        viewDataSource.SelectCommand = strsql;
    
        Session["report_sql"] = strsql;
      
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
        pd_imglist.Text = "";
        ContentPlaceHolder mp;       
        mp =          (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
        MultiView mu1;
        mu1 = (MultiView) mp.FindControl ("MultiView1");
        View vi2 =(View ) mu1.FindControl("view2");
        channel.Checked = false;
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
        }        
    }



}