using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using QR_Encode_Class;
public partial class member_class_detail : System.Web.UI.Page
{
    public string htmlstr;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["memberdata"] != null)
        {
            MemberLib.Mmemberdata m = (MemberLib.Mmemberdata)Session["memberdata"];
            LessonLib.JoinData o= LessonLib.Web.Get_ord_JoinData (Request.QueryString["ord_code"]);

            string htmldetail = "";
            if (m.Memberid.ToString() == o.OrderData.Memberid )
            {
             
                htmlstr = unity.classlib.GetTextString(Server.MapPath("/templates/Lessondata.html"));
                htmldetail = unity.classlib.GetTextString(Server.MapPath("/templates/classdetail.html"));
                htmlstr = htmlstr.Replace("@subject@", o.LessonData.MainData.Subject);
                htmlstr = htmlstr.Replace("@pic@", o.LessonData.MainData.Pic );
                htmlstr = htmlstr.Replace("@totalprice@", o.OrderData.TotalPrice.ToString ());
                htmlstr = htmlstr.Replace("@classdate@", o.LessonData.StartDay.ToShortDateString() + "~" + o.LessonData.EndDay .ToShortDateString ());
                htmlstr = htmlstr.Replace("@address@", o.LessonData.Address );
                htmlstr = htmlstr.Replace("@ord_code@", o.Ord_code);
                htmlstr = htmlstr.Replace("@DeliveryPrice@", o.OrderData.ShipPrice.ToString () );
                htmlstr = htmlstr.Replace("@ordername@", o.OrderData.Ordname );
                htmlstr = htmlstr.Replace("@ordermail@", o.OrderData.Ordemail);
                htmlstr = htmlstr.Replace("@orderphone@", o.OrderData.Ordphone);
                htmlstr = htmlstr.Replace("@shipname@", o.OrderData.Ordname);
                htmlstr = htmlstr.Replace("@shipphone@", o.OrderData.Ordphone);
                htmlstr = htmlstr.Replace("@shipaddress@", o.OrderData.Ordaddress);
                htmlstr = htmlstr.Replace("@TotalPrice@", "NT$:" + o.OrderData.TotalPrice.ToString());
                htmlstr = htmlstr.Replace("@paymode@", OrderLib.getPaymode(o.OrderData.Paymode));
                htmlstr = htmlstr.Replace("@ShipPrice@", o.OrderData.ShipPrice.ToString());
                htmlstr = htmlstr.Replace("@delivery_kind@", OrderLib.getdelivery_kind(o.OrderData.Delivery_kind));
                htmlstr = htmlstr.Replace("@ticketname@", o.LessonData.MainData.Subject );

                string temp = "";
                string temp1 = "";
                foreach (article.LessonDetail  d in o.LessonData.LessonDetail)
                {

                    var data = o.JoinDetail.FindAll  (y => y.LessonId == d.LessonId);

                   // var data = o.LessonData.LessonDetail.FindAll  (y => y.LessonId == d.LessonId).Sum(c => d.Sellprice );
                  //  var data = o.LessonData.LessonDetail.FindAll.Where(x => x.ID).Sum(c => c.price)
                    if (data != null)
                    {
                        temp1 += temp1=="" ? "<tr><td width = '40%' rowspan = '"+ o.LessonData.LessonDetail .Count  +"'>票券 </td><td>" + d.Description : "<tr><td width = '20%'>" + d.Description ;
                        temp1 += "</td><td width = '20%'> NT$" + d.Sellprice + "</td>";
                        temp1 += "<td width = '20%' class='text-right'>";
                        temp1 += "NT$" + d.Sellprice * data.Count + "</td></tr>";
                    }
                }
                foreach (LessonLib.JoinDetail d in o.JoinDetail)
                {



                    string QrCode = o.Ord_code + "-" + d.JoinId.ToString() + "-" + d.LessonId + "-" + d.Secno;
                    temp += htmldetail;
                    temp = temp.Replace("@secno@", d.Secno .ToString());
                    temp = temp.Replace("@ticketno@", QrCode );
                    temp = temp.Replace("@name@", d.Name .ToString());
                    temp = temp.Replace("@email@", d.Email .ToString());
                    temp = temp.Replace("@phone@", d.Phone.ToString());
                    temp = temp.Replace("@qrcode@", QrCode);
                    
                    QR_Encode qr = new QR_Encode();
                    qr.BackColor = Color.White;
                    qr.ForeColor = Color.Black;
                    int i = qr.EncodeData(1, 0, false, 1, 5, QrCode, Server.MapPath("upload/"+ QrCode  + ".gif"), false, 255, 255);
                    //Bitmap b = qr.GetBMP; //輸出至前端
                    //Response.ContentType = "image/jpeg";
                    //b.Save(Response.OutputStream, ImageFormat.Gif);
                    //b.Dispose();
                }
                htmlstr = htmlstr.Replace("@detail@", temp1);
                htmlstr = htmlstr.Replace("@classdetail@", temp );
            }





        }
    }
}