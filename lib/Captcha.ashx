<%@ WebHandler Language="C#" Class="Captcha" %>
using System;
using System.Web;
using System.Drawing;
using System.Web.SessionState;


public class Captcha : IHttpHandler, System.Web.SessionState.IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        //設定ContentType為影像
        context.Response.ContentType = "image/jpeg";
        //清除輸出內容
        context.Response.Clear();
        //設定處理後一併輸出
        context.Response.BufferOutput = true;

        //建立隨機數字
        int RandNumber = new Random((int)DateTime.Now.Ticks).Next(99999);
        string RandString = RandNumber.ToString("00000");

        //Session存入驗證碼
        context.Session["CAPTCHA"] = RandString;

        int CaptchaWidth = 100;       //驗證圖形寬度
        int CaptchaHeight = 30;      //驗證圖形高度

        //建立驗證圖形
        Bitmap bitmap = new Bitmap(CaptchaWidth, CaptchaHeight);
        //設定繪圖介面
        Graphics graphics = Graphics.FromImage(bitmap);
        //設定驗證碼字型
        Font stringFont = new Font("Arial", 14, System.Drawing.FontStyle.Bold);
        //設定驗證圖形背景顏色
        graphics.Clear(Color.White);
        //繪製驗證碼
        graphics.DrawString(RandString, stringFont, Brushes.Red , 20, 5);
        //亂數產生200個雜點
        Random random = new Random((int)DateTime.Now.Ticks);
        for (int i = 0; i < 100; i++)            //，擾亂機器人辨別
        {
            int RandPixelX = random.Next(0, CaptchaWidth);
            int RandPixelY = random.Next(0, CaptchaHeight);
            bitmap.SetPixel(RandPixelX, RandPixelY, Color.Black);
        }
        //輸出驗證圖形
        bitmap.Save(context.Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
        stringFont.Dispose();
        graphics.Dispose();
        bitmap.Dispose();

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}