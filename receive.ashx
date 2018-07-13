<%@ WebHandler Language="C#" Class="receive" %>
using System;
using SpGatewayHelper;
using System.Web.UI.WebControls;
using SpGatewayHelper.Models;
using SpGatewayHelper.Helper;
using System.Web;
using System.IO;
using Newtonsoft.Json;
using System.Collections.Generic;

using System.Linq;


public class receive : IHttpHandler , System.Web.SessionState.IRequiresSessionState {

    public void ProcessRequest (HttpContext ww) {

        string _key = "CD9Zyfb82BIFpnYY2JUppiF4a3f1FB1B";
        _key = "By8IMdyhhfeTTgACeHciAYe6bGrXc6bA";
        string _Vi = "jXbof2czX0r9FxBf";
        _Vi = "hiDG6VP3CrOA32bM";
        string Status = ww.Request["Status"] ;
        string MerchantID = ww.Request["MerchantID"];
        string TradeInfo = ww.Request["TradeInfo"];
        string msg ="";
        MerchantID = "MS357549208"; //正式ID
        MerchantID = "MS34344182";//測試ID
        string xml_file = DateTime.Today.ToString("yyyyMMdd") + ".txt";
        xml_file = System.Web.HttpContext.Current.Server.MapPath(xml_file);
        if (System.IO.File.Exists(xml_file)) {
            msg =unity. classlib.GetTextString(xml_file);
        }

        StreamWriter fp = new StreamWriter(xml_file);
        msg += "\r\n[" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "]\r\n";
        msg += "Status:" + Status  + "\r\n" ;
        msg += "MerchantID:" + MerchantID  + "\r\n" ;
        msg += "TradeInfo:" +  TradeInfo  + "\r\n" ;

        //SpGatewayResponse response = new  SpGatewayResponse
        //{
        //    Key = _key,
        //    Vi = _Vi,
        //    MerchantId = MerchantID,
        //    Status =Status ,
        //    TradeInfo =TradeInfo,
        //};
        //var success = response.Validate( MerchantID);
        //if (success)
        //{
        //    var tradInfoModel=response.GetResponseModel<TradeInfoModel>();
        //}

        var cryptoHelper = new CryptoHelper(_key, _Vi);
        var jsonString = cryptoHelper.DecryptAesString(TradeInfo);
        msg += JsonConvert.DeserializeObject (jsonString);

        fp.WriteLine(msg);
        fp.Close();
        fp.Dispose();
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}