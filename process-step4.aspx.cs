using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using QR_Encode_Class;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;
public partial class process_step4 : System.Web.UI.Page
{
    public string htmlstr;
    protected void Page_Load(object sender, EventArgs e)
    {

        string ord_code = Session["ord_code"].ToString(); 
        string site_name = HttpContext.Current.Application["site_name"].ToString();
        string filename = HttpContext.Current.Server.MapPath("/templates/letter.html");
        string mailbody = unity.classlib.GetTextString(filename);
        LessonLib.JoinData jdata = LessonLib.Web.Get_ord_JoinData(ord_code);
        DataTable dt = unity.classlib.Get_Message(8);

        
     ;
        jdata = LessonLib.Web.Get_ord_JoinData(ord_code);


        site_name = HttpContext.Current.Application["site_name"].ToString();
        mailbody = dt.Rows[0]["contents"].ToString().Replace("@site_name@", site_name);
        string mailsubject = "【" + site_name + "】" + dt.Rows[0]["title"].ToString();
        mailbody = mailbody.Replace("@name@",jdata.JoinDetail[0].Name  );
        mailbody = mailbody.Replace("@classname@", jdata.LessonData.MainData.Subject);
        mailbody = mailbody.Replace("@starttime@", jdata.LessonData.StartDay.ToShortDateString() 
            + "~" + jdata.LessonData.EndDay.ToShortDateString()  
            + "   " +  jdata.LessonData.MainData.Lesson.Lessontime);
        mailbody = mailbody.Replace("@address@", jdata.LessonData.Address);
        mailbody = mailbody.Replace("@price@", jdata.OrderData.TotalPrice.ToString());
        mailbody = mailbody.Replace("@orderno@", jdata.Ord_code );
        foreach (LessonLib.JoinDetail d in jdata.JoinDetail)
        {
            string QrCode = ord_code + "-" + d.JoinId.ToString() + "-" + d.LessonId ;
            mailbody = mailbody.Replace("@ticketno@",QrCode );
        }

        string msg = unity.classlib.SendsmtpMail(jdata.JoinDetail[0].Email , mailsubject, mailbody, "gmail");
          
        htmlstr = LessonLib.Web.Get_JoinData(ord_code );

        
    }

   
}