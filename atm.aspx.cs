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
using SpGatewayHelper.Helper;
using SpGatewayHelper;
using SpGatewayHelper.Models;
using Newtonsoft.Json;
using System.Data.SqlClient;
public partial class atm : System.Web.UI.Page
{
    public string ord_code = "";
  

    public string ord_memo = "";
    public string ord_status = "";
    public string BankCode = "";
    public string CodeNo = "";
    public string ExpireDate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string _key = "CD9Zyfb82BIFpnYY2JUppiF4a3f1FB1B";
        string _Vi = "jXbof2czX0r9FxBf";
        //_key = "By8IMdyhhfeTTgACeHciAYe6bGrXc6bA";
        //_Vi = "hiDG6VP3CrOA32bM";
        SpGatewayResponse spg = new SpGatewayResponse
        {
            Key = _key,
            Vi = _Vi,
            Status = Request["Status"],
            MerchantId = Request["MerchantID"],
            TradeInfo = Request["TradeInfo"]
        };
        spg.SaveLog();
        spg.AddAtmlog ();

        if (Session["ord_code"] != null) ord_code = Session["ord_code"].ToString();
        if (Request.QueryString["ord_code"] != null) ord_code = Request.QueryString["ord_code"];
        if (ord_code == "") Response.End();
        ord_code = classlib.RemoveBadSymbol(ord_code);
        SpGatewayHelper.Models.TradeInfoLog log =OrderLib.Get_Tradelog(ord_code);
        ord_status = log.Status;
        BankCode = log.Result.BankCode;
        CodeNo = log.Result.CodeNo;
        ExpireDate = log.Result.ExpireDate + " " + log.Result.ExpireTime;
        OrderLib.OrderData o = OrderLib.Get_ordData(ord_code);
        string ord_id = o.Ord_id.ToString();
   
        string site_name = HttpContext.Current.Application["site_name"].ToString();
        string filename = HttpContext.Current.Server.MapPath("/templates/letter.html");
        string mailbody = unity.classlib.GetTextString(filename);

        string atmmode = "<table><Tr><td colspan=2>您於「" + site_name + "」進行了ATM 轉帳交易，以下為您轉帳資訊</td></tr>";
        atmmode += "<tr><td>訂單編號</td><td>" + log.Result.MerchantOrderNo + "</td></tr>";
        atmmode += "<tr><td>銀行代碼</td><td>" + BankCode + "</td></tr>";
        atmmode += "<tr><td>帳號</td><td >" + CodeNo + "</td></tr>";
        atmmode += "<tr><td>金額</td><td >NT$" + log.Result.Amt + "</td></tr>";
        atmmode += "<tr><td>有效期限</td><td>"+ ExpireDate +"</td></tr></table>";
        unity.classlib.SendsmtpMail(o.Ordemail, "ATM匯款帳號通知信", mailbody.Replace("@mailbody@", atmmode), "gmail");

        if (o.OrderDetail != null)
        {
            Response.Redirect("/completed.aspx");
            Response.End();
        }
        LessonLib.JoinData L = LessonLib.Web.Get_ord_JoinData(Session["ord_code"].ToString());
        if (L.JoinDetail != null)
        {
              Response.Redirect("/process-step4.aspx");
        }

    }
   
}
