using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Collections.Generic;




public partial class resizepic : System.Web.UI.Page
{

    protected void Page_Load(object sender, System.EventArgs e)
    {
        string sourcepic = Request["sourcepic"] ?? "";
        int  PicWidth = Request["picwidth"] ==null ? 0:int.Parse (Request["picwidth"]);
        int PicHeight = Request["picheight"] == null ? 0 : int.Parse(Request["picheight"]);
        string state = Request["state"] ?? "" ;
        float rat1 = 1;
        float rat2 = 1;
        WebClient webC = new WebClient();
        if ((sourcepic != "" ))
        {
            sourcepic = sourcepic.Trim ();
            System.Drawing.Image originalImage;          
            
            if ((sourcepic.IndexOf("http") < 0))
            {
                originalImage = System.Drawing.Image.FromStream(webC.OpenRead(Server.MapPath(sourcepic)));
            }
            else
            {
                originalImage = System.Drawing.Image.FromStream(webC.OpenRead(sourcepic));
            }

            int width;
            int height;
            if (((PicWidth < originalImage.Width)
                        || (originalImage.Height > PicHeight)))
            {
                if ((PicWidth != 0))
                {
                    rat1 = (originalImage.Width / PicWidth);
                }

                if ((PicHeight != 0))
                {
                    rat2 = (originalImage.Height / PicHeight);
                }

                if ((rat1 > rat2))
                {
                    rat2 = rat1;
                }

                if ((rat2 > rat1))
                {
                    rat1 = rat2;
                }

                width = (int) (originalImage.Width / rat1);
                height = (int)(originalImage.Height / rat2);
            }
            else
            {
                width = originalImage.Width;
                height = originalImage.Height;
            }

            System.Drawing.Image webpic = new System.Drawing.Bitmap(width, height);
            Graphics g = System.Drawing.Graphics.FromImage(webpic);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            g.Clear(Color.Transparent);
            int x = 0;
            int y = 0;
            int ow = originalImage.Width;
            int oh = originalImage.Height;
            g.DrawImage(originalImage, new Rectangle(0, 0, width, height), new Rectangle(x, y, ow, oh), GraphicsUnit.Pixel);
            if (state != ""  )
            {
            
                Bitmap pic2 = new Bitmap(webC.OpenRead(Server.MapPath(("image/icon_state_"
                                        + (state + ".gif")))));
                Graphics DrawGraphic = Graphics.FromImage(webpic);
                DrawGraphic.DrawImage(pic2, 1, 1);
                pic2.Dispose();
            }

            webpic.Save(Response.OutputStream, ImageFormat.Jpeg);
            //   pic.Dispose()
            webpic.Dispose();
            webC.Dispose();
            g.Dispose();
            originalImage.Dispose();
        }

    }
}