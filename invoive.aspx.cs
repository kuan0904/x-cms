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
        var pay2goInfo = new pay2goInfo()
        {

            RespondType = "JSON",
            TimeStamp = timeStamp.ToString (),
            Version = "1.4",
            BuyerName = "TTEESSTT",
            BuyerAddress = "taipei",
            BuyerEmail = "leokuan@xnet.world",
            BuyerPhone = "0930909522",
            MerchantOrderNo = DateTime.Now.Ticks.ToString(),
            Category = "B2C",
            TaxType = "1",
            TaxRate = 5,
            Amt = 490,
            TaxAmt = 10,
            TotalAmt = 500,
            CarrierType = "",
            CarrierNum = Server.HtmlDecode(""),
            LoveCode = "",
            PrintFlag = "Y",
            ItemName = "商品一|商品二",  
            ItemCount = "1|2",  
            ItemUnit = "個|位",  
            ItemPrice = "300|100",  
            ItemAmt = "300|200",
            ItemTaxType =" 1|1",
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
            string  HtmlResult = wc.UploadString(URI, myParameters);
            JObject restoredObject = JsonConvert.DeserializeObject<JObject>(HtmlResult);          
            Result result = restoredObject.ToObject  <Result>();           
            //Dictionary<string, string> results = ((IDictionary<string, JToken>)(JObject)parsed["moretests"]).ToDictionary(pair => pair.Key, pair => (string)pair.Value);
            Response.Write(restoredObject["Status"]);
            Response.Write(restoredObject["Message"]);
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {

    }
}