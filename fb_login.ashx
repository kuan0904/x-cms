<%@ WebHandler Language="C#" Class="fb_login" %>
using System;
using System.Web;
using System.Net;
using System.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Configuration;
using System.Linq;
using System.Web.SessionState;


public class fb_login : IHttpHandler ,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        string p_ACCOUNT = "";
        string p_PASSWD = "";
        string email = "";
        string name="";
        string login_type = context.Request.QueryString["login_type"] != null ? context.Request.QueryString["login_type"] : "";
        string returnurl = context.Request.QueryString["page"] != null ? context.Request.QueryString["page"] : "";
        string server_name = "https://" + HttpContext.Current.Request.Url.Host   ;
        if (login_type == "cookie") {

            email =context.Request.Cookies  ["u_fb_email"].Value ;
            name =context.Request.Cookies  ["u_fb_name"].Value ;
            p_ACCOUNT ="FB" + context.Request.Cookies  ["u_fb_id"].Value ;
            p_PASSWD = context.Request.Cookies  ["u_fb_id"].Value;
        }
        else
        {
            string FacebookAppId = "164103481107660"; // "365173480244176"; //正式環境
            string FacebookAppSecret = "97d49edd9b6ec4169c2ae08acc0f46df"; //"6f59da0ffdb6c880a977b3c47945c7bc";
            string code = context.Request.QueryString["code"];
            returnurl = context.Request.QueryString["state"];
            //context.Response.Write("https://graph.facebook.com/oauth/access_token?client_id=" + FacebookAppId + "&client_secret=" + FacebookAppSecret + "&redirect_uri=" + server_name + "/fb_login.ashx&code=" + code);
            //context.Response.End();
            Uri targetUri = new Uri("https://graph.facebook.com/oauth/access_token?client_id=" +  FacebookAppId + "&client_secret=" + FacebookAppSecret + "&redirect_uri=" + server_name + "/fb_login.ashx&code=" + code);

            HttpWebRequest at = (HttpWebRequest)HttpWebRequest.Create(targetUri);

            System.IO.StreamReader str = new System.IO.StreamReader(at.GetResponse().GetResponseStream());
            //  string token = str.ReadToEnd().ToString().Replace("access_token=", "");
            string token = str.ReadToEnd().ToString() ;
            string accessToken = "";

            JObject obj_back = JsonConvert.DeserializeObject<JObject>(token);/*反序列化*/
            accessToken = obj_back["access_token"].ToString ();

            // Exchange the code for an extended access token
            Uri eatTargetUri = new Uri("https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=" + FacebookAppId  + "&client_secret=" + FacebookAppSecret  + "&fb_exchange_token=" + accessToken);
            HttpWebRequest eat = (HttpWebRequest)HttpWebRequest.Create(eatTargetUri);
            StreamReader eatStr = new StreamReader(eat.GetResponse().GetResponseStream());
            string eatToken = eatStr.ReadToEnd().ToString().Replace("access_token=", "");

            // Split the access token and expiration from the single string
            string[] eatWords = eatToken.Split('&');
            string extendedAccessToken = eatWords[0];

            // Request the Facebook user information
            Uri targetUserUri = new Uri("https://graph.facebook.com/me?fields=email,name,first_name,last_name,gender,locale,link&access_token=" + accessToken);
            HttpWebRequest user = (HttpWebRequest)HttpWebRequest.Create(targetUserUri);

            // Read the returned JSON object response
            StreamReader userInfo = new StreamReader(user.GetResponse().GetResponseStream());
            string jsonResponse = string.Empty;
            jsonResponse = userInfo.ReadToEnd();
            JObject fbuser = JsonConvert.DeserializeObject<JObject>(jsonResponse);
            p_ACCOUNT = "FB" + fbuser["id"].ToString();
            p_PASSWD = fbuser["id"].ToString();
            email = (fbuser["email"] != null) ? fbuser["email"].ToString() : "";
            string first_name = (fbuser["first_name"] != null) ? fbuser["first_name"].ToString() : "";
            string last_name = (fbuser["last_name"] != null) ? fbuser["last_name"].ToString() : "";
            name = last_name + first_name;
        }
        //            {
        //   "email": "kuan0904\u0040ms16.hinet.net",
        //   "name": "\u788e\u788e\u5538",
        //   "first_name": "\u788e\u5538",
        //   "last_name": "\u788e",
        //   "gender": "male",
        //   "locale": "zh_TW",
        //   "id": "633770299"
        //}
        ////處理

        if (p_ACCOUNT != "")
        {
            MemberLib.Mmemberdata result = MemberLib.Member.Check_exist(p_ACCOUNT);
            if (result.Memberid .ToString () != "0")
            {
                result =  MemberLib.Member.Add(email, p_PASSWD, p_ACCOUNT);
            }
            context.Session["memberdata"] = result;
        }
        string msg = "<script>alert('登入成功');";

        if (returnurl != "" && returnurl != "undefined" && returnurl != null)
        {
            returnurl = Base64Decode(returnurl);
            if (returnurl.IndexOf("http") == -1)
            {
                if (returnurl.Substring(0, 1) == "/")
                    returnurl = server_name + returnurl;
                else
                    returnurl = server_name + "/" + returnurl;
            }

            msg += "location.href='" + returnurl + "';</script>";
        }
        else
        {
            returnurl = "/";
        }
        msg += "location.href='" + returnurl + "';</script>";
        msg +=  "</script>";
        context.Response.Write(msg);


    }
    public static string Base64Encode(string plainText)
    {
        var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
        return System.Convert.ToBase64String(plainTextBytes);
    }
    public static string Base64Decode(string base64EncodedData)
    {
        if ((base64EncodedData.Length * 6) % 8 == 0)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }
        else
            return base64EncodedData;
    }
    //public class Item
    //{

    //    public string access_token = string.Empty;
    //    public string token_type = string.Empty;
    //    public string  expires_in ="";
    //}
    public bool IsReusable {
        get {
            return false;
        }
    }

}