using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Diagnostics;
using System.Data.SqlClient;

using System.Collections.Specialized;

/// <summary>
/// OrderData 的摘要描述
/// </summary>
public class OrderLib
{
    public OrderLib()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    public static string[] payStatus =
       { "未支付" , "ATM已付款", "信用卡已付款"
            ,  "已退款"
            ,  "待發貨"
            ,  "已發貨"
            ,  "已退貨"
            ,  "已完成"
            ,  "進行中"
            ,  "已消" };

    public static string get_ord_status(string id)
    {
        string value = "";
  
            string strsql;
            strsql = @"SELECT * from payStatus where id=@id ";
        NameValueCollection nvc = new NameValueCollection();
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0) value = dt.Rows[0]["name"].ToString();
        dt.Dispose();
        return value;
    }
    public static string getPaymode(string id)
    {
        string value = "";

        string strsql = @"SELECT * from paymode where id=@id ";
        NameValueCollection nvc = new NameValueCollection();
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0) value = dt.Rows[0]["name"].ToString();
        dt.Dispose();


        return value;
    }
    public static string getReceivetime(string id)
    {
        string value = "";

        string  strsql = @"SELECT * from Receivetime where id=@id ";
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count > 0) value = dt.Rows[0]["name"].ToString();
            dt.Dispose();
            return value;
    }
    public static string getInvoice(string id)
    {
        string value = "";
     
            string strsql;
            strsql = @"SELECT * from invoice where id=@id ";
        NameValueCollection nvc = new NameValueCollection();
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0) value = dt.Rows[0]["name"].ToString();
        dt.Dispose();
        return value;
      
    }
    public static string get_pd(string ord_id)
    {
        string msg = "";
      
            string strsql = @"SELECT *    FROM productdata INNER JOIN orderdetail ON  productdata.p_id = orderdetail.p_id
                WHERE orderdetail.ord_id = @ord_id ";

        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_id", ord_id);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
      
        for(int i =0;i<dt.Rows.Count;i++){
            msg += dt.Rows [i]["productname"].ToString() + "*" + dt.Rows[i]["num"].ToString() + "<BR>";

        }
        dt.Dispose();
          
        return msg;
    }
    public static string Get_coupon_price(string memberid, string discount_no, string price)
    {
        string cc_money = "0";

            string strsql = @"SELECT  *     FROM    coupon    WHERE  sn =@sn 
                and num >0 and convert(varchar, getdate(), 111) between strdate and enddate   ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("sn", discount_no);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0)
          
            {
                if (dt.Rows[0]["status"].ToString() == "N") cc_money = "-1";
                else if (dt.Rows[0]["memberid"].ToString() != "" && dt.Rows[0]["memberid"].ToString() != memberid)
                { cc_money = "-2"; }
                else
                {

                    if (dt.Rows[0]["addition"].ToString() == "Y")
                    {
                        int x = int.Parse(price) / (int)dt.Rows[0]["useprice"];
                        cc_money = ((int)dt.Rows[0]["money"] * x).ToString();// "100";
                    }
                    else
                    {
                        cc_money = dt.Rows[0]["money"].ToString();
                    }
                }

            }
          

  
        return cc_money;
    }
    public class orderData
    {
        public string memberid { get; set; }
        public string password { get; set; }
        public string paymode { get; set; }
        public string invoice { get; set; }
        public string receiveTime { get; set; }
        public string contents { get; set; }
        public string SubPrice { get; set; }
        public string ShipPrice { get; set; }
        public string Discount { get; set; }
        public string TotalPrice { get; set; }
        public string ordname { get; set; }
        public string ordgender { get; set; }
        public string ordemail { get; set; }
        public string ordphone { get; set; }
        public string ordzip { get; set; }
        public string ordcountyid { get; set; }
        public string ordcityid { get; set; }
        public string ordaddress { get; set; }
        public string shipname { get; set; }
        public string shipphone { get; set; }
        public string shipzip { get; set; }
        public string shipcountyid { get; set; }
        public string shipcityid { get; set; }
        public string shipaddress { get; set; }
        public string shipgender { get; set; }
        public string companyno { get; set; }
        public string title { get; set; }
        public string birthday { get; set; }
    }
    public class ShoppingList
    {
        public string p_id { get; set; }
        public int num { get; set; }
        public string ship { get; set; }
        public int amount { get; set; }
        public string file { get; set; }
        public string productname { get; set; }
        public int price { get; set; }
        public int storage { get; set; }
        public int discount { get; set; }
        public string productcode { get; set; }
        public string pic { get; set; }

    }
    public class cart : IEquatable<cart>
    {
        public string p_id { get; set; }
        public int p_num { get; set; }
        public override string ToString()
        {
            return "p_id:" + p_id + "p_num:" + p_num.ToString();
        }

        public bool Equals(cart other)
        {
            if (other == null) return false;
            return (this.p_id.Equals(other.p_id));
        }
    }

}
