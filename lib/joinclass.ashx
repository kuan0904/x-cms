<%@ WebHandler Language="C#" Class="joinclass" %>
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
public class joinclass : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext c) {
        string Articleid = c.Request["Articleid"];
        string email =  c.Request["email"];
        string phone = c.Request["phone"];
        string name =  c.Request["name"];
        string postion = c.Request["postion"];
        string unitname = c.Request["unitname"];
        string paymode = c.Request["paymode"];
        int  joinnum = 1;
        string TicketKind  = c.Request["TicketKind"];
        string lessonid = c.Request["lessonid"];

        Result Result = new Result();
        article.MainData MainData = new article.MainData();
        MainData = article.DbHandle.Get_article(int.Parse (Articleid));
        if (MainData.Lesson.Id ==  0)
        {
            Result.Id  = "-1";
            Result.Message = "無此課程";
            c.Response.Write( JsonConvert.SerializeObject(Result));
            c.Response.End();

        }
        article.LessonDetail lessondetail = LessonLib.DbHandle.Get_LessonClass(int.Parse(lessonid));
        int hasjoin = LessonLib.Web.CheckJoin(email, lessondetail.LessonId);
        if (hasjoin != 0)
        {
            Result.Id = "-1";
            Result.Message = "已報名參加過";
            c.Response.Write(JsonConvert.SerializeObject(Result));
            c.Response.End();
        }

        List<LessonLib.JoinData> joindata = new List<LessonLib.JoinData>();
        List<article.Lesson> lesson = new List<article.Lesson>();


        MemberLib.Mmemberdata result = MemberLib.Member.Check_exist(email);
        if (result.Memberid != 0)
        {
            c.Session["memberdata"] = MemberLib.Member.GetData (result.Memberid.ToString ());
        }
        else
        {
            c.Session["memberdata"] = MemberLib.Member.Add(email, phone, email,name,phone);

        }
        MemberLib.Mmemberdata m = (MemberLib.Mmemberdata)c.Session["memberdata"];

        string ord_date = DateTime.Today.ToString("yyyy/MM/dd");
        string ord_code = OrderLib.Get_ord_code(ord_date);
        int ship_free = 0;
        int totalprice = lessondetail.Price ;

        OrderLib.OrderData o = new OrderLib.OrderData
        {
            Ord_code = ord_code ,
            Ord_id = 0,
            Memberid =m.Memberid .ToString () ,
            Paymode = paymode,
            Invoice="",
            Contents="",
            ShipPrice= ship_free,
            Discount = 0,
            TotalPrice=totalprice ,
            Delivery_kind="",
            Orddate =DateTime.Today ,
            Companyno="",
            Title="",
            ReceiveTime="",
            coupon_no="",
            Paid="",
            Status="1",
            SubPrice=totalprice,
            Ordname= name,
            Ordgender="",
            Ordemail=email ,
            Ordphone = phone,
            Ordzip="",
            Ordaddress="",
            Shipname="",
            Shipphone="",
            Shipzip="",
            Shipaddress ="",
            Shipgender="",
            Ordcityid = new OrderLib.ItemData() { Id=0,Name=""},
            Ordcountyid  = new OrderLib.ItemData() { Id = 0, Name = "" },
            Shipcity = new OrderLib.ItemData() { Id = 0, Name = "" },
            Shipcounty = new OrderLib.ItemData() { Id = 0, Name = "" },
        };
        o = OrderLib.AddOrdData (o);
        List<LessonLib.JoinDetail> item = new List<LessonLib.JoinDetail>();
        item.Add(new LessonLib.JoinDetail
        {
            LessonId = lessondetail.LessonId ,
            Name = name,
            Phone = phone,
            Email = email,
            Postion =postion,
            Unitname=unitname,
            Amount = lessondetail.Price

        });
        LessonLib.JoinData jdata = new LessonLib.JoinData
        {
            Ord_code =ord_code ,
            Articleid = MainData.Id,
            TicketKind = TicketKind,
            JoinDetail = item
        };



        LessonLib.DbHandle.JoinAdd(jdata);
        c.Session["ord_code"] = ord_code;
        //string site_name = HttpContext.Current.Application["site_name"].ToString();
        //string filename = HttpContext.Current.Server.MapPath("/templates/letter.html");
        //string mailbody = unity.classlib.GetTextString(filename);
        jdata = LessonLib.Web.Get_ord_JoinData(ord_code);
        Result.Id  = "0";
        Result.Message = "報名成功";
        c.Response.Write( JsonConvert.SerializeObject(Result));
    }


    public bool IsReusable {
        get {
            return false;
        }
    }
    public class Result
    {
        public string Id { get; set; }
        public string Message { get; set; }
    }
}