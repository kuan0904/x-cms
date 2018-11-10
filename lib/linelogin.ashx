<%@ WebHandler Language="C#" Class="linelogin" %>

using System;
using System.Web;
using System.Net;
using System.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Configuration;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Collections.Specialized;
using System.Text;
using System.Web.SessionState;
using System.Data;
using unity;
using System.Linq;

public class linelogin : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest(HttpContext context)
    {

        string code = context.Request["code"];
        string url = "https://api.line.me/oauth2/v2.1/token";
        string server_name = "https://" + context.Request.ServerVariables["SERVER_NAME"]  ;
        string returnurl =  "";

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
        request.Method = "POST";
        request.ContentType = "application/x-www-form-urlencoded";


        //必須透過ParseQueryString()來建立NameValueCollection物件，之後.ToString()才能轉換成queryString
        NameValueCollection postParams = System.Web.HttpUtility.ParseQueryString(string.Empty);
        postParams.Add("grant_type", "authorization_code");
        postParams.Add("code", code);
        postParams.Add("redirect_uri", "http://www.culturelaunch.net/lib/linelogin.ashx");
        postParams.Add("client_id", "1620848228");
        postParams.Add("client_secret", "c94a481a1b24ba1d264dc6c60938ce5e");

        byte[] byteArray = Encoding.UTF8.GetBytes(postParams.ToString());
        using (Stream reqStream = request.GetRequestStream())
        {
            reqStream.Write(byteArray, 0, byteArray.Length);
        }//end using

        //API回傳的字串
        string responseStr = "";
        //發出Request
        using (WebResponse response = request.GetResponse())
        {
            using (StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
            {
                responseStr = sr.ReadToEnd();
            }//end using  
        }

        LineLoginToken ToKenObj =   JsonConvert.DeserializeObject< LineLoginToken>(responseStr);
        WebClient wc = new WebClient();
        wc.Encoding = Encoding.UTF8;
        wc.Headers.Add("Content-Type", "application/x-www-form-urlencoded");
       // string result = string.Empty;
        string ApiUrl_Profile = "https://api.line.me/v2/profile";
        wc.Headers.Add("Authorization", "Bearer "+ ToKenObj.access_token);
        string UserProfile = wc.DownloadString(ApiUrl_Profile);
        LineProfile ProfileObj = JsonConvert.DeserializeObject<LineProfile>(UserProfile);
        string p_ACCOUNT = "";
        string p_PASSWD = "";
        p_ACCOUNT ="LINE" + ProfileObj.userId  ;
        p_PASSWD = ProfileObj.userId ;
        string name = ProfileObj.displayName;
        returnurl = context.Request.QueryString["state"];
        if (p_ACCOUNT != "")
        {
            MemberLib.Mmemberdata result = MemberLib.Member.Check_exist(p_ACCOUNT);

            if (result.Memberid.ToString() == "0")
            {
                result = MemberLib.Member.Add("", p_PASSWD, p_ACCOUNT,name);

            }

            context.Session["memberdata"] = result;
         
        }
        string msg = "<script>alert('登入成功');location.href='"+ server_name  + "/index.aspx';</script>";


        if (returnurl !=null && returnurl != "" && returnurl != "undefined"  )
        {
            returnurl = Base64Decode(returnurl);
            if (returnurl.IndexOf("http") == -1)
            {
                if (returnurl.Substring (0,1) =="/")
                    returnurl = server_name + returnurl;
                else
                    returnurl = server_name + "/" +  returnurl;
            }

          //  msg = "<script>alert('登入成功');alert('"+ returnurl   +"');</script>";
        }

        context.Response.Write(msg);
    }


    public static string Base64Encode(string plainText)
    {
        var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
        return System.Convert.ToBase64String(plainTextBytes);
    }
    public static string Base64Decode(string base64EncodedData)
    {
        if (   base64EncodedData==null || base64EncodedData.Length == 0)
        {
            return base64EncodedData;
        }

        else if ((base64EncodedData.Length * 6) % 8 == 0)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }
        else
            return base64EncodedData;
    }

    public class LineLoginToken
    {
        public string access_token { get; set; }
        public int expires_in { get; set; }
        public string id_token { get; set; }
        public string refresh_token { get; set; }
        public string scope { get; set; }
        public string token_type { get; set; }
    }

    public class LineProfile
    {
        public string userId { get; set; }
        public string displayName { get; set; }
        public string pictureUrl { get; set; }
        public string statusMessage { get; set; }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}

  