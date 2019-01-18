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
using System.Collections.Specialized;
using System.Linq;
using System.Data;

using System.Data.SqlClient;
public class receive :  IHttpHandler, System.Web.SessionState.IRequiresSessionState {

    public void ProcessRequest (HttpContext ww) {


        string _key = "CD9Zyfb82BIFpnYY2JUppiF4a3f1FB1B";
        string _Vi = "jXbof2czX0r9FxBf";
        //_Vi = "hiDG6VP3CrOA32bM";
        //_key = "By8IMdyhhfeTTgACeHciAYe6bGrXc6bA";
        SpGatewayResponse spg = new SpGatewayResponse();
        spg.Key = _key;
        spg.Vi = _Vi;
        spg.Status = ww.Request["Status"];
        spg.MerchantId = ww.Request["MerchantID"];
        spg.TradeInfo = ww.Request["TradeInfo"];
        spg.SaveLog();
        spg.AddCardlog();

      




    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}