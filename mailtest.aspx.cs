using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
public partial class mailtest : System.Web.UI.Page
{
    private static string delivername = "test";
    private static string servicemail = "event@xnet.world";
    private static string smtpuid = "event@xnet.world";
    private static string smtppwd = "5505361323222635";
    protected void Page_Load(object sender, EventArgs e)
    {
        string SendTomail = "leokuan@xnet.world";
        string subject = "test";
        string msg = "";
        MailMessage email = new MailMessage();
        SmtpClient sm = new SmtpClient();

        string mailtext = "test";
      
            SendTomail = SendTomail.Replace("\r\n", "").Replace("\r", "").Replace("\n", "");

            email.To.Add(new MailAddress(SendTomail));
            email.From = new MailAddress(servicemail, delivername);
            email.Subject = subject;
            email.IsBodyHtml = true;
            email.Body = mailtext;


            //     if (host != ""){
            sm.Host = "smtp.gmail.com";
            sm.Credentials = new System.Net.NetworkCredential(smtpuid, smtppwd);

            sm.Port = 587;
            sm.EnableSsl = true;
            //                 }


            //else    
            //{ 
            //    sm.Host = "localhost";
            //    sm.Credentials = new System.Net.NetworkCredential(smtpuid, smtppwd);
            //}
            sm.ServicePoint.MaxIdleTime = 1;
            sm.Send(email);

            msg = "";
     
        
    }
}