using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using QR_Encode_Class;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Collections.Specialized;
using System.Web.Services;
public partial class spadmin_LessonList : System.Web.UI.Page
{
   public  string html = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userid"] == null || Session["Backmenu"] == null || Session["Backmenu"].ToString() == "")
        {
            Response.Redirect("~/account/login.aspx?ReturnUrl=" + Request.RawUrl.ToString());
            Response.End();
        }
        string articleid = Request.QueryString["articleid"];
        string strsql = @"select *  FROM        tbl_Joindata  where articleid=@articleid";
        NameValueCollection nvc = new NameValueCollection
            {
                { "articleid", articleid }
            };
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        List<LessonLib.JoinData> JoinData = new List<LessonLib.JoinData>();
        foreach (DataRow dr in dt.Rows )
        {
            LessonLib.JoinData j = LessonLib.Web.Get_ord_JoinData(dr["ord_code"].ToString());
            JoinData.Add(j);
          

        }
        dt.Dispose();
        int i =0;
        int total = 0;
        foreach (LessonLib.JoinData j in JoinData)
        {
          
            foreach (LessonLib.JoinDetail d in j.JoinDetail)
            {
                var data = j.LessonData.LessonDetail .Find(y => y.LessonId == d.LessonId);
                string qr = j.Ord_code + "-" + d.JoinId + "-" + d.LessonId  ;
                total++;
                html += "<tr>";
                html += "<td>";
                html += "<button type=\"button\"class=\"btn btn-primary\"  data-ord_code=\"" + j.Ord_code + "\" data-toggle=\"modal\" data-target=\"#exampleModal\">";
                html +=  j.Ord_code + "</button></td>";
                html += "<td>" +  OrderLib.getPaymode ( j.OrderData.Paymode) + "</td>";
                html += "<td>" + OrderLib.get_ord_status(j.OrderData.Status) + "</td>";
                html += "<td>" + d.Name  + "</td>";
                html += "<td>" + d.Email + "</td>";
                html += "<td>" + d.Phone  + "</td>";
                html += "<td>" + d.Unitname + "</td>";
                html += "<td>" + d.Postion + "</td>";       
                html += "<td>" + d.checkin  + "</td>";
                html += "</tr>" + "\r\n" ; 
                if (d.checkin == "Y") i++;

                //string QrCode = j.Ord_code + "-" + d.JoinId.ToString() + "-" + d.LessonId;
                //string url = "http://www.culturelaunch.net/lib/checkjoin.aspx?code=" + QrCode;


                //QR_Encode qr = new QR_Encode
                //{
                //    BackColor = Color.White,
                //    ForeColor = Color.Black
                //};
                //qr.EncodeData(1, 0, true, -1, 5, url, HttpContext.Current.Server.MapPath("/upload/" + QrCode + ".gif"), false, 255, 255);

            }

        }
        //html += "<Tr><td></td><td>總報名人數</td><td>" + total + "</td>";
        //html += "<td>已報到人數</td><td>" + i + "</td>";
        //html += "<td><a href=\"javascript:window.print();\">列印</a></td><td></td><td></td><td></td></tr>";
        ////html += "</table>";

        JoinData = null;
    }

    [WebMethod]
    public static string get_orddata(string ord_code)
    {
        string result = "";
        LessonLib.JoinData o = LessonLib.Web.Get_ord_JoinData(ord_code);

        result = LessonLib.Web.Get_JoinData(ord_code);

        return (result);

    }
}