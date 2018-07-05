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
using System.IO;
using System.Text;
using unity;
using System.Collections.Specialized;
public partial class spadmin_orderprint : System.Web.UI.Page
{

    public string ord_code = "";
    public string ord_date = "";
    public string totalprice = "";
    public string DeliveryPrice = "";
    public string ordname = "";
    public string ordphone = "";
    public string ordaddress = "";
    public string SubPrice = "";
    public string ordemail = "";
    public string memberid = "";
    public string ord_id = "";
    public string CardAUTHINFO = "";
    public string outfile = "";
    public string paymode = "";
    public string receivetime = "";
    public string invoice = "";
    public string title = "";
    public string companyno = "";
    public string contents = "";
    public string shipname = "";
    public string shipphone = "";
    public string shipaddress = "";
    public string shipgender = "";
    public string ordgender = "";
    public string paid = "未付款";
    public string ord_status = "";
    protected void Page_Load(object sender, EventArgs e)
    {


        ord_id = Request.QueryString["ord_id"];

        DataTable dt = new DataTable();
        string strsql = "select * from OrderData where ord_id=@ord_id";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_id", ord_id);
        dt = admin_contrl.Data_Get(strsql, nvc);
        totalprice = dt.Rows[0]["totalprice"].ToString();
        ord_code = dt.Rows[0]["ord_code"].ToString();
        ord_date = DateTime.Parse(dt.Rows[0]["crtdat"].ToString()).ToString("yyyy/MM/dd hh:mm");
        paymode = classlib.getPaymode ( dt.Rows[0]["paymode"].ToString());
        receivetime = classlib.getReceivetime ( dt.Rows[0]["receivetime"].ToString());
        invoice = classlib.getInvoice( dt.Rows[0]["invoice"].ToString());
        contents  = dt.Rows[0]["contents"].ToString();
        ordname = dt.Rows[0]["ordname"].ToString();
        ordphone = dt.Rows[0]["ordphone"].ToString();
        ordaddress = dt.Rows[0]["ordaddress"].ToString();
        shipname  = dt.Rows[0]["shipname"].ToString();
        shipphone  = dt.Rows[0]["shipphone"].ToString();
        shipgender = dt.Rows[0]["shipgender"].ToString();
        ordgender = dt.Rows[0]["ordgender"].ToString();
        shipaddress  = dt.Rows[0]["shipaddress"].ToString();
        if (dt.Rows[0]["paid"].ToString() == "Y") paid = "已付款";
        ord_status = classlib.get_ord_status(dt.Rows[0]["status"].ToString());
        ordemail = dt.Rows[0]["memberid"].ToString();
        DeliveryPrice = dt.Rows[0]["DeliveryPrice"].ToString();
        SubPrice = dt.Rows[0]["SubPrice"].ToString();
        memberid = dt.Rows[0]["memberid"].ToString();
        ord_id = dt.Rows[0]["ord_id"].ToString();
       // payStatus.SelectedValue = dt.Rows[0]["status"].ToString();
        companyno  = dt.Rows[0]["companyno"].ToString();
        title  = dt.Rows[0]["title"].ToString();
        dt.Dispose();


        strsql = @"select *  FROM         OrderDetail INNER JOIN
                      productData ON OrderDetail.p_id = productData.p_id where ord_id=@ord_id";
        dt = admin_contrl.Data_Get(strsql, nvc);
        Repeater1.DataSource = dt;
        Repeater1.DataBind();

    
    }
}