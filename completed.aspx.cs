using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using unity;
using System.IO;
using System.Collections.Specialized;
public partial class completed : System.Web.UI.Page
{
    public string ord_code = "";

    public string ord_totalprice = "";
    public string ord_date = "";
    public string ord_pay = "";
    public string ord_name = "";
    public string ord_tel = "";
    public string ord_zip = "";
    public string ord_address = "";
    public string ord_acc = "";
    public string ord_email = "";
    public string ord_mobile = "";
    public string ord_ship_name = "";
    public string ord_ship_tel = "";
    public string ord_ship_email = "";
    public string ord_ship_zip = "";
    public string ord_ship_address = "";
    public string ord_item_show = "";
    public string email = "";
    public string ord_memo = "";
    public string ord_status = "";
    protected void Page_Load(object sender, EventArgs e)
    {


        if (Session["ord_code"] != null) ord_code = Session["ord_code"].ToString();
        if (Request.QueryString["ord_code"] != null) ord_code = Request.QueryString["ord_code"];
        if (ord_code == "") Response.End();
        ord_code = classlib.RemoveBadSymbol(ord_code);
        DataTable dt = new DataTable();

        string strsql = @"select *  FROM      tbl_OrderData  where ord_code=@ord_code";
        NameValueCollection nvc = new NameValueCollection
        {
            { "ord_code", ord_code }
        };
        dt = DbControl.Data_Get(strsql, nvc);
        string ord_id = dt.Rows[0]["ord_id"].ToString();

        ord_tel = dt.Rows[0]["ordphone"].ToString();
        ord_pay = dt.Rows[0]["paymode"].ToString();
        ord_status = dt.Rows[0]["status"].ToString();
        ord_date = DateTime.Parse(dt.Rows[0]["crtdat"].ToString()).ToString("yyyy/MM/dd");

        ord_totalprice = "$" + dt.Rows[0]["TotalPrice"].ToString();
        ord_name = dt.Rows[0]["ordname"].ToString();

        ord_address = dt.Rows[0]["ordaddress"].ToString();
        ord_email = dt.Rows[0]["email"].ToString();
        ord_tel = dt.Rows[0]["ordphone"].ToString();


        ord_ship_name = dt.Rows[0]["ordname"].ToString();
        ord_ship_tel = dt.Rows[0]["ordphone"].ToString();
        email = dt.Rows[0]["email"].ToString();

        ord_ship_name = dt.Rows[0]["ordname"].ToString();

        strsql = @"select *  FROM    tbl_OrderDetail INNER JOIN
                            tbl_productData ON tbl_OrderDetail.p_id = tbl_productData.p_id where ord_id=@ord_id";
        nvc.Clear();
        nvc.Add("ord_id", ord_id);
        dt = DbControl.Data_Get(strsql, nvc);

        temp_product.DataSource = dt;
        temp_product.DataBind();



    }

}