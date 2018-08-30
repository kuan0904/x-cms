using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using pay2go.Models;
using SpGatewayHelper.Helper;
using System.Net;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Collections.Specialized;

public partial class invoive : System.Web.UI.Page
{
    //https://ccore.spgateway.com/MPG/mpg_gateway 
    //測試平台https://cinv.pay2go.com/API/invoice_issue
    // 正式平台https://inv.pay2go.com/API/invoice_issue
    public string PostData;
    public string Sha;
    public string aes;
    public string MerchantID;
    public string action;
    protected void Page_Load(object sender, EventArgs e)
    {
        OrderLib.OrderData o = new OrderLib.OrderData();
        o = OrderLib.Get_ordData(Request.QueryString["ord_code"]);


        action = "https://inv.pay2go.com/API/invoice_issue";//正式ID
        action = "https://cinv.pay2go.com/API/invoice_issue";//測試ID
        MerchantID = ""; //正式ID
        MerchantID = "31117495";//測試ID
        string _key = "";
        _key = "8hWZNZjoHkNDTTgOXGYJI4Rc5k3OR7CO";
        string _Vi = "";
        _Vi = "oaAyJlX2BcpSuj8m";
        DateTime gtm = new DateTime(1970, 1, 1);//宣告一個GTM時間出來
        DateTime utc = DateTime.UtcNow.AddHours(8);//宣告一個目前的時間
        int timeStamp = Convert.ToInt32(((TimeSpan)utc.Subtract(gtm)).TotalSeconds);
        int TaxAmt = 0;
        string ItemName = "";
        string ItemCount = "";
        string ItemUnit = "";
        string ItemPrice = "";
        string ItemAmt = "";
        string ItemTaxType = "";
        int i = 0;
        foreach (var p in o.OrderDetail)
        {
            ItemName += i == 0 ? p.P_name : "|" + p.P_name;
            ItemCount += i == 0 ? p.Num.ToString() : "|" + p.Num.ToString();
            ItemUnit += i == 0 ? "個" : "|個";
            ItemPrice += i == 0 ? p.Price.ToString() : "|" + p.Price.ToString();
            TaxAmt += Convert.ToInt16(Math.Ceiling(p.Amount * 0.05));
            ItemAmt += i == 0 ? p.Amount.ToString() : "|" + p.Amount.ToString();
            ItemTaxType += i == 0 ? "1" : "|1";
            i++;
        }

        var pay2goInfo = new pay2goInfo()
        {

            RespondType = "JSON",
            TimeStamp = timeStamp.ToString(),
            Version = "1.4",
            BuyerName = o.Ordname,
            BuyerAddress = o.Shipaddress,
            BuyerEmail = o.Ordemail,
            BuyerPhone = o.Ordphone,
            MerchantOrderNo = timeStamp.ToString(),//o.Ord_code ,
            Category = "B2C",
            TaxType = "1",
            TaxRate = 5,
            Amt = o.TotalPrice - TaxAmt,
            TaxAmt = TaxAmt,
            TotalAmt = o.TotalPrice,
            CarrierType = "",
            CarrierNum = Server.HtmlDecode(""),
            LoveCode = "",
            PrintFlag = "Y",
            ItemName = ItemName,
            ItemCount = ItemCount,
            ItemUnit = ItemUnit,
            ItemPrice = ItemPrice,
            ItemAmt = ItemAmt,
            ItemTaxType = ItemTaxType,
            Comment = "TEST，備註說明",
            Status = "1",
            CreateStatusTime = ""
        };
        var postData = MyHelper.ToDictionary(pay2goInfo);
        var cryptoHelper = new CryptoHelper(_key, _Vi);
        var aesString = cryptoHelper.GetAesString(postData);
        aes = aesString;
        Sha = cryptoHelper.GetSha256String(aesString);
        string URI = action;
        string myParameters = "MerchantID_=" + MerchantID + "&PostData_=" + aes;

        using (WebClient wc = new WebClient())
        {
            wc.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";
            string HtmlResult = wc.UploadString(URI, myParameters); 
            JObject restoredObject = JsonConvert.DeserializeObject<JObject>(HtmlResult);
            JObject result =  JsonConvert.DeserializeObject<JObject>(restoredObject["Result"].ToString ());
            Response.Write(HtmlResult);
            string strsql = @"INSERT INTO InvoiceNumner(InvoiceTransNo, MerchantOrderNo, TotalAmt, 
            InvoiceNumber, RandomNum, CheckCode, CreateTime,
                                        BarCode, QRcodeL, QRcodeR)
            VALUES (@InvoiceTransNo, @MerchantOrderNo, @TotalAmt, @InvoiceNumber, @RandomNum, @CheckCode, @CreateTime,
                                       @BarCode, @QRcodeL, @QRcodeR)";
            NameValueCollection nvc = new NameValueCollection
                        {
                            { "CheckCode", result["CheckCode"].ToString () },
                            { "MerchantOrderNo", result["MerchantOrderNo"].ToString () },
                            { "InvoiceNumber", result["InvoiceNumber"].ToString () },
                            { "TotalAmt", result["TotalAmt"].ToString () },
                            { "InvoiceTransNo", result["InvoiceTransNo"].ToString () },
                            { "RandomNum", result["RandomNum"].ToString () },                           
                            { "CreateTime", result["CreateTime"].ToString () },
                            { "BarCode", result["BarCode"].ToString () },
                            { "QRcodeL", result["QRcodeL"].ToString () },
                            { "QRcodeR", result["QRcodeR"].ToString ()}                        
                            
                        };


            if (result != null) {      DbControl.Data_add (strsql, nvc);}

            //Dictionary<string, string> results = ((IDictionary<string, JToken>)(JObject)parsed["moretests"]).ToDictionary(pair => pair.Key, pair => (string)pair.Value);
            Response.Write(restoredObject["Status"]);
            Response.Write(restoredObject["Message"]);
        }
    }
}