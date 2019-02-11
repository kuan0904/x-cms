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
        string repay = Request.QueryString["repay"];
        string ord_code = "";
        if (repay !=null && repay != "")
        {
            ord_code = MySecurity.DecryptAES256(repay);
            Session["ord_code"] = ord_code;

        }


        OrderLib.OrderData o = OrderLib.Get_ordData(Session["ord_code"].ToString());

        
        LessonLib.JoinData L = LessonLib.Web.Get_ord_JoinData(Session["ord_code"].ToString());
  
        action = "https://core.spgateway.com/MPG/mpg_gateway";//正式ID       
        MerchantID = "MS357549208"; //正式ID      
        string _key = "CD9Zyfb82BIFpnYY2JUppiF4a3f1FB1B";        
        string _Vi = "jXbof2czX0r9FxBf";
        if (Request.Url.Host.IndexOf ("localhost") !=-1)
        {
            action = "https://ccore.spgateway.com/MPG/mpg_gateway";//測試ID
            MerchantID = "MS34344182";
            _key = "By8IMdyhhfeTTgACeHciAYe6bGrXc6bA";
            _Vi = "hiDG6VP3CrOA32bM";
        }

      
        string _ItemDesc ="";
        foreach (var obj in o.OrderDetail)
        {
            _ItemDesc += obj.P_name + ","; 
        }
        List<article.Lesson> lesson = new List<article.Lesson>();
        article.LessonDetail lessondetail = new article.LessonDetail();

      
        if (L.JoinDetail != null )
        {
            lessondetail = L.LessonData.MainData.Lesson.LessonDetail.Find(c => c.LessonId == L.JoinDetail[0].LessonId );
            _ItemDesc = L.LessonData.MainData.Subject + "-" + lessondetail.Description;
        }
   
        int CREDIT = 0;
        int VACC = 0;
        string CustomerURL = "https://www.culturelaunch.net/back";
        if (o.Paymode == "1") {
            CREDIT = 1;
            CustomerURL = "https://www.culturelaunch.net/completed";
        }
        else if (o.Paymode == "2") {        
            VACC = 1;
            CustomerURL = "https://www.culturelaunch.net/atm";
        }
        var tradeInfo = new TradeInfo()
        {
            MerchantID = MerchantID,
            RespondType = "JSON",
            TimeStamp = (DateTime.UtcNow.Subtract(new DateTime(1970, 1, 1))).TotalSeconds.ToString (),
            Version = "1.5",
            Amt = o.TotalPrice ,
            ItemDesc = _ItemDesc,
            //InstFlag="3,6",           
            Email = o.Ordemail,
            EmailModify = 0,
            LoginType = 0,
            MerchantOrderNo = Session["ord_code"].ToString(),
            TradeLimit = 180,

            //CVS=1,
            //ExpireDate=DateTime.Now.ToString("yyyyMMdd"),
            VACC = VACC,
            BARCODE=0,
            CREDIT= CREDIT,
            CreditRed = 0,
            WEBATM=0,
            ReturnURL = "https://www.culturelaunch.net/completed",
            NotifyURL = "https://www.culturelaunch.net/log/receive.ashx",
            CustomerURL = CustomerURL
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