<%@ WebHandler Language="C#" Class="orderdata" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.Services.Protocols;
using System.Web.Script.Serialization;
using System.Xml.Serialization;
using System.Xml;
using System.IO;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Collections.Specialized;
using unity;
using System.Web.SessionState;
public class orderdata : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest(HttpContext context)
    {
        //測試卡號4000-2211-1111-1111
        string ord_date = DateTime.Today.ToString("yyyy/MM/dd");
        string ord_code =OrderLib.Get_ord_code(ord_date);
        int DeliveryPrice = 180;
        int ship_free = 1600;
        int amount = 0;
        int totalprice = 0;
        string paymode = context.Request ["ord_pay"];
        string receivetime = "";
        string email =  context.Request ["email"];
        string zip = context.Request ["ord_zip"];
        string address =  context.Request ["p_ADDRESS"];
        string cityid =  context.Request ["p_CITYID"];
        string countyid =  context.Request ["p_COUNTYID"];
        string gender =  context.Request ["ord_sex"];
        string username = context.Request ["ord_name"];
        string phone =  context.Request ["ord_tel"];
        string shipzip = context.Request ["ord_zip"];
        string shipaddress = context.Request ["p_ADDRESS"];
        string shipcityid = context.Request ["p_CITYID"];
        string shipcountyid = context.Request ["p_COUNTYID"];
        string shipgender =context.Request ["ord_sex"];
        string shipname = context.Request ["ord_name"];
        string shipphone =context.Request ["ord_tel"];
        string contents = "";
        string invoice = "";
        string companyno = "";
        string title = "";
        int storage = 0;
        string status = "";
        string p_id =  context.Request ["p_id"];
        string pid =  context.Request ["pid"];
        int discountprice = 0;
        string shippingKind = "";
        string  num = context.Request ["num"]   ;
        string  price = context.Request ["price"] ;
        cityid =cityid.Split('-')[0];

        totalprice = 0;
        using (SqlConnection conn = new SqlConnection(unity.classlib.dbConnectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;
            string     strsql = @"select *    from  tbl_productData where   p_id=@p_id ";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("p_id", SqlDbType.VarChar).Value = pid;
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                shippingKind = rs["shippingKind"].ToString();
                DeliveryPrice = (int)rs["shippingfee"];
                storage = (int)rs["storage"];
                if (storage < 1) status = "-1";
            }
            cmd.Dispose();
            rs.Close();
            string memberid = "0";
            if (context.Session["memberdata"] != null)
            {
                MemberLib.Mmemberdata m = (MemberLib.Mmemberdata)context.Session["memberdata"];
                memberid = m.Memberid.ToString ();
            }
            strsql = @"insert into tbl_OrderData
            (ord_code, memberid, paymode, invoice,  receivetime, contents,  SubPrice, DeliveryPrice, DiscountPrice, 
                TotalPrice, status,ordname,ordphone,ordaddress,shipname,shipphone,shipaddress,companyno,title
            ,ordgender,shipgender,coupon_no,email,zip,cityid,countryid,delivery_kind) values 
                (@ord_code,@memberid, @paymode, @invoice, @receivetime, @contents,@SubPrice, @DeliveryPrice, 
                @DiscountPrice,@TotalPrice, @status,@ordname,@ordphone,@ordaddress,@shipname,@shipphone,@shipaddress
                ,@companyno,@title,@ordgender,@shipgender,@coupon_no,@email,@zip,@cityid,@countryid,@delivery_kind)";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@ord_code", SqlDbType.VarChar).Value = ord_code;
            cmd.Parameters.Add("@memberid", SqlDbType.VarChar).Value = memberid;
            cmd.Parameters.Add("@receivetime", SqlDbType.NVarChar).Value = receivetime;
            cmd.Parameters.Add("@contents", SqlDbType.NVarChar).Value = contents;
            cmd.Parameters.Add("@SubPrice", SqlDbType.VarChar).Value = amount ;
            cmd.Parameters.Add("@DeliveryPrice", SqlDbType.VarChar).Value = DeliveryPrice;
            cmd.Parameters.Add("@DiscountPrice", SqlDbType.VarChar).Value = discountprice ;
            cmd.Parameters.Add("@TotalPrice", SqlDbType.VarChar).Value = totalprice;
            cmd.Parameters.Add("@status", SqlDbType.NVarChar).Value = "1";
            cmd.Parameters.Add("@paymode", SqlDbType.VarChar).Value = paymode;
            cmd.Parameters.Add("@invoice", SqlDbType.VarChar).Value = invoice;
            cmd.Parameters.Add("@ordname", SqlDbType.VarChar).Value = username ;
            cmd.Parameters.Add("@ordphone", SqlDbType.VarChar).Value = phone ;
            cmd.Parameters.Add("@ordaddress", SqlDbType.VarChar).Value = address;
            cmd.Parameters.Add("@shipname", SqlDbType.VarChar).Value = shipname;
            cmd.Parameters.Add("@shipphone", SqlDbType.VarChar).Value = shipphone;
            cmd.Parameters.Add("@shipaddress", SqlDbType.VarChar).Value = shipaddress;
            cmd.Parameters.Add("@companyno", SqlDbType.VarChar).Value = companyno;
            cmd.Parameters.Add("@title", SqlDbType.NVarChar ).Value = title;
            cmd.Parameters.Add("@ordgender", SqlDbType.NVarChar).Value = gender;
            cmd.Parameters.Add("@shipgender", SqlDbType.NVarChar).Value = shipgender;
            cmd.Parameters.Add("@coupon_no", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
            cmd.Parameters.Add("@zip", SqlDbType.VarChar).Value = zip ;
            cmd.Parameters.Add("@cityid", SqlDbType.VarChar).Value =cityid ;
            cmd.Parameters.Add("@countryid", SqlDbType.VarChar).Value = countyid ;
            cmd.Parameters.Add("@delivery_kind", SqlDbType.VarChar).Value = shippingKind;
            cmd.ExecuteNonQuery();
            cmd.Dispose();

            string ord_id = "";
            strsql = @"select max(ord_id)   from  tbl_orderdata   ";
            cmd = new SqlCommand(strsql, conn);
            rs = cmd.ExecuteReader();
            if (rs.Read()) ord_id = rs[0].ToString();
            cmd.Dispose();
            rs.Close();

            int i = 0;
            string[] ary_p_id = p_id.Split(';');
            string[] ary_num = num.Split(';');
            for (i = 0; i < ary_p_id.Length; i++)
            {
                p_id = ary_p_id[i];
                num = ary_num[i];
                if (num != "" && num != "0")
                {
                    strsql = @"select *    from  tbl_productData where   p_id=@p_id ";
                    cmd = new SqlCommand(strsql, conn);
                    cmd.Parameters.Add("p_id", SqlDbType.VarChar).Value = p_id;
                    rs = cmd.ExecuteReader();
                    if (rs.Read())
                    {
                        storage = (int)rs["storage"];
                        if (storage < 1) status = "-1";
                        price = rs["price"].ToString();
                        totalprice += int.Parse(price) * int.Parse(num);
                    }
                    cmd.Dispose();
                    rs.Close();

                    strsql = @"insert into tbl_OrderDetail (ord_id, p_id, num,price, amount,ord_code,discount) values 
                        (@ord_id, @p_id, @num, @price, @amount,@ord_code,@discount) ";
                    cmd = new SqlCommand(strsql, conn);
                    cmd.Parameters.Add("@ord_id", SqlDbType.VarChar).Value = ord_id;
                    cmd.Parameters.Add("@ord_code", SqlDbType.VarChar).Value = ord_code;
                    cmd.Parameters.Add("@p_id", SqlDbType.Int).Value = p_id;
                    cmd.Parameters.Add("@num", SqlDbType.Int).Value = num;
                    cmd.Parameters.Add("@price", SqlDbType.Int).Value = price;
                    cmd.Parameters.Add("@amount", SqlDbType.Int).Value = int.Parse(num) * int.Parse(price);
                    cmd.Parameters.Add("@discount", SqlDbType.Int).Value = 0;
                    cmd.ExecuteNonQuery();
                    strsql = @"update tbl_productData set storage = storage - @num where p_id=@p_id";
                    cmd = new SqlCommand(strsql, conn);
                    cmd.Parameters.Add("@p_id", SqlDbType.Int).Value = p_id;
                    cmd.Parameters.Add("@num", SqlDbType.Int).Value = num;
                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                }
            }
            if (totalprice < ship_free)  DeliveryPrice =0;

            strsql = @"update   tbl_orderdata set  TotalPrice =@TotalPrice,SubPrice=@SubPrice, 
            DeliveryPrice=@DeliveryPrice ,ord_date=@ord_date  where  ord_id =@ord_id ";
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("@ord_id", SqlDbType.VarChar).Value = ord_id;
            cmd.Parameters.Add("@TotalPrice", SqlDbType.VarChar).Value =totalprice;
            cmd.Parameters.Add("@SubPrice", SqlDbType.VarChar).Value = totalprice - DeliveryPrice;
            cmd.Parameters.Add("@DeliveryPrice", SqlDbType.VarChar).Value = DeliveryPrice;
            cmd.Parameters.Add("@ord_date", SqlDbType.Date).Value =DateTime.Today.ToString ("yyyy/MM/dd");
            status  = cmd.ExecuteNonQuery().ToString ();
            cmd.Dispose();

            context.Response.Write(status );
            context.Session["ord_code"] =  ord_code  ;
            conn.Close();
            OrderLib.OrderData o = OrderLib.Get_ordData(ord_code);
            string   htmlstr = unity.classlib.GetTextString(System.Web.HttpContext.Current.Server.MapPath("/templates/orderdata.html"));
            htmlstr = htmlstr.Replace("@ord_code@", o.Ord_code);
            htmlstr = htmlstr.Replace("@ordername@", o.Ordname);
            htmlstr = htmlstr.Replace("@ordermail@", o.Ordemail);
            htmlstr = htmlstr.Replace("@orderphone@", o.Ordphone);
            htmlstr = htmlstr.Replace("@shipname@", o.Ordname);
            htmlstr = htmlstr.Replace("@shipphone@", o.Ordphone );
            htmlstr = htmlstr.Replace("@shipaddress@", o.Ordaddress);
            htmlstr = htmlstr.Replace("@TotalPrice@", "NT$:" + o.TotalPrice.ToString ());
            htmlstr = htmlstr.Replace("@paymode@", OrderLib.getPaymode ( o.Paymode) );
            htmlstr = htmlstr.Replace("@ShipPrice@", o.ShipPrice.ToString ());
            htmlstr = htmlstr.Replace("@delivery_kind@", OrderLib.getdelivery_kind (o.Delivery_kind));
            string detailstr = "";
            foreach (var d in o.OrderDetail)
            {
                detailstr += "<tr><td>"+ d.P_name  + "</td><td>" + d.Price.ToString () + "</td><td>" + d.Num .ToString () + "</td><td>"+ d.Amount .ToString () +"</td></tr>";
            }
            htmlstr = htmlstr.Replace("@detail@", detailstr);
            string filename = HttpContext.Current.Server.MapPath("/templates/letter.html");
            string mailbody = unity.classlib.GetTextString(filename);
            mailbody = mailbody.Replace("@title@", "訂單完成通知信");
            mailbody = mailbody.Replace("@mailbody@", htmlstr );
            unity.classlib.SendsmtpMail(email, "訂單完成通知信",  mailbody , "gmail");
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}