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
  
    public static class classlib
    {
        public static string dbConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["dbconnConnection"].ConnectionString;
 
        private static string ZipRegex = "<(.|\\n)+?>";
        public  static int GetGlobalEvn = 0; //1正式/0測試
        private static string delivername = "cairnskitchen";
        private static string servicemail = "cairnskitchen.tw@gmail.com";
        private static string smtpuid = "cairnskitchen.tw@gmail.com";
        private static string smtppwd = "ck43285929tw";

        public static string[] payStatus =
           { "未支付" , "ATM已付款", "信用卡已付款"
            ,  "已退款"
            ,  "待發貨"
            ,  "已發貨"
            ,  "已退貨"
            ,  "已完成"
            ,  "進行中"
            ,  "已消" };
 
        public static string get_ord_status(string id )
        {
            string value = "";
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                SqlDataReader rs;
                string strsql;
                strsql = @"SELECT * from payStatus where id=@id ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;
                rs = cmd.ExecuteReader();
                if (rs.Read()) value = rs["name"].ToString();
                rs.Close();
                cmd.Dispose();
                conn.Close();
            }
            return value;
        }
        public static string getPaymode(string id )
        {
            string value = "";
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {             
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                SqlDataReader rs;
                string strsql;
                strsql = @"SELECT * from paymode where id=@id ";                       
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;
                rs = cmd.ExecuteReader();
                if (rs.Read()) value = rs["name"].ToString();
                rs.Close();
                cmd.Dispose();             
                conn.Close();

            }
            return value ;
        }
        public static string getReceivetime(string id)
        {
            string value = "";
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                SqlDataReader rs;
                string strsql;
                strsql = @"SELECT * from Receivetime where id=@id ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;
                rs = cmd.ExecuteReader();
                if (rs.Read()) value = rs["name"].ToString();
                rs.Close();
                cmd.Dispose();
                conn.Close();
            }
            return value;
        }
        public static string getInvoice(string id)
        {
            string value = "";
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                SqlDataReader rs;
                string strsql;
                strsql = @"SELECT * from invoice where id=@id ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;
                rs = cmd.ExecuteReader();
                if (rs.Read()) value = rs["name"].ToString();
                rs.Close();
                cmd.Dispose();
                conn.Close();
            }
            return value;
        }
        //取訂單編號
        // </summary>
        // <param name="ord_date">訂單日期</param>
        // <param name="source">訂單來源</param>
        public static string  Get_ord_code(string ord_date)
        {
            string ord_code = "";
          
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                string ord_code1 = DateTime.Parse(ord_date).ToString("yyyyMMdd");
                string  ord_code2 = "";
              
               
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                SqlDataReader rs;
                string strsql;
                strsql = @"SELECT  count(*) FROM orderdata WHERE  CONVERT(VARCHAR(10), crtdat, 111)  
                         = @ord_date ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@ord_date", SqlDbType.VarChar).Value = ord_date;
                rs = cmd.ExecuteReader();
                if (rs.Read())   ord_code2 = ((int)rs[0] + 1).ToString().PadLeft (5,'0');               
                rs.Close();
                cmd.Dispose();              
                
                ord_code =  ord_code1 + ord_code2;
                conn.Close();
               
            }
            return ord_code;
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
                   return  ipaddress.ToString();
                }
            }
            return strHostName ;
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
        public static void InserAction2(string userid, string ip, string action, string tableName, string action_id, string subject)
        {
          
            //操作記錄,先停用
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
        #region "圖片處理"


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


        //等比縮圖、(裁圖範圍置中)

        public static void ResizeImg(int picwidth, int picheight, string filePath, string saveFilePath)
        {
            float rat1 = 1;
            float rat2 = 1;
            int CutWidth = 0;
            int CutHeight = 0;
            int PointX = 0;
            int PointY = 0;

            System.Drawing.Image imgPhoto = null;
            WebClient webC = new WebClient();
            imgPhoto = System.Drawing.Image.FromStream(webC.OpenRead(filePath));

            //---------------------------------------------------------------

            if (picwidth < imgPhoto.Width | imgPhoto.Height > picheight)
            {
                rat1 = imgPhoto.Width / picwidth;
                rat2 = imgPhoto.Height / picheight;
                if (rat1 < rat2)
                {
                    rat2 = rat1;
                }
                if (rat2 < rat1)
                {
                    rat1 = rat2;
                }
                CutWidth = Convert.ToInt32(imgPhoto.Width / rat1);
                CutHeight = Convert.ToInt32(imgPhoto.Height / rat2);
            }
            else {
                CutWidth = imgPhoto.Width;
                CutHeight = imgPhoto.Height;
            }

            ///////////////長寬等比縮放////////////////
            if (picheight == 0)
            {
                rat1 = imgPhoto.Width / picwidth;
                CutWidth = Convert.ToInt32(imgPhoto.Width / rat1);
                CutHeight = Convert.ToInt32(imgPhoto.Height / rat1);
                picheight = CutHeight;

            }
            else if (picwidth == 0)
            {
                rat2 = imgPhoto.Height / picheight;
                CutWidth = Convert.ToInt32(imgPhoto.Width / rat2);
                CutHeight = Convert.ToInt32(imgPhoto.Height / rat2);
                picwidth = CutWidth;
            }
            //---------------------------------------------------------------


            System.Drawing.Image bmPhoto = new System.Drawing.Bitmap(picwidth, picheight);
            Graphics gbmPhoto = System.Drawing.Graphics.FromImage(bmPhoto);

            gbmPhoto.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            gbmPhoto.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            gbmPhoto.Clear(Color.Transparent);

            if (CutWidth > picwidth)
            {
                PointX = CutWidth / 2 - picwidth / 2;
            }
            if (imgPhoto.Height > picheight)
            {
                PointY = CutHeight / 2 - picheight / 2;
            }

            gbmPhoto.DrawImage(imgPhoto, new Rectangle(0, 0, picwidth, picheight), new Rectangle(PointX * imgPhoto.Width / CutWidth, PointY * imgPhoto.Height / CutHeight, picwidth * imgPhoto.Width / CutWidth, picheight * imgPhoto.Height / CutHeight), GraphicsUnit.Pixel);
            bmPhoto.Save(saveFilePath, System.Drawing.Imaging.ImageFormat.Jpeg);
            gbmPhoto.Dispose();
            bmPhoto.Dispose();
        }


        #endregion
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
        public static int get_price(int p_id,int p_num)
        {
            int p_price = 0;
            using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
            {
                conn.Open();
                string strsql = "SELECT * FROM   productData  WHERE p_id = @p_id  ";
                SqlCommand cmd = new SqlCommand();
                SqlDataReader rs;

                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("p_id", SqlDbType.Int).Value = p_id;
                rs = cmd.ExecuteReader();
                if (rs.Read()) p_price = (int)rs["price"];
                cmd.Dispose();
                rs.Close();


                strsql = "SELECT top 1 price  FROM   productprice  WHERE p_id = @p_id  and num <>0 and num >= @num order by num  ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("p_id", SqlDbType.Int).Value = p_id;
                cmd.Parameters.Add("num", SqlDbType.Int).Value = p_num;
                rs = cmd.ExecuteReader();
                if (rs.Read()) p_price = (int)rs["price"] ;
                cmd.Dispose();
                rs.Close();

                strsql = "SELECT top 1 *  FROM   productprice  WHERE p_id = @p_id  and num <>0 and num < @num ORDER BY   num DESC  ";
                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("p_id", SqlDbType.Int).Value = p_id;
                cmd.Parameters.Add("num", SqlDbType.Int).Value = p_num;
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    if (p_num > (int)rs["num"]) p_price = (int)rs["price"];

                }

                cmd.Dispose();
                rs.Close();

                conn.Close();
            }
            return p_price;
        }
        public static string CData(string @string)
        {
            return "<![CData[" + @string + "]]>";
        }
        public static  DataTable  Get_promo(string id )
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                string strsql = "SELECT  * from promo_system where ps_id=@id";
                SqlDataAdapter myAdapter = new SqlDataAdapter();
                SqlCommand CMD = new SqlCommand(strsql, conn);
                myAdapter.SelectCommand = CMD;
                CMD.Parameters.Add("@id", SqlDbType.VarChar).Value = id;       
                DataSet ds = new DataSet();
                myAdapter.Fill(ds, "tbl");
                dt = ds.Tables["tbl"].DefaultView.ToTable();
                myAdapter.Dispose();
                ds.Dispose();
                conn.Close();

            }
            return dt;
        }
        public static string  Get_ck_atmno()
        {
            string  value = "";
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                string strsql = "SELECT  * from promo_system where ps_id=3 ";
                conn.Open();
                SqlDataReader rs;
                SqlCommand cmd = new SqlCommand(strsql, conn);

                rs = cmd.ExecuteReader();
                if (rs.Read()) value = rs["contents"].ToString() ;
                rs.Close();
                cmd.Dispose();
                conn.Close();

            }
            return value;
        }
        public static int Get_DeliveryPrice()
        {
            int value = 150;
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                string strsql = "SELECT  * from promo_system where ps_id=2";
                conn.Open();
                SqlDataReader rs;
                SqlCommand cmd = new SqlCommand(strsql, conn);

                rs = cmd.ExecuteReader();
                if (rs.Read()) value = (int)rs["ps_condition"];
                rs.Close();
                cmd.Dispose();
                conn.Close();

            }
            return value;
        }
        public static int Get_ship_free()
        {
            int value =1800;
            using (SqlConnection conn = new SqlConnection(dbConnectionString))
            {
                string strsql = "SELECT  * from promo_system where ps_id=1 ";
                conn.Open();
                SqlDataReader rs;
                SqlCommand cmd = new SqlCommand(strsql, conn);
              
                rs = cmd.ExecuteReader();
                if (rs.Read()) value  = (int)rs["ps_condition"];
                rs.Close();
                cmd.Dispose();
                conn.Close();

            }
            return value ;
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
                string strsql = "SELECT  * from  county ";
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
                string strsql = "SELECT  * from  city where countyid =@countyid";
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
                string strsql = "SELECT  * from  county where countyid=@countyid ";
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
            string noHTML = Regex.Replace(inputHTML, @"<[^>]+>|&nbsp;", "").Trim();
            return noHTML;
        }
        public static string noHTMLNormalised(string noHTML)
        {
            string noHTMLNormalised = Regex.Replace(noHTML, @"\s{2,}", " ");
            return noHTMLNormalised;
        }
        public static string get_pd(string ord_id)
        {
            string msg = "";
            using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
            {
                conn.Open();
                SqlDataReader rs;
                SqlCommand cmd = new SqlCommand();
                string strsql = @"SELECT *    FROM productdata INNER JOIN orderdetail ON  productdata.p_id = orderdetail.p_id
                WHERE orderdetail.ord_id = @ord_id ";

                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("@ord_id", SqlDbType.Int).Value = ord_id;
                rs = cmd.ExecuteReader();
                while (rs.Read())
                {
                    msg += rs["productname"].ToString() + "*" + rs["num"].ToString() + "<BR>";

                }

                rs.Close();
                cmd.Dispose();
                conn.Close();
            }

            return msg;
        }
        public static string Get_coupon_price(string memberid, string discount_no, string price)
        {
            string cc_money = "0";
            using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
            {

                SqlCommand cmd = new SqlCommand();
                SqlDataReader rs;
                conn.Open();
                string strsql = @"SELECT  *     FROM    coupon    WHERE  sn =@sn 
                and num >0 and convert(varchar, getdate(), 111) between strdate and enddate   ";

                cmd = new SqlCommand(strsql, conn);
                cmd.Parameters.Add("sn", SqlDbType.VarChar).Value = discount_no;
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    if (rs["status"].ToString() == "N") cc_money = "-1";
                    else if (rs["memberid"].ToString() != "" && rs["memberid"].ToString() != memberid)
                    { cc_money = "-2"; }
                    else
                    {
                     
                        if (rs["addition"].ToString() == "Y")
                        {
                            int x = int.Parse(price) / (int)rs["useprice"];
                            cc_money = ((int)rs["money"] * x).ToString();// "100";
                        }
                        else
                        {
                            cc_money = rs["money"].ToString();
                        }
                    }

                }
                rs.Close();
                cmd.Dispose();
                conn.Close();

            }
            return cc_money;
        }
    }
  
  
    public class orderData
    {
        public string memberid { get; set; }   
        public string password { get; set; } 
        public string paymode { get; set; }
        public string invoice { get; set; }
        public string receiveTime { get; set; }
        public string contents { get; set; }
        public string SubPrice { get; set; }
        public string ShipPrice { get; set; }
        public string Discount { get; set; }
        public string TotalPrice { get; set; }
        public string ordname { get; set; }
        public string ordgender { get; set; }
        public string ordemail { get; set; }
        public string ordphone { get; set; }
        public string ordzip { get; set; }
        public string ordcountyid { get; set; }
        public string ordcityid { get; set; }
        public string ordaddress { get; set; }
        public string shipname { get; set; }
        public string shipphone { get; set; }
        public string shipzip { get; set; }
        public string shipcountyid { get; set; }
        public string shipcityid { get; set; }
        public string shipaddress { get; set; }
        public string shipgender { get; set; }
        public string companyno { get; set; }
        public string title { get; set; }
        public string birthday { get; set; }
    }
    public class ShoppingList 
    {
        public string p_id { get; set; }
        public int num { get; set; }
        public string ship { get; set; }
        public int amount { get; set; }
        public string file { get; set; }
        public string productname { get; set; }
        public int price{ get; set; }     
        public int storage { get; set; }
        public int discount { get; set; }
        public string productcode { get; set; }
        public string pic { get; set; }

    }
    public class cart : IEquatable<cart>
    {
        public string p_id { get; set; }
        public int p_num { get; set; }   
        public override string ToString()
        {
            return "p_id:" + p_id + "p_num:" + p_num.ToString() ;
        }

        public bool Equals(cart other)
        {
            if (other == null) return false;
            return (this.p_id.Equals(other.p_id));
        }
    }

 
}
