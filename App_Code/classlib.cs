using System;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Net.Mail;
using System.IO;
using System.Net;
using System.Drawing;
using System.Data;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Text;
using System.Drawing.Imaging;
using System.Collections.Specialized;
/// <summary>
/// classlib 的摘要描述
/// C# 字串變數, 如何包含雙引號或反斜線
//如果字串裡包括特殊符號,例如換行符號,雙引號等,可以用\,例如\" 表示雙引號
//如果字串裡包括特殊符號, 例如換行符號, 雙引號等, 可以用\,例如\" 表示雙引號
//string a = "abc\"dd"; //以 \" 表示雙引號
//string b = "C:\\Program Files\\";  //以 \\ 表示反斜線
//若在字串前加@,會比較方便撰寫,範例如下
//string d = @"C:\Program Files\"; //加了@, 只需要寫一個反斜線即可,會比較簡單
//string e = @"""C:\Program Files\"""; //加了@, 用"" 二個雙引號來表示一個雙引號

/// </summary>
/// 
namespace unity {
    public static class MyImage
    {
        public static Bitmap RotateImage(System.Drawing.Image img) //相片橫拍轉正
        {

            var exif = img.PropertyItems;
            byte orien = 0;
            var item = exif.Where(m => m.Id == 274).ToArray();
            if (item.Length > 0)
                orien = item[0].Value[0];
            switch (orien)
            {
                case 2:
                    img.RotateFlip(RotateFlipType.RotateNoneFlipX);//horizontal flip
                    break;
                case 3:
                    img.RotateFlip(RotateFlipType.Rotate180FlipNone);//right-top
                    break;
                case 4:
                    img.RotateFlip(RotateFlipType.RotateNoneFlipY);//vertical flip
                    break;
                case 5:
                    img.RotateFlip(RotateFlipType.Rotate90FlipX);
                    break;
                case 6:
                    img.RotateFlip(RotateFlipType.Rotate90FlipNone);//right-top
                    break;
                case 7:
                    img.RotateFlip(RotateFlipType.Rotate270FlipX);
                    break;
                case 8:
                    img.RotateFlip(RotateFlipType.Rotate270FlipNone);//left-bottom
                    break;
                default:
                    break;
            }
            return (Bitmap)img;
        }

        //等比縮圖、(裁圖範圍置中)
        public static Bitmap Image_ChangeOpacity(Image img, float opacityvalue)
        {
            Bitmap bmp = new Bitmap(img.Width, img.Height);
            Graphics graphics = Graphics.FromImage(bmp);
            ColorMatrix colormatrix = new ColorMatrix();
            colormatrix.Matrix33 = opacityvalue;
            ImageAttributes imgAttribute = new ImageAttributes();
            imgAttribute.SetColorMatrix(colormatrix, ColorMatrixFlag.Default, ColorAdjustType.Bitmap);
            graphics.DrawImage(img, new Rectangle(0, 0, bmp.Width, bmp.Height), 0, 0, img.Width, img.Height, GraphicsUnit.Pixel, imgAttribute);
            graphics.Dispose();
            return bmp;
        }
        public static System.Drawing.Image ZoomImage(System.Drawing.Image bitmap, int destWidth, int destHeight)
        { //等比縮放
            try
            {
                System.Drawing.Image sourImage = bitmap;
                bitmap = RotateImage(bitmap);
                int width = 0, height = 0;
                //按比例縮放         
                int sourWidth = sourImage.Width;
                int sourHeight = sourImage.Height;
                if (sourHeight > destHeight || sourWidth > destWidth)
                {
                    if ((sourWidth * destHeight) > (sourHeight * destWidth))
                    {
                        width = destWidth;
                        height = (destWidth * sourHeight) / sourWidth;
                    }
                    else
                    {
                        height = destHeight;
                        width = (sourWidth * destHeight) / sourHeight;
                    }
                }
                else
                {
                    width = sourWidth;
                    height = sourHeight;
                }
                Bitmap destBitmap = new Bitmap(destWidth, destHeight);
                Graphics g = Graphics.FromImage(destBitmap);
                g.Clear(Color.Transparent);
                //設置畫布的描繪品質   
                // webpic = Image_ChangeOpacity(webpic, 0f);  
                g.Clear(Color.Transparent);
                // g.Clear(Color.Black);
                g.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                g.DrawImage(sourImage, new Rectangle((destWidth - width) / 2, (destHeight - height) / 2, width, height), 0, 0, sourImage.Width, sourImage.Height, GraphicsUnit.Pixel);
                //高度置中
                //g.DrawImage(sourImage, new Rectangle((destWidth - width) / 2, (destHeight - height), width, height), 0, 0, sourImage.Width, sourImage.Height, GraphicsUnit.Pixel);
                //齊底
                g.Dispose();
                //設置壓縮品質     
                System.Drawing.Imaging.EncoderParameters encoderParams = new System.Drawing.Imaging.EncoderParameters();
                long[] quality = new long[1];
                quality[0] = 100;
                System.Drawing.Imaging.EncoderParameter encoderParam = new System.Drawing.Imaging.EncoderParameter(System.Drawing.Imaging.Encoder.Quality, quality);
                encoderParams.Param[0] = encoderParam;
                sourImage.Dispose();
                return destBitmap;
            }
            catch
            {
                return bitmap;
            }
        }

        public static void ResizeImg(int destWidth, int destHeight, string filePath, string saveFilePath)
        { //重新設定大小

            System.Drawing.Image sourImage;
            WebClient webC = new WebClient();
            sourImage = System.Drawing.Image.FromStream(webC.OpenRead(filePath));
            sourImage = RotateImage(sourImage);
            webC.Dispose();
            webC = null;

            int width = 0, height = 0;
            //按比例縮放         
            int sourWidth = sourImage.Width;
            int sourHeight = sourImage.Height;
            if (sourHeight > destHeight || sourWidth > destWidth)
            {
                if ((sourWidth * destHeight) > (sourHeight * destWidth))
                {
                    width = destWidth;
                    height = (destWidth * sourHeight) / sourWidth;
                }
                else
                {
                    height = destHeight;
                    width = (sourWidth * destHeight) / sourHeight;
                }

            }
            else
            {
                width = sourWidth;
                height = sourHeight;

            }

            Bitmap destBitmap = new Bitmap(width, height);
            Graphics g = Graphics.FromImage(destBitmap);
            g.Clear(Color.Transparent);
            //設置畫布的描繪品質                
            // g.Clear(Color.Transparent);
            g.Clear(Color.Black);
            g.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            g.DrawImage(sourImage, new Rectangle(0, 0, width, height), new Rectangle(0, 0, sourWidth, sourHeight), GraphicsUnit.Pixel);
            g.Dispose();
            //設置壓縮品質     
            System.Drawing.Imaging.EncoderParameters encoderParams = new System.Drawing.Imaging.EncoderParameters();
            long[] quality = new long[1];
            quality[0] = 100;
            System.Drawing.Imaging.EncoderParameter encoderParam = new System.Drawing.Imaging.EncoderParameter(System.Drawing.Imaging.Encoder.Quality, quality);
            encoderParams.Param[0] = encoderParam;
            sourImage.Dispose();
            sourImage = null;
            destBitmap.Save(saveFilePath, System.Drawing.Imaging.ImageFormat.Jpeg);
            destBitmap.Dispose();
            destBitmap = null;
        }
        //指定裁圖範圍、縮圖
        public static void CutImg(int PointX, int PointY, int CutWidth, int CutHeight, int picWidth, int picHeight, string filePath, string saveFilePath)
        {
            //PointX PointY: 起點   CutWidth CutHeight: 裁圖長寬  PicWidth PicHeight: 縮圖長寬


            //只裁圖
            if (picWidth == 0)
            {
                picHeight = CutHeight;
                picWidth = CutWidth;
            }

            FileStream sFileStream = File.OpenRead(filePath);



            System.Drawing.Image imgPhoto = null;
            imgPhoto = System.Drawing.Image.FromStream(sFileStream);
            System.Drawing.Image bmPhoto = new System.Drawing.Bitmap(picWidth, picHeight);
            Graphics gbmPhoto = System.Drawing.Graphics.FromImage(bmPhoto);

            gbmPhoto.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            gbmPhoto.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            gbmPhoto.Clear(Color.Transparent);


            gbmPhoto.DrawImage(imgPhoto, new Rectangle(0, 0, picWidth, picHeight), new Rectangle(PointX, PointY, CutWidth, CutHeight), GraphicsUnit.Pixel);
            bmPhoto.Save(saveFilePath, System.Drawing.Imaging.ImageFormat.Jpeg);
            sFileStream.Close();
            gbmPhoto.Dispose();
            bmPhoto.Dispose();
            imgPhoto.Dispose();
            sFileStream.Dispose();

        }



    }


    public static class classlib
    {
        public static string dbConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["dbconnConnection"].ConnectionString;
        private static string delivername = "創藝時代";
        private static string servicemail = "event@xnet.world";
        private static string smtpuid = "event@xnet.world";
        private static string smtppwd = "5505361323222635";
        public class MsgResult
        {
            public string Id { get; set; }
            public string Msg { get; set; }
        }

        public class Log_Sms
        {
            public string Msgid { get; set; }
            public string Statuscode { get; set; }
            public string AccountPoint { get; set; }
            public string Dstanumber { get; set; }
            public string Smsbody { get; set; }
            public string Ord_code { get; set; }
        }


        public static Log_Sms Sendsms(string dstanumber, string smsbody)
        {
            string result = "";
            Log_Sms log  = new Log_Sms();
            Encoding myenc = Encoding.GetEncoding("big5");
            string smsurl =
            string.Format(@"http://smexpress.mitake.com.tw:9600/SmSendGet.asp?username=55053613&password=xnet2635&dstaddr={0}&smbody={1}&response=http://192.168.1.200/smreply.asp"
            , dstanumber, HttpUtility.UrlEncode(classlib.RemoveHTMLTag(smsbody), myenc));
            HttpWebRequest req = (HttpWebRequest)HttpWebRequest.Create(smsurl);
            req.Method = "GET";
            using (WebResponse wr = req.GetResponse())
            {
                using (StreamReader sr = new StreamReader(wr.GetResponseStream(), myenc))
                {
                    result =sr.ReadToEnd();
                }
            }
            string[] stringSeparators = new string[] { "\r\n" };
            string[] msg = result.Split(stringSeparators, StringSplitOptions.None);
            string strsql = @"insert into log_sms (msgid,statuscode,AccountPoint,dstanumber,smsbody)
                values (@msgid,@statuscode,@AccountPoint,@dstanumber,@smsbody) ";
            NameValueCollection nvc = new NameValueCollection();
            log.Msgid = msg[1].Replace("msgid=", "");
            log.Statuscode = msg[2].Replace("statuscode=", "");
            log.AccountPoint = msg[3].Replace("AccountPoint=", "");
            log.Dstanumber = dstanumber;
            log.Smsbody = classlib.RemoveHTMLTag(smsbody);
            
            nvc.Add("msgid", log.Msgid);
            nvc.Add("statuscode", log.Statuscode );
            nvc.Add("AccountPoint", log.AccountPoint );
            nvc.Add("dstanumber", dstanumber);
            nvc.Add("smsbody", log.Smsbody);
            DbControl.Data_add(strsql, nvc);
           
            return log;
        }



        public static string SubString (string str,int length,string kind)
        {
          if (kind == "notag") str = noHTML(str);
            str = str.Trim();
            if (str.Length > length)
            {
                str = str.Substring(0, length);
            }
            return str;
        }

        public static string GetIPAddress(HttpRequest rr)
        {
           
            string myip = "";
            string sIPAddress = rr.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (string.IsNullOrEmpty(sIPAddress))
            {
                myip = rr.ServerVariables["REMOTE_ADDR"];
            }
            else {
                string[] ipArray = sIPAddress.Split(new Char[] { ',' });
                myip = ipArray[0];
            }                       
            return myip;
        }
        public static string getUrlPath(string urlpath)
        {
            urlpath = urlpath.Substring(0, urlpath.LastIndexOf("/"));
            if (urlpath.LastIndexOf("/") > 0)
            {
                urlpath = urlpath.Substring(0, urlpath.LastIndexOf("/"));
            }
            return urlpath;
        }

        public static string getIP(HttpRequest rr)
        {

            // 取得本機名稱
            string strHostName = Dns.GetHostName();
            // 取得本機的IpHostEntry類別實體，用這個會提示已過時
            //IPHostEntry iphostentry = Dns.GetHostByName(strHostName);

            // 取得本機的IpHostEntry類別實體，MSDN建議新的用法
            IPHostEntry iphostentry = Dns.GetHostEntry(strHostName);

            // 取得所有 IP 位址
            foreach (IPAddress ipaddress in iphostentry.AddressList)
            {
                // 只取得IP V4的Address
                if (ipaddress.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
                {
                    return ipaddress.ToString();
                }
            }
            return strHostName;
        }


        public static string GetTextString(string filename,string kind="1")
        {
            string value = "";

            StreamReader MySF = new StreamReader(filename, System.Text.Encoding.UTF8);
            if (kind == "1") {
                value = MySF.ReadToEnd(); //  '讀取全部會包含換行符號
                    }
            else {
                while (!MySF.EndOfStream)
                {
                    value += MySF.ReadLine();
                    //讀取單行
                }
            }
            MySF.Dispose();
            MySF.Close();

            return value;
        }
        public static string GetImgNmae(string filename)
        {
            if (filename.LastIndexOf("/") >= 0)
            {
                filename = filename.Substring(filename.LastIndexOf("/") + 1, filename.Length - filename.LastIndexOf("/") - 1);
                if (filename.IndexOf("&") >= 0)
                {
                    filename = filename.Substring(0, filename.IndexOf("&"));
                }
            }
            return filename;
        }
        //副檔名
        public static string GetFileExt(string PathName)
        {
            string functionReturnValue = null;
            int Index = PathName.LastIndexOf(".");
            if ((Index > 0))
            {
                int Len = PathName.Length;
                functionReturnValue = PathName.Substring(Index, Len - Index);
                return functionReturnValue;
            }
            functionReturnValue = "";
            return functionReturnValue;
        }
        //檔名+亂碼
        public static string FileRename(string str)
        {
            string fileext = GetFileExt(str);
            //副檔名
            int oldindex = -1;
            //已重新命名過

            if (!string.IsNullOrEmpty(fileext))
            {
                oldindex = str.IndexOf("-" + fileext.Substring(1) + "-");
                //已重新命名過
            }

            if (oldindex > 0)
            {
                str = str.Substring(0, oldindex + fileext.Length);
            }

            return RemoveBadSymbol(str.Replace(".", "-")) + "-" + DateTime.Now.ToString("yMdHmsf") + fileext;

            //fileext = GetFileExt(FileUpload_main.FileName)
            //imgMain = Guid.NewGuid.ToString.ToUpper & fileext 
        }
        public static string FieldToString(object inField)
        {
            string functionReturnValue = null;
            if ((inField == null) || Convert.IsDBNull(inField))
            {
                functionReturnValue = "";
            }
            else {
                functionReturnValue = inField.ToString().Trim();
            }
            return functionReturnValue;
        }               
        public static string RemoveBadSymbol(string inputtext, string level = "10")
        {
            string r = Regex.Replace(inputtext, @"[\W_]+", "");
            string pStr = "";
            if ((inputtext != null))
            {
                pStr = inputtext;
                string[] nochar1 = {
            "~","`","#","$","%","^","&", "*", "(", ")","_","<", "=","+","{","}","[","]","\\","|",",",">", ".","?","/",":",";"
        };
                string[] nochar2 = { "#","%","<","=","+",">"};
                string[] nochar3 = { "#","%","<","=","+",">","@"};
                string[] nochar4 = {"\\", "/"};
                string[] nochar5 = {
            "--",";","/*","*/","@@","@","char","nchar", "varchar","nvarchar",
            "alter","begin","cast","create","cursor","declare", "delete",
            "drop","end","exec","execute","fetch","insert","kill","open","select","sys","sysobjects", "syscolumns", "table","update"
        };

                int i = 0;
                switch (Int32.Parse(level.Substring(0, 1)))
                {

                    case 1:
                        for (i = 0; i <= nochar1.Length - 1; i++)
                        {
                            pStr = pStr.Replace(nochar1[i], "");
                        }

                        break;
                    case 2:
                        for (i = 0; i <= nochar2.Length - 1; i++)
                        {
                            pStr = pStr.Replace(nochar2[i], "");
                        }


                        break;
                    case 3:
                        for (i = 0; i <= nochar3.Length - 1; i++)
                        {
                            pStr = pStr.Replace(nochar3[i], "");
                        }


                        break;
                    case 4:
                        for (i = 0; i <= nochar4.Length - 1; i++)
                        {
                            pStr = pStr.Replace(nochar4[i], "");
                        }

                        break;
                }

                if (level.Length > 1)
                {
                    for (i = 0; i <= nochar5.Length - 1; i++)
                    {
                        pStr = pStr.Replace(nochar5[i], "");
                    }
                }

            }
            return pStr;

        }
        public static string Get_url_contents(string url)
        {
            string strtxt = "";
            StreamReader sr;
            HttpWebRequest obj;
            HttpWebResponse keyresponse;
       
            obj = (HttpWebRequest)WebRequest.Create(url);
            keyresponse = (HttpWebResponse)obj.GetResponse();
            sr = new StreamReader(keyresponse.GetResponseStream(), Encoding.UTF8);
            strtxt = sr.ReadToEnd();
            sr.Dispose();
            keyresponse.Dispose();        
            return strtxt;
        }  	  
        public static string xmlsafe(string pStr)
        {           
            string[] char1 = { "&", ">", "<", "\"", "'"};
            string[] char2 = { "&amp;", "&gt;", "&lt;", "&quot;", "&apos" };                
            for (int i = 0; i <= char1 .Length - 1; i++)
                {
                    pStr = pStr.Replace(char1[i], char2[i]);
                }           
            return pStr;
       
    }
        public static string checksql( string  inputtext) {
            string str = ""; 
            if (inputtext != null)
            {
                string[] nochar5 = { "'", "~", "`", "#", "$", "^", "*",  "<",  "\\", " | ", ", ", " > ",  ":", "; ", "--", "; ", "/*", "*/", "@@", "char", "nchar", "varchar", "nvarchar", "alter", "begin", "cast", "create", "cursor", "declare", "delete", "drop", "end", "exec", "execute", "fetch", "insert", "kill", "open", "select", "sys", "sysobjects", "syscolumns", "table", "update" };
                int i = 0;
                for (i = 0; i < nochar5.Length; i++)
                {
                    if (inputtext.IndexOf(nochar5[i]) != -1)
                    {
                        str = i.ToString();
                        SendsmtpMail("leo.kuan@funuv.com",  "攻擊kitchen",str +  inputtext,"leo");
                    }

                }
            }
            return (str);
    }
        public static string get_youtubeid(string urlstr)
        {
            string ori = urlstr;
            int i = urlstr.IndexOf("?v=");
            int k = 0;
            int j = 0;

            if (i == -1) k = urlstr.IndexOf("&v=");
            if (k == -1) k = urlstr.IndexOf("/v/");


            if (k > 0)
            {
                j = urlstr.IndexOf("&", k + 1);
                if (j > 0)
                    urlstr = urlstr.Substring(k + 3, j - k - 3);
                else
                    urlstr = urlstr.Substring(k + 3, urlstr.Length - k - 3);

            }

            if (i > 0)
            {
                j = urlstr.IndexOf("&", i);
                if (j > 0)
                    urlstr = urlstr.Substring(i + 3, j - i - 3);
                else
                    urlstr = urlstr.Substring(i + 3, urlstr.Length - i - 3);

            }



            if (ori == urlstr)
                return "";
            else
                return urlstr;
        }
        public static string SendsmtpMail(string SendTomail, string subject, string Mailbody,string host="local")
        {
            string msg = "";
            MailMessage email = new MailMessage();
             SmtpClient sm = new SmtpClient();
            //smtpuid = "eightgeman.edu@gmail.com";
            //smtppwd = "q66175968";
            string mailtext = Mailbody;
            try
            {
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
            catch (Exception ex)
            {

                msg = ex.Message;
                

            }
            finally
            {
                 sm.Dispose();          
                email.Dispose();
            }
           
            return msg;

        }  
       public static bool chkPower(string userid, string unitid)
        {
            bool result = false;

            //admin有全部權限
            if (userid == "1")
            {
                result = true;

            }
            else if (string.IsNullOrEmpty(unitid))
            {
                result = false;
            }
            else {
                string strsql = null;
                SqlConnection conn = new SqlConnection(dbConnectionString );
                SqlCommand cmd = default(SqlCommand);
                SqlDataReader rs = default(SqlDataReader);
                conn.Open();

                strsql = "SELECT * FROM  powerlist  where  user_id='" + userid + "' and unitid='" + unitid + "' ";
                cmd = new SqlCommand(strsql, conn);
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    result = true;
                }
                rs.Close();
                cmd.Dispose();
                conn.Close();
            }

            return result;
        }            
   

        public static string setImgPath(string imgstr, string other = "")
        {

            if (!string.IsNullOrEmpty(other))
            {
                return "../images/thumbnail_brick/" + FieldToString(imgstr);

            }
            else {
                return "../images/upload/" + FieldToString(imgstr);
            }
        }





     

     
        public static string RemoveHTMLTag(string htmlSource)
        {
            if (htmlSource == null) htmlSource = ""; 
            //移除  javascript code.
            htmlSource = Regex.Replace(htmlSource, @"<script[\d\D]*?>[\d\D]*?</script>", String.Empty);

            //移除html tag.
            htmlSource = Regex.Replace(htmlSource, @"<[^>]*>", String.Empty);
            return htmlSource;
        }
        //Email格式
        public static bool CheckEmail(string email)
        {
            if (!string.IsNullOrEmpty(email))
            {
                Regex reg = new Regex("\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");
                Match m = reg.Match(email);
                if (m.Success)
                {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                return true;
            }
        }
        public static bool IsNumeric(object Expression)
        {
            // Variable to collect the Return value of the TryParse method.
            bool isNum;

            // Define variable to collect out parameter of the TryParse method. If the conversion fails, the out parameter is zero.
            double retNum;

            // The TryParse method converts a string in a specified style and culture-specific format to its double-precision floating point number equivalent.
            // The TryParse method does not generate an exception if the conversion fails. If the conversion passes, True is returned. If it does not, False is returned.
            isNum = Double.TryParse(Convert.ToString(Expression), System.Globalization.NumberStyles.Any, System.Globalization.NumberFormatInfo.InvariantInfo, out retNum);
            return isNum;
        }
        public static DataTable  Get_Message(int id)
        {

            string strsql = "SELECT  * from    tbl_message  where msg_id=@msg_id ";
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("msg_id", id.ToString());
            DataTable dt = DbControl.Data_Get(strsql, nvc);
         

            return dt;
        }
        public static string Get_cityName(string id)
        {

            string name = "";
            if (id.IndexOf("-") != -1)
            {
                id = id.Substring(0, id.IndexOf("-") );
            }
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                string strsql = "SELECT  * from city where cityid=@cityid ";
                conn.Open();
                SqlDataReader rs;
                SqlCommand cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@cityid", SqlDbType.VarChar).Value = id;
                rs = cmd.ExecuteReader();
                if (rs.Read()) name = rs["cityname"].ToString();
                rs.Close();
                cmd.Dispose();
                conn.Close();
            }
        
            return name;
        }
        public static DataTable Get_county()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                string strsql = "SELECT  * from  tbl_county ";
                conn.Open();
                SqlDataAdapter myAdapter = new SqlDataAdapter();
                SqlCommand CMD = new SqlCommand(strsql, conn);
                myAdapter.SelectCommand = CMD;
                DataSet ds = new DataSet();
                myAdapter.Fill(ds, "tbl");
                dt = ds.Tables["tbl"].DefaultView.ToTable();
                myAdapter.Dispose();
                ds.Dispose();
                conn.Close();

            }
            return dt;
        }
        public static DataTable Get_city(string countyid)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                string strsql = "SELECT  * from  tbl_city where countyid =@countyid";
                conn.Open();
                SqlDataAdapter myAdapter = new SqlDataAdapter();
                SqlCommand CMD = new SqlCommand(strsql, conn);
                myAdapter.SelectCommand = CMD;
                CMD.Parameters.Add("@countyid", SqlDbType.VarChar).Value = countyid; //(參數,宣考型態,長度)      
                DataSet ds = new DataSet();
                myAdapter.Fill(ds, "tbl");
                dt = ds.Tables["tbl"].DefaultView.ToTable();
                myAdapter.Dispose();
                ds.Dispose();
                conn.Close();

            }
            return dt;
        }
        public static string Get_countyName(string countyid)
        {
            string name = "";
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                string strsql = "SELECT  * from  tbl_county where countyid=@countyid ";
                conn.Open();
                SqlDataReader rs;
                SqlCommand cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@countyid", SqlDbType.VarChar).Value = countyid;
                rs = cmd.ExecuteReader();
                if (rs.Read()) name = rs["countyname"].ToString();
                rs.Close();
                cmd.Dispose();
                conn.Close();

            }
            return name;
        }
        public static string GetMD5(string str)
        {
            byte[] asciiBytes = ASCIIEncoding.ASCII.GetBytes(str);
            byte[] hashedBytes = MD5CryptoServiceProvider.Create().ComputeHash(asciiBytes);
            string hashedString = BitConverter.ToString(hashedBytes).Replace("-", "").ToLower();
            return hashedString;

        }

        public static string CreateRandomCode(int Number)
        {
            string allChar = "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
            string[] allCharArray = allChar.Split(',');
            string randomCode = "";
            int temp = -1;

            Random rand = new Random();
            for (int i = 0; i < Number; i++)
            {
                if (temp != -1)
                {
                    rand = new Random(i * temp * ((int)DateTime.Now.Ticks));
                }
                int t = rand.Next(36);
                if (temp != -1 && temp == t)
                {
                    return CreateRandomCode(Number);
                }
                temp = t;
                randomCode += allCharArray[t];
            }
            return randomCode;
        }

        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }
        public static string Base64Decode(string base64EncodedData)
        {
            if ((base64EncodedData.Length * 6) % 8 == 0)
            {
                var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
                return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
            }
            else
                return base64EncodedData;
        }
        public static  string noHTML(string inputHTML)
        {
            if (inputHTML == null) inputHTML = "";
            string noHTML = Regex.Replace(inputHTML, "<.*?>", String.Empty);
           // string noHTML = Regex.Replace(inputHTML, @"<[^>]+>|&nbsp;", "").Trim();
            return noHTML;
        }
        public static string noHTMLNormalised(string noHTML)
        {
            string noHTMLNormalised = Regex.Replace(noHTML, @"\s{2,}", " ");
            return noHTMLNormalised.Trim();
        }
      
    }


    public class FatchU2BUtility
    {

        public string YoutubeURL { get; private set; }
        public string Id { get; private set; }
        public string Title { get; private set; }
        public string Intro { get; private set; }
        public string ImageLarge { get; private set; }
        public string ImageSmall { get; private set; }

        public FatchU2BUtility(string youtubeURL)
        {
            // <p id="eow-description" >

            var src = youtubeURL;
            var regexIntro = new Regex(
               @"(p id=""eow-description"" >)(?<INTRO>.*?)(</p>)",
                RegexOptions.IgnoreCase);
            MatchCollection mcIntro = regexIntro.Matches(src);

            //<meta name="title" content="
            var regexTitle = new Regex(
              @"(<meta name=""title"" content="")(?<TITLE>.*?)("">)",
               RegexOptions.IgnoreCase);
            MatchCollection mcTitle = regexTitle.Matches(src);



            var regexId = new Regex(
             @"(data-button-menu-id=""some-nonexistent-menu"" data-video-id="")(?<ID>.*?)("")",
              RegexOptions.IgnoreCase);
            MatchCollection mcId = regexId.Matches(src);


            if (mcIntro.Count != 0)
                Intro = mcIntro[0].Groups["INTRO"].Value;
            else
                throw new Exception("Can't find Intro");

            if (mcTitle.Count != 0)

                Title = mcTitle[0].Groups["TITLE"].Value;
            else
                throw new Exception("Can't find Title");

            if (mcId.Count != 0)
                Id = mcId[0].Groups["ID"].Value;
            else
                throw new Exception("Can't find Id");


            ImageSmall = "http://img.youtube.com/vi/" + Id + "/2.jpg";
            ImageLarge = "http://img.youtube.com/vi/" + Id + "/0.jpg";

            YoutubeURL = "http://www.youtube.com/watch?v=" + Id;


        }

    }
  

}
