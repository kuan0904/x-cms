﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Diagnostics;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using unity;
using System.Collections.Specialized;

public partial class spadmin_orderdata : System.Web.UI.Page
{

    public string ord_code = "";
    public string ord_date = "";
    public string totalprice = "";
    public string DeliveryPrice = "";
    public string ordname = "";
    public string ordphone = "";
    public string ordaddress = "";
    public string SubPrice = "";
    public string email = "";
    public string memberid = "";
    public string ord_id = "";
    public string CardAUTHINFO = "";
    public string outfile = "";
    public string discount = "";
 
    protected void Page_Init(object sender, EventArgs e)
    {
        //   Export("application/ms-excel", "employee.xls")
        enddate.Text = DateTime.Today.ToString("yyyy/MM/dd");
        strdate.Text = DateTime.Today.AddDays (-7).ToString("yyyy/MM/dd");
        DataTable dt = new DataTable();
        string strsql = "select * from Receivetime where status=@status";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("status", "Y");
        dt = DbControl.Data_Get(strsql, nvc);
        receivetime.DataSource = dt;
        receivetime.DataBind();
        dt.Dispose();

        strsql = "select * from invoice where status=@status";
        dt = DbControl.Data_Get(strsql, nvc);
        invoice.DataSource = dt;
        invoice.DataBind();
        dt.Dispose();



        strsql = "select * from payStatus where status=@status";
        dt = DbControl.Data_Get(strsql, nvc);
        payStatus.DataSource = dt;
        payStatus.DataBind();
        qstatus.DataSource = dt;
        qstatus.DataBind();
        qstatus.Items.Insert(0, new ListItem("不區分"));
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        outfile = "";
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;
           
        }
      
    }
    protected void link_edit(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        Selected_id.Value = obj.CommandArgument;
     
        DataTable dt= new DataTable() ;
        string strsql = "select * from OrderData where ord_id=@ord_id";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_id", Selected_id.Value  );
        dt= DbControl.Data_Get(strsql, nvc);
        totalprice = dt.Rows[0]["totalprice"].ToString();
        ord_code = dt.Rows[0]["ord_code"].ToString();
        ord_date = DateTime.Parse(dt.Rows[0]["crtdat"].ToString()).ToString("yyyy/MM/dd hh:mm");
        paymode.Text =dt.Rows[0]["paymode"].ToString();
        invoice .SelectedValue = dt.Rows[0]["invoice"].ToString();
        contents.Text  = dt.Rows[0]["contents"].ToString();
        ordname = dt.Rows[0]["ordname"].ToString();
        ordphone = dt.Rows[0]["ordphone"].ToString();
        ordaddress = dt.Rows[0]["ordaddress"].ToString();
        shipname.Text= dt.Rows[0]["shipname"].ToString();
        shipphone.Text  = dt.Rows[0]["shipphone"].ToString();
        shipaddress.Text  = dt.Rows[0]["shipaddress"].ToString();
        atmCode.Text  = dt.Rows[0]["atmCode"].ToString();
        email = dt.Rows[0]["memberid"].ToString();
        DeliveryPrice = dt.Rows[0]["DeliveryPrice"].ToString();
        SubPrice = dt.Rows[0]["SubPrice"].ToString();
        memberid = dt.Rows[0]["memberid"].ToString();
        ord_id = dt.Rows[0]["ord_id"].ToString();
        payStatus.SelectedValue  = dt.Rows[0]["status"].ToString();
        companyno.Text = dt.Rows[0]["companyno"].ToString();
        title.Text = dt.Rows[0]["title"].ToString();
        discount = dt.Rows[0]["DiscountPrice"].ToString();
  
        coupon_no.Text = dt.Rows[0]["coupon_no"].ToString();
        if (dt.Rows[0]["paid"].ToString() == "Y")
            paid.SelectedValue = "Y";
        else
            paid.SelectedValue = "N";
        dt.Dispose();        
        strsql = @"select *  FROM         OrderDetail INNER JOIN
                      productData ON OrderDetail.p_id = productData.p_id where ord_id=@ord_id";
        dt = DbControl.Data_Get(strsql, nvc);
        Repeater1.DataSource = dt;
        Repeater1.DataBind();

        strsql = "select * from CardAUTHINFO where ord_code=@ord_code";
        nvc.Clear();
        nvc.Add("ord_code", ord_code);
        dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0)
        {
            CardAUTHINFO = "授權碼:" + dt.Rows[0]["AUTHCODE"].ToString() + "授權結果:" + dt.Rows[0]["AUTHMSG"].ToString();

        }
        dt.Dispose();

        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";

    }
    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
        string strsql = @"update  OrderData set 
        paymode=@paymode,
        invoice=@invoice,
        receivetime=@receivetime,
        shipname=@shipname,
        shipphone=@shipphone,
        shipaddress=@shipaddress,     
        contents=@contents,
        companyno=@companyno,
        status =@status,coupon_no=@coupon_no,
        atmcode=@atmcode,title=@title,paid=@paid
        where ord_id=@ord_id";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("paymode", paymode.Text  );
        nvc.Add("invoice", invoice.SelectedValue);
        nvc.Add("receivetime", receivetime.SelectedValue);
        nvc.Add("status", payStatus.SelectedValue);
        nvc.Add("shipname", shipname.Text);
        nvc.Add("shipphone", shipphone.Text);
        nvc.Add("shipaddress", shipaddress.Text);
        nvc.Add("contents", contents.Text );
        nvc.Add("atmCode ", atmCode .Text);
        nvc.Add("ord_id", Selected_id.Value);
        nvc.Add("companyno", companyno.Text);
        nvc.Add("coupon_no", coupon_no.Text);
        nvc.Add("title", title.Text);
        nvc.Add("paid", paid.SelectedValue );
        int i = DbControl.Data_add(strsql, nvc);
        nvc.Clear();
    
        LinkButton obj = sender as LinkButton;
        selectSQL();
        MultiView1.ActiveViewIndex = 0;
    }
    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {

        MultiView1.ActiveViewIndex = 0;
    }

    protected void btn_search_Click(object sender, EventArgs e)
    {
        //        string.Contains("pattern") is equivalent to LIKE '%pattern%'
        //string.StartsWith("pattern") is equivalent to LIKE 'pattern%'
        //string.EndsWith("pattern") is equivalent to LIKE '%pattern'
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


    public void selectSQL(string sorttype = "desc", string sortColumn = "ord_id")
    {

        NameValueCollection nvc = new NameValueCollection();
        string strsql = @" SELECT  *  FROM   OrderData INNER JOIN
                      payStatus ON OrderData.status =payStatus.id            where ord_id > 0 ";
        if ( qpaykind.SelectedIndex > 0)
        {
            strsql += " and paymode= '" + qpaykind.SelectedValue + "' ";
        }
        if (qstatus .SelectedIndex > 0)
        {
            strsql += " and OrderData.status= '" +  qstatus .SelectedValue + "' ";
        }
        if (strdate.Text != "")   strsql += " and ord_date >= '" + strdate.Text  + "'";               
        if (enddate.Text != "")   strsql += " and ord_date <= '" +  enddate.Text + "'";        
      
        if (keyword.Text != "")
        {
            strsql += " and ( ord_code like '%'+@S+'%'  or ord_name like '%'+@S+'%' or ord_email like '%'+@S+'%' or ord_ship_name like '%'+@S+'%' or ord_ship_email like '%'+@S+'%' ) ";
           
            //SqlDataSource3.SelectParameters.Add("S", keyword.Text);
            nvc.Add("S", keyword.Text);
        }
              
        string sql_select = strsql + " ORDER BY  " + sortColumn + " " + sorttype;
        DataTable dt = DbControl.Data_Get(sql_select, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();
     
        dt = DbControl.Data_Get(strsql.Replace ("*", "COUNT(*), SUM(totalprice)"), nvc);
        Literal1.Text = "<b> 訂單筆數:" + dt.Rows[0][0].ToString() + "   訂單金額合計:" + dt.Rows[0][1].ToString() + "</b>" ;
    

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
   
       



    public string get_pd(string ord_code)
    {
        string msg = "";
        string strsql = @"SELECT cast(productdata.productname AS NVARCHAR) + ','
        FROM productdata INNER JOIN orderdetail ON  productdata.p_id = orderdetail.p_id
        WHERE orderdetail.ord_code = @ord_code
        FOR XML PATH('') ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_code", ord_code);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
   
        if (dt.Rows.Count >0 )   msg = dt.Rows[0][0].ToString ();
        return msg;
    }



    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Button b1 = (Button)e.Item.FindControl("Button1");
            System.Data.DataRowView rowView = e.Item.DataItem as System.Data.DataRowView;

        }
   
   
    }




   
}