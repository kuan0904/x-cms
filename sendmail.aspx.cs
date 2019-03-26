using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
public partial class sendmailaspx : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string msg = "";
        MailMessage email = new MailMessage();
        SmtpClient sm = new SmtpClient();
  
            string mailtext = "test";
          
            email.To.Add(new MailAddress("leo.kuan@funuv.com"));
            email.From = new MailAddress("leo.kuan@funuv.com", "test");
            email.Subject ="test";
            email.IsBodyHtml = true;
            email.Body = mailtext;

        sm.Host = "smtp.gmail.com";
        sm.Credentials = new System.Net.NetworkCredential("soccer03@yourcs.com", "xnet.world");
        sm.Port = 587;
        sm.EnableSsl = true;
        sm.Send(email);

        msg = "";
        //sm.Host = "www.rollersports.org.tw";
        //           sm.Port = 25;
        //           //  sm.EnableSsl = true;
        //           sm.ServicePoint.MaxIdleTime = 1;
        //           sm.Send(email);

        sm.Dispose();
            email.Dispose();
       
    }
}