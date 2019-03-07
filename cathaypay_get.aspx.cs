using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

public partial class cathaypay_get : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    { 
        string url = "https://www.globalmyb2b.com/securities/tx10d0_txt.aspx";

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
        request.Method = "POST";
        request.ContentType = "application/x-www-form-urlencoded";

        string cust_id = "00977211";
        string cust_nickname = "xnet2322";
        string cust_pwd = "npc7qq4m7TsV";
        string acno = "223035004687";
        string from_date = "20190301";
        string to_date = "20190302";
        string txdate8 = "y";
        //必須透過ParseQueryString()來建立NameValueCollection物件，之後.ToString()才能轉換成queryString
        NameValueCollection postParams = System.Web.HttpUtility.ParseQueryString(string.Empty);
        postParams.Add("cust_id", cust_id);
        postParams.Add("cust_nickname", cust_nickname);
        postParams.Add("acno", acno);
        postParams.Add("cust_pwd", cust_pwd);
        postParams.Add("from_date", from_date);
        postParams.Add("to_date", to_date);
        postParams.Add("txdate8", txdate8);
        //Console.WriteLine(postParams.ToString());// 將取得"version=1.0&action=preserveCodeCheck&pCode=pCode&TxID=guid&appId=appId", key和value會自動UrlEncode
        //要發送的字串轉為byte[] 
        byte[] byteArray = Encoding.Default.GetBytes(postParams.ToString());
        using (Stream reqStream = request.GetRequestStream())
        {
            reqStream.Write(byteArray, 0, byteArray.Length);
        }//end using

        //API回傳的字串
        string responseStr = "";
        //發出Request
        using (WebResponse rsp= request.GetResponse())
        {
            using (StreamReader sr = new StreamReader(rsp.GetResponseStream(), Encoding.Default))
            {
                responseStr = sr.ReadToEnd();
                
               Response.Write(responseStr);
            }//end using  
          
        }



    }
}