using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SpGatewayHelper.Models;
using SpGatewayHelper.Helper;

public partial class pay : System.Web.UI.Page
{
    //https://ccore.spgateway.com/MPG/mpg_gateway 
    //測試平台https://cwww.spgateway.com/
    // 正式平台https://www.spgateway.com/
    public string  txt  ;
    public string Sha;
    public string aes;
    public string MerchantID ;
    public string action;
    protected void Page_Load(object sender, EventArgs e)
    {
        OrderLib.OrderData o = new OrderLib.OrderData();
        o = OrderLib.Get_ordData(Session["ord_code"].ToString());
        action = "https://core.spgateway.com/MPG/mpg_gateway";//正式ID
        action = "https://ccore.spgateway.com/MPG/mpg_gateway";//測試ID
        MerchantID = "MS357549208"; //正式ID
        MerchantID = "MS34344182";//測試ID
        string _key = "CD9Zyfb82BIFpnYY2JUppiF4a3f1FB1B";
        _key = "By8IMdyhhfeTTgACeHciAYe6bGrXc6bA";
        string _Vi = "jXbof2czX0r9FxBf";
        _Vi = "hiDG6VP3CrOA32bM";
        string _ItemDesc="";
        foreach (var obj in o.OrderDetail)
        {
            _ItemDesc += obj.P_name + ","; 
        }
        var tradeInfo = new TradeInfo()
        {
            MerchantID = MerchantID,
            RespondType = "JSON",
            TimeStamp = (DateTime.UtcNow.Subtract(new DateTime(1970, 1, 1))).TotalSeconds.ToString (),
            Version = "1.4",
            Amt = o.TotalPrice ,
            ItemDesc = _ItemDesc,
            //InstFlag="3,6",
            //CreditRed = 0,
            Email = o.Ordemail,
            EmailModify = 0,
            LoginType = 0,
            MerchantOrderNo = DateTime.Now.Ticks.ToString(),
            TradeLimit = 180,
            //CVS=1,
            //ExpireDate=DateTime.Now.ToString("yyyyMMdd"),
            ReturnURL = "https://www.culturelaunch.net/completed",
            NotifyURL = "https://www.culturelaunch.net/receive.ashx",
            CustomerURL = "https://www.culturelaunch.net/back",
        };
        var postData = tradeInfo.ToDictionary();
        var cryptoHelper = new CryptoHelper(_key, _Vi);
        var aesString = cryptoHelper.GetAesString(postData);
        aes = aesString;
        Sha = cryptoHelper.GetSha256String(aesString);
        //ViewData["TradeInfo"] = aesString;
        // ViewData["TradeSha"] = cryptoHelper.GetSha256String(aesString);

    }
}