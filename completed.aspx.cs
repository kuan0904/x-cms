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
using SpGatewayHelper.Models;
public partial class completed : System.Web.UI.Page
{
    public string ord_code = "";
    public string ord_status = "";
    public OrderLib.OrderData o;
    protected void Page_Load(object sender, EventArgs e)
    {


        if (Session["ord_code"] != null) ord_code = Session["ord_code"].ToString();
        if (Request.QueryString["ord_code"] != null) ord_code = Request.QueryString["ord_code"];
        if (ord_code == "") Response.End();
        ord_code = classlib.RemoveBadSymbol(ord_code);
        o = OrderLib.Get_ordData(ord_code);
        SpGatewayHelper.Models.TradeInfoLog log =OrderLib.Get_Tradelog(ord_code );
        string strsql = "";       
        string ord_id = o.Ord_id.ToString();  
        temp_product.DataSource = o.OrderDetail;
        temp_product.DataBind();
  

        if (o.Paymode == "1")
        {
            NameValueCollection nvc = new NameValueCollection
                {
                { "ord_code", ord_code }
                };
            DataTable dt = new DataTable();
            if (log.Status == "SUCCESS")
            {
                strsql = @"update   tbl_OrderData   set paid= 'Y', status =2  where ord_code=@ord_code";
                DbControl.Data_add(strsql, nvc);
                dt.Dispose();
            }
            else
            {
                Response.Redirect("/cardpayfiled");
            }
           
            ord_status = log.Status;

            string site_name = HttpContext.Current.Application["site_name"].ToString();
            string filename = HttpContext.Current.Server.MapPath("/templates/letter.html");
            string mailbody = unity.classlib.GetTextString(filename);
            string atmmode = "<table><Tr><td colspan=2>您於「" + site_name + "」進行了信用卡交易，以下為您付款完成資訊</td></tr>";
            atmmode += "<tr><td>訂單編號</td><td >" + ord_code + "</td></tr>";
            atmmode += "<tr><td>訂單金額</td><td >NT$" +o.TotalPrice + "</td></tr>";
            atmmode += "<tr><td>支付方式</td><td >信用卡一次付清</td></tr>";
            atmmode += "<tr><td>刷卡結果</td><td >付款成功</td></tr></table>";

            unity.classlib.SendsmtpMail(o.Ordemail , "信用卡付款完成通知信", mailbody.Replace("@mailbody@", atmmode), "gmail");
        
        }
        LessonLib.JoinData L = LessonLib.Web.Get_ord_JoinData(Session["ord_code"].ToString());

        if (L.JoinDetail != null)
        {

            Response.Redirect("/process-step4.aspx");
        }
    }

}