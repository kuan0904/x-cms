<%@ WebHandler Language="C#" Class="addcars" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using unity;


public class addcars : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        string p_PRODUCTID =context.Request["p_ID"];
        string p_ACTION =context.Request["p_ACTION"];
        string p_kind =context.Request["kind"];
        string check = context.Request["_"];
        string status = "";
        string p_pic = "";
        int storage = 0;
        int p_num = 1;
        if (p_PRODUCTID == null)
        {
            context.Response.Write("0");
            context.Response.End();
        }
        if ( context.Request["p_num"] != null) p_num = int.Parse (context.Request["p_num"]);
        string p_productname = "";
        int p_price = 0;
        int p_ID = int.Parse(p_PRODUCTID);
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            conn.Open();
            string strsql = "SELECT * FROM   productData  WHERE p_id = @p_id  ";
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;

            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("p_id", SqlDbType.Int).Value = p_ID;
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                storage = (int)rs["storage"];
                p_price = (int)rs["price"];
                p_productname = rs["productname"].ToString();
                if (storage <= 0 || p_num > storage)
                {
                    status = storage.ToString();
                }
                if (rs["status"].ToString() != "Y") status = "-3";
                p_pic = rs["pic1"].ToString();
            }
            cmd.Dispose();
            rs.Close();
            //數量變動重新計算
            p_price =classlib.get_price(p_ID,p_num );
            //數量變動重新計算結束
            if (status != "")
            {
                context.Response.Write(status);
                context.Response.End();
            }

            List<ShoppingList> ShoppingList = new List<ShoppingList>();
            if (context.Session["ShoppingList"] == null || context.Session["ShoppingList"].ToString() == "")
            {
                ShoppingList.Add(new ShoppingList {
                    p_id = p_PRODUCTID,
                    num = p_num,
                    price = p_price,
                    productname = p_productname,
                    pic = p_pic,
                    amount = p_price * p_num
                });
            }
            else
            {

                ShoppingList = context.Session["ShoppingList"] as List<ShoppingList>; // get data from session.
                if (ShoppingList == null)
                {
                    ShoppingList = new List<ShoppingList>();
                    ShoppingList.Add(new ShoppingList {
                        p_id = p_PRODUCTID,
                        num = p_num,
                        price = p_price,
                        productname = p_productname,
                        pic = p_pic,
                        amount = p_price * p_num
                    });
                }
                else if (ShoppingList.Exists(x => x.p_id == p_PRODUCTID) == true)
                {
                    var s = ShoppingList.Find(p => p.p_id == p_PRODUCTID);
                    if (p_kind == "add")
                        s.num = s.num + p_num;
                    else
                        s.num = p_num;
                    //數量變動重新計算
                    s.price =   p_price =classlib.get_price(p_ID, s.num );
                    s.amount = s.price * s.num;

                }
                else
                {
                    ShoppingList.Add(new ShoppingList {
                        p_id = p_PRODUCTID,
                        num = p_num,
                        price = p_price,
                        productname = p_productname,
                        pic = p_pic,
                        amount = p_price * p_num
                    });
                }

                //    foreach (ShoppingList idx in ShoppingList)
                //    {
                //        if (idx.p_id == "30" || idx.p_id == "31" || idx.p_id == "30" || idx.p_id == "33" || idx.p_id == "34" || idx.p_id == "35")
                //        {
                //            p_PRODUCTID = "44";
                //            if (ShoppingList.Exists(x => x.p_id == p_PRODUCTID) == true)
                //            {
                //                var s = ShoppingList.Find(p => p.p_id == p_PRODUCTID);
                //                s.num = 1;
                //                //數量變動重新計算
                //                s.price =   0;
                //                s.amount = 0;

                //            }
                //            else
                //            {
                //                ShoppingList.Add(new ShoppingList {
                //                    p_id = p_PRODUCTID,
                //                    num = 1,
                //                    price = 0,
                //                    productname = p_productname,
                //                    pic = p_pic,
                //                    amount = 0
                //            });
                //        }
                //    }

                //}



            }

            if (p_num == 0)   // ShoppingList.Remove(new ShoppingList { p_id = p_PRODUCTID });
            {
                var itemToRemove = (ShoppingList.Find(x => x.num  == 0));
                ShoppingList.Remove(itemToRemove);
            }


            context.Session["ShoppingList"] = ShoppingList;
            context.Response.Write(status);
            conn.Close();
            context.Response.End();

        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}