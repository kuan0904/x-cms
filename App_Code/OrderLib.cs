using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;
using System.Reflection;
using System.Text;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using SpGatewayHelper.Models;


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
 
    public static string get_ord_status(string id)
    {
        string value = "";
  
            string strsql;
            strsql = @"SELECT * from tbl_payStatus where id=@id ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", id);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0) value = dt.Rows[0]["name"].ToString();
        dt.Dispose();
        return value;
    }
    public static string getPaymode(string id)
    {
        string value = "";

        string strsql = @"SELECT * from tbl_paymode where id=@id ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", id);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0) value = dt.Rows[0]["name"].ToString();
        dt.Dispose();


        return value;
    }
    public static string getdelivery_kind(string id)
    {
        string value = "";

        string strsql = @"SELECT * from tbl_delivery_kind where id=@id ";
        NameValueCollection nvc = new NameValueCollection
        {
            { "id", id }
        };
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0) value = dt.Rows[0]["name"].ToString();
        dt.Dispose();


        return value;
    }
    public static string getReceivetime(string id)
    {
        string value = "";

        string  strsql = @"SELECT * from tbl_Receivetime where id=@id ";
            NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", id);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count > 0) value = dt.Rows[0]["name"].ToString();
            dt.Dispose();
            return value;
    }
    public static string getInvoice(string id)
    {
        string value = "";
     
            string strsql;
            strsql = @"SELECT * from tbl_invoice where id=@id ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", id);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count > 0) value = dt.Rows[0]["name"].ToString();
        dt.Dispose();
        return value;

    }
    public string Get_ord_pdname(string ord_code)
    {
        string msg = "";
        string strsql = @"SELECT cast(tbl_product.productname AS NVARCHAR) + ','
       FROM tbl_product INNER JOIN order_detail ON tbl_product.p_id = order_detail.p_id
       WHERE order_detail.ord_code = @ord_code
       FOR XML PATH('') ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_code", ord_code);
        DataTable dt = DbControl .Data_Get(strsql, nvc);

        if (dt.Rows.Count > 0) msg = dt.Rows[0][0].ToString();
        return msg;
    }
    public static string Get_ord_code(string ord_date)
    {
        string ord_code = "";

     
            string ord_code1 = DateTime.Parse(ord_date).ToString("yyyyMMdd");
            string ord_code2 = "";


            int secno = 1;
            string strsql;
            strsql = @"SELECT  * FROM Tbl_OrderNo WHERE orddate = CONVERT(VARCHAR(10), getdate(), 111)";
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("orddate", ord_date);
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count == 0)
            {
                ord_code2 = "1";
                strsql = @"insert into  Tbl_OrderNo  (orddate,secno) values (@orddate,@secno) ";

            }
            else
            {
                secno = (int)dt.Rows[0]["secno"] + 1;
                strsql = @"update Tbl_OrderNo  set secno=@secno where orddate=@orddate ";

            }
            dt.Dispose();
            ord_code2 = (secno).ToString().PadLeft(5, '0');
            nvc.Clear();
            nvc.Add("secno", secno.ToString ());
            nvc.Add("orddate", ord_date);
            DbControl.Data_add(strsql, nvc);
            ord_code = ord_code1 + ord_code2;
            return ord_code;
    }
    public static OrderData Get_ordData(string     ord_code)
    {
        OrderData o  = new OrderData();

        DataTable dt = new DataTable();

        string strsql = @"select *  FROM      tbl_OrderData  where ord_code=@ord_code";
        NameValueCollection nvc = new NameValueCollection
        {
            { "ord_code", ord_code }
        };
        dt = DbControl.Data_Get(strsql, nvc);
        o.Ord_code = ord_code;
        o.Ord_id = 0;
        if (dt.Rows.Count > 0)
        {
            o.Ord_id = (int)dt.Rows[0]["ord_id"];

            o.Ordphone = dt.Rows[0]["ordphone"].ToString();
            o.Paymode = dt.Rows[0]["paymode"].ToString();
            o.Status = dt.Rows[0]["status"].ToString();
            o.Orddate = DateTime.Parse(dt.Rows[0]["ord_date"].ToString());
            o.TotalPrice = (int)dt.Rows[0]["TotalPrice"];
            o.Ordname = dt.Rows[0]["ordname"].ToString();
            o.Memberid = dt.Rows[0]["Memberid"].ToString();
            o.Delivery_kind = dt.Rows[0]["delivery_kind"].ToString();
            o.Ordemail = dt.Rows[0]["email"].ToString();
            o.Ordname = dt.Rows[0]["ordname"].ToString();
            o.Shipphone = dt.Rows[0]["shipname"].ToString();
            o.Shipname = dt.Rows[0]["shipphone"].ToString();
            o.Shipaddress = dt.Rows[0]["shipaddress"].ToString();
            o.Title = dt.Rows[0]["title"].ToString();
            o.Companyno = dt.Rows[0]["companyno"].ToString();
            o.Shipzip = dt.Rows[0]["zip"].ToString();
            o.Ordaddress = dt.Rows[0]["ordaddress"].ToString();
            string countyid = dt.Rows[0]["countryid"].ToString();
            strsql = @"select *  FROM    tbl_city  where cityid=@id";
            nvc.Clear();
            nvc.Add("id", dt.Rows[0]["cityid"].ToString());
            dt = DbControl.Data_Get(strsql, nvc);
            //county縣
            ItemData item = new ItemData();
            if (dt.Rows.Count > 0)
            {
                item.Id = (int)dt.Rows[0]["cityid"];
                item.Name = dt.Rows[0]["cityname"].ToString();

            }
            o.Shipcity = item;
            dt.Dispose();
            nvc.Clear();
            if (countyid != "")
            {
                strsql = @"select *  FROM   tbl_county where  countyid=@id";
                nvc.Add("id", countyid);
                dt = DbControl.Data_Get(strsql, nvc);
                item = new ItemData();
                if (dt.Rows.Count > 0)
                {
                    item.Id = (int)dt.Rows[0]["countyid"];
                    item.Name = dt.Rows[0]["countyname"].ToString();

                }
                o.Shipcounty = item;
                dt.Dispose();
            }
            strsql = @"select *  FROM    tbl_OrderDetail INNER JOIN
                            tbl_productData ON tbl_OrderDetail.p_id = tbl_productData.p_id where ord_id=@ord_id";
            nvc.Clear();
            nvc.Add("ord_id", o.Ord_id.ToString());
            dt = DbControl.Data_Get(strsql, nvc);

            List<OrderDetail> detail = new List<OrderDetail>();

            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                detail.Add(new OrderDetail
                {
                    P_id = (int)dt.Rows[0]["p_id"],
                    Num = (int)dt.Rows[0]["num"],
                    Price = (int)dt.Rows[0]["Price"],
                    Amount = (int)dt.Rows[0]["Amount"],
                    Discount = (int)dt.Rows[0]["Discount"],
                    P_name = dt.Rows[0]["productname"].ToString(),
                    Pic= dt.Rows[0]["logo"].ToString()
                });
            }
            TradeInfoLog log = Get_Tradelog(ord_code);
            o.TradeInfoLog = log;
            o.OrderDetail = detail;
        }
        return o;
       
    }
    public static OrderLib.OrderData AddOrdData(OrderLib.OrderData o)
    {
        string strsql = @"insert into tbl_OrderData
            (ord_code, memberid, paymode, invoice,  receivetime, contents,  SubPrice, DeliveryPrice, DiscountPrice, 
                TotalPrice, status,ordname,ordphone,ordaddress,shipname,shipphone,shipaddress,companyno,title
            ,ordgender,shipgender,coupon_no,email,zip,cityid,countryid,delivery_kind,ord_date) values 
                (@ord_code,@memberid, @paymode, @invoice, @receivetime, @contents,@SubPrice, @DeliveryPrice, 
                @DiscountPrice,@TotalPrice, @status,@ordname,@ordphone,@ordaddress,@shipname,@shipphone,@shipaddress
                ,@companyno,@title,@ordgender,@shipgender,@coupon_no,@email,@zip,@cityid,@countryid,@delivery_kind,@ord_date)";

        NameValueCollection nvc = new NameValueCollection
        {
            { "ord_code", o.Ord_code  },
            { "memberid", o.Memberid   },
            { "receivetime", o.ReceiveTime    },
            { "contents", o.Contents    },
            { "SubPrice", o.SubPrice.ToString ()     },
            { "DeliveryPrice", o.ShipPrice .ToString ()    },
            { "DiscountPrice", o.Discount.ToString  ()   },
            { "TotalPrice", o.TotalPrice .ToString ()  },
            { "status", o.Status   },
            { "paymode", o.Paymode    },
            { "invoice", o.Invoice     },
            { "ordname", o.Ordname     },
            { "ordphone", o.Ordphone    },
            { "ordaddress", o.Ordaddress    },
            { "shipname", o.Shipname    },
            { "shipphone", o.Shipphone    },
            { "shipaddress", o.Shipaddress   },
            { "companyno", o.Companyno    },
            { "title", o.Title    },
            { "ordgender", o.Ordgender     },
            { "shipgender", o.Shipgender   },
            { "coupon_no", o.coupon_no    },
            { "email", o.Ordemail     },
            { "zip", o.Ordzip    },
            { "delivery_kind", o.Delivery_kind },
            { "cityid",o. Ordcityid.Id .ToString ()    },
            { "countryid", o.Ordcountyid.Id  .ToString ()    },
            { "ord_date", DateTime.Today.ToShortDateString () }

        };
        int i = DbControl.Data_add(strsql, nvc);
        nvc.Clear();


        strsql = @"select max(ord_id)   from  tbl_orderdata   ";
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        o.Ord_id = (int)dt.Rows[0][0];
        return o;


    }
    public static string Get_pd(string ord_id)
    {
        string msg = "";
      
            string strsql = @"SELECT *    FROM tbl_productdata INNER JOIN orderdetail ON  tbl_productdata.p_id = orderdetail.p_id
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
    public static TradeInfoLog Get_Tradelog(string ord_code)
    {
        TradeInfoLog log = new TradeInfoLog();
        string strsql = @"select *  FROM   TradeInfolog  where ord_code=@ord_code order by secno  ";
        NameValueCollection nvc = new NameValueCollection
        {
            { "ord_code", ord_code }
        };
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        TradeInfoResult result = new TradeInfoResult
        {
            TradeNo = "",
            MerchantOrderNo = "",
            PaymentType = "",
            RespondCode = "",
            Auth = "",
            Card6No = "",
            Card4No = "",
            PayTime = "",
            PaymentMethod = "",
            ExpireDate = "",
            ExpireTime = "",
            BankCode = "",
            CodeNo = "",
            Amt = "",
            Exp = ""

        };
        if (dt.Rows.Count > 0)
        {
            log.Status = dt.Rows[0]["status"].ToString();
            result = new TradeInfoResult
            {
                TradeNo = dt.Rows[0]["TradeNo"].ToString(),
                MerchantOrderNo = dt.Rows[0]["MerchantOrderNo"].ToString(),
                PaymentType = dt.Rows[0]["PaymentType"].ToString(),
                RespondCode = dt.Rows[0]["RespondCode"].ToString(),
                Auth = dt.Rows[0]["Auth"].ToString(),
                Card6No = dt.Rows[0]["Card6No"].ToString(),
                Card4No = dt.Rows[0]["Card4No"].ToString(),
                PayTime = dt.Rows[0]["PayTime"].ToString(),
                PaymentMethod = dt.Rows[0]["PaymentMethod"].ToString(),
                ExpireDate = dt.Rows[0]["ExpireDate"].ToString(),
                ExpireTime = dt.Rows[0]["ExpireTime"].ToString(),
                BankCode = dt.Rows[0]["BankCode"].ToString(),
                CodeNo = dt.Rows[0]["CodeNo"].ToString(),
                Amt = dt.Rows[0]["Amt"].ToString(),
                Exp = dt.Rows[0]["Exp"].ToString()
            };
         
        }
        log.Result = result;
        dt.Dispose();
        return log;
    }
    public class OrderData
    {
        public string Ord_code { get; set; }
        public int Ord_id { get; set; }
        public string Memberid { get; set; }       
        public string Paymode { get; set; }
        public string Invoice { get; set; }     
        public string Contents { get; set; }
        public int SubPrice { get; set; }
        public int ShipPrice { get; set; }
        public int Discount { get; set; }
        public int TotalPrice { get; set; }
        public string Ordname { get; set; }
        public string Ordgender { get; set; }
        public string Ordemail { get; set; }
        public string Ordphone { get; set; }
        public string Ordzip { get; set; }
        public ItemData Ordcountyid { get; set; }
        public ItemData Ordcityid { get; set; }
        public string Ordaddress { get; set; }
        public string Shipname { get; set; }
        public string Shipphone { get; set; }
        public string Shipzip { get; set; }
        public ItemData Shipcounty { get; set; }
        public ItemData Shipcity { get; set; }
        public string Shipaddress { get; set; }
        public string Shipgender { get; set; }
        public string Companyno { get; set; }
        public string Title { get; set; }
        public string Birthday { get; set; }
        public string Delivery_kind { get; set; }
        public string ReceiveTime { get; set; }
        public string Paid { get; set; }
        public string Status { get; set; }
        public List<OrderDetail > OrderDetail { get; set; }
        public DateTime Orddate { get; set; }
        public string  coupon_no { get; set; }
        public TradeInfoLog TradeInfoLog { get; set; }
    }
    public class ItemData
    {
        public int Id { get; set; }
        public string Name   { get; set; }
    }
    public class OrderDetail
    {

        public string  P_name { get; set; }
        public int P_id { get; set; }
        public int Num { get; set; }
        public int Price { get; set; }
        public int Discount { get; set; }
        public int Amount { get; set; }
        public string Pic { get; set; }

    }
    public class TradeInfolog
    {
        public string status { get; set; }
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
    public class Cart : IEquatable<Cart>
    {
        public string p_id { get; set; }
        public int p_num { get; set; }
        public override string ToString()
        {
            return "p_id:" + p_id + "p_num:" + p_num.ToString();
        }

        public bool Equals(Cart other)
        {
            if (other == null) return false;
            return (this.p_id.Equals(other.p_id));
        }
    }

}
