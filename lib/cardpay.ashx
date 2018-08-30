<%@ WebHandler Language="C#" Class="cardpay" %>

using System;
using System.Web;
using unity;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.SessionState;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
public class cardpay : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        //(STOREID+ORDERNUMBER+AMOUNT+CUBKEY)
        //【特店代號】：011210028
        //【CUBKEY】：d6389d21e43d61ed226d75e5ab03e68d
        
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;
            conn.Open();
            string CAVALUE = "";
            string STOREID = "011210028";
            string ORDERNUMBER = "";
            string AMOUNT = "";
            string CUBKEY = "d6389d21e43d61ed226d75e5ab03e68d";
            string strsql = @"select * from  orderdata  where ord_id =@ord_id  ";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@ord_id", SqlDbType.VarChar).Value = context.Session["ord_id"].ToString ();

            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                ORDERNUMBER  = rs["ord_code"].ToString();
                AMOUNT =  rs["TotalPrice"].ToString();
             //   AMOUNT = "1";//測試刷卡

            }
            cmd.Dispose();
            rs.Close();

            CAVALUE = STOREID + ORDERNUMBER + AMOUNT + CUBKEY;
            CAVALUE = classlib.GetMD5(CAVALUE);
            string xml = @"<?xml version='1.0' encoding='UTF-8'?>" +
            "<MERCHANTXML>" +
            "<CAVALUE>" + CAVALUE +"</CAVALUE>" +
            "<ORDERINFO>" +
            "<STOREID>" + STOREID + "</STOREID>" +
            "<ORDERNUMBER>" +  ORDERNUMBER  + "</ORDERNUMBER>" +
            "<AMOUNT>" + AMOUNT +"</AMOUNT>" +
            "</ORDERINFO>" +
            "</MERCHANTXML>";
            conn.Close();
            //https://sslpayment.uwccb.com.tw/EPOSService/Payment/OrderInitial.aspx

            string html="<html><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">" +
                             "<body onload=\"document.main.submit();\">資料傳送中...\r\n"  +
                                "<form name=\"main\" action=\"https://sslpayment.uwccb.com.tw/EPOSService/Payment/OrderInitial.aspx\" method=\"post\">" +
                                "<input type=hidden name=\"strRqXML\" value=\"" + xml + "\">" +
                                "</form></body></html>";

            context.Response.Write(html);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}