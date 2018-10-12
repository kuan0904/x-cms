using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Drawing;
using System.Drawing.Imaging;
using QR_Encode_Class;

public partial class lib_qr_code : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        QR_Encode qr = new QR_Encode();
        qr.BackColor = Color.White;
        qr.ForeColor = Color.Black;
        int i = qr.EncodeData(1, 0, false, 1, 5, "leokuan@xnet.world", Server.MapPath ("QR_CODE.gif"),false,255,255);
        Bitmap b = qr.GetBMP;
        Response.ContentType = "image/jpeg";
        b.Save(Response.OutputStream, ImageFormat.Gif );
        b.Dispose();
    }
}
