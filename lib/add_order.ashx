<%@ WebHandler Language="C#" Class="add_order" %>
using System;
using System.Web;
using unity;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.SessionState;
using System.Collections.Generic;

public class add_order : IHttpHandler,IRequiresSessionState  {
    public void ProcessRequest (HttpContext context) {
        string p_ACTION = context.Request["p_ACTION"];
        string email = context.Request["email"];
        string PASSWD = context.Request["password"];
        string username = context.Request["username"];
        string countyid= context.Request["countyid"];
        string cityid= context.Request["cityid"];
        string zip = context.Request["zip"];
        string address = context.Request["address"];
        string phone = context.Request["phone"];
        string gender = context.Request["gender"];
        string Rusername = context.Request["Rusername"];
        string Rcountyid= context.Request["Rcountyid"];
        string Rcityid= context.Request["Rcityid"];
        string Rzip = context.Request["Rzip"];
        string Raddress = context.Request["Raddress"];
        string Rphone = context.Request["Rphone"];
        string Rgender = context.Request["Rgender"];
        string invoice = context.Request["invoice"];
        string companyno = context.Request["companyno"];
        string title = context.Request["title"];
        string status = "1";
        if (context.Session["receivetime"] == null) status = "0";
        if (context.Session["paymode"] == null) status = "0";
        if (context.Session["contents" ] == null) status = "0";
        if (status == "0")
        {
            context.Response.Write(status);
            context.Response.End();
        }

        //if (email == null) email = "";
        //if (PASSWD == null) PASSWD = "";
        //if (username == null) username = "";
        //if (countyid  == null) countyid = "";
        //if (cityid == null) cityid = "";
        //if (zip == null) zip = "";
        //if (address == null) address = "";
        //if (phone == null) phone = "";
        //if (gender == null) gender = "";
        //if (Rusername == null) Rusername = "";
        //if (Rcountyid  == null) Rcountyid = "";
        //if (Rcityid == null) Rcityid = "";
        //if (Rzip == null) Rzip = "";
        //if (Raddress == null) Raddress = "";
        //if (Rphone == null) Rphone = "";
        //if (Rgender == null) Rgender = "";

        List<orderData > orderData = new List<orderData >();
        orderData.Add (new orderData {
            ordname = username,
            ordemail = email,
            password = PASSWD ,
            ordphone =phone ,
            ordcountyid =countyid ,
            ordcityid =cityid ,
            ordzip=zip ,
            ordaddress =address ,
            ordgender =gender ,
            shipname =Rusername,
            shipcountyid =Rcountyid ,
            shipcityid =Rcityid ,
            shipzip=Rzip ,
            shipphone =Rphone ,
            shipaddress =Raddress ,
            shipgender =Rgender ,
            invoice=invoice,
            receiveTime = context.Session["receivetime"].ToString (),
            paymode = context.Session["paymode"].ToString (),
            contents = context.Session["contents"].ToString (),
            companyno = companyno,
            title =title 
           
        });

        context.Session["orderdata"] = orderData ;
        context.Response.Write(status);
        context.Response.End();

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}