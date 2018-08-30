<%@ WebHandler Language="C#" Class="cardreceive" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using unity;
using System.Xml;
using System.IO;
public class cardreceive : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string CAVALUE = "";
        string CUBKEY = "d6389d21e43d61ed226d75e5ab03e68d";
        CAVALUE = "www.cairnskitchen.com" + CUBKEY;
        CAVALUE = classlib.GetMD5(CAVALUE);
        string xml = @"<?xml version='1.0' encoding='UTF-8'?>" +
"<MERCHANTXML>" +
"<CAVALUE>" + CAVALUE + "</CAVALUE>" +
"<RETURL>http://www.cairnskitchen.com/completed</RETURL>" +
"</MERCHANTXML>";
        context.Response.Write(xml);

        string xml_file = "orderdata/" +  DateTime.Today.ToString("yyyyMMdd") + ".txt";
        xml_file = System.Web.HttpContext.Current.Server.MapPath(xml_file);
        string msg = "";
        if (System.IO.File.Exists(xml_file)) {
            msg = classlib.GetTextString(xml_file);
        }
        string input="{";
        if  ( context.Request.Form.Count > 0)
        {
            int i = 0;
            foreach (string item in context.Request.Form)
            {
                if (i != 0) input += ",";
                i += 1;
                input += "\"" + item + "\":\"" + context.Request[item] + "\"";
            }

        }
        input += "}";
        StreamWriter fp = new StreamWriter(xml_file);
        msg += "\r\n[" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "]\r\n";
        msg += input ;
        msg += "\r\n";
        fp.WriteLine(msg);
        fp.Close();
        fp.Dispose();
        string strRsXML = context.Request["strRsXML"];
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            XmlDocument xmlDoc = new XmlDocument();
            //    XmlReader myReader;
            //myReader = XmlReader.Create(Server.MapPath("20161026.xml"));
            string ORDERNUMBER = "";
            string AMOUNT = "";
            string AUTHSTATUS = "";
            string AUTHCODE = "";
            string AUTHTIME = "";
            string AUTHMSG = "";
            xmlDoc.LoadXml( strRsXML);
            //xmlDoc.Load(myReader);
            foreach (XmlNode xNode in xmlDoc.SelectNodes("//CUBXML/ORDERINFO"))
            {
                ORDERNUMBER = xNode.SelectSingleNode("ORDERNUMBER").InnerText;
                AMOUNT = xNode.SelectSingleNode("AMOUNT").InnerText;
            }
            foreach (XmlNode xNode in xmlDoc.SelectNodes("//CUBXML/AUTHINFO"))
            {
                AUTHSTATUS = xNode.SelectSingleNode("AUTHSTATUS ").InnerText;
                AUTHCODE = xNode.SelectSingleNode("AUTHCODE").InnerText;
                AUTHTIME = xNode.SelectSingleNode("AUTHTIME ").InnerText;
                AUTHMSG = xNode.SelectSingleNode("AUTHMSG").InnerText;
            }

            SqlCommand cmd = new SqlCommand();
            string strsql;
            conn.Open();
            strsql = @" insert into CardAUTHINFO  (ord_code, amount, AUTHSTATUS, AUTHCODE, AUTHTIME, AUTHMSG ) values 
                        (  @ord_code, @amount, @AUTHSTATUS, @AUTHCODE, @AUTHTIME, @AUTHMSG ) ";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@ord_code", SqlDbType.VarChar).Value = ORDERNUMBER ;
            cmd.Parameters.Add("@amount", SqlDbType.VarChar).Value = AMOUNT;
            cmd.Parameters.Add("@AUTHSTATUS", SqlDbType.VarChar).Value = AUTHSTATUS;
            cmd.Parameters.Add("@AUTHCODE", SqlDbType.VarChar).Value = AUTHCODE;
            cmd.Parameters.Add("@AUTHTIME", SqlDbType.VarChar).Value = AUTHTIME;
            cmd.Parameters.Add("@AUTHMSG", SqlDbType.NVarChar).Value = AUTHMSG;
            cmd.ExecuteNonQuery();
            cmd.Dispose();

            strsql = @" update  OrderData set status='3',paid='Y' where ord_code=@ord_code";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@ord_code", SqlDbType.VarChar).Value = ORDERNUMBER ;
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }
    }


    public bool IsReusable {
        get {
            return false;
        }
    }

}