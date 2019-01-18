using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;
using System.Reflection;
using System.Text;
using System.Drawing;
using System.Drawing.Imaging;
using QR_Encode_Class;

/// <summary>
/// LessonLib 的摘要描述
/// </summary>
public class LessonLib
{
    public LessonLib()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    public class Web
    {
        public static int Get_JoinNum(string Articleid,string lessonId )
        {
            string strsql = @" SELECT count(*)   FROM   tbl_Joindata INNER JOIN
                            tbl_joindetail ON tbl_Joindata.joinid = tbl_joindetail.joinid
                        where  Articleid=@Articleid and lessonId=@lessonId 
            and  tbl_joindetail.status='Y' ";
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("lessonId", lessonId);
            nvc.Add("Articleid", Articleid);
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            return (int)dt.Rows [0][0];

        }
        public static string Get_JoinData( string ord_code)
        {
            string htmldetail = "";
            string htmlstr;
            LessonLib.JoinData o = LessonLib.Web.Get_ord_JoinData(ord_code);

            htmlstr = unity.classlib.GetTextString(HttpContext.Current.Server.MapPath(" /templates/Lessondata0.html"));
            htmldetail = unity.classlib.GetTextString(HttpContext.Current.Server.MapPath("/templates/classdetail.html"));
            htmlstr = htmlstr.Replace("@subject@", o.LessonData.MainData.Subject);
            htmlstr = htmlstr.Replace("@pic@", o.LessonData.MainData.Pic);
            htmlstr = htmlstr.Replace("@totalprice@", o.OrderData.TotalPrice.ToString());
            htmlstr = htmlstr.Replace("@classdate@", o.LessonData.StartDay.ToShortDateString() + "~" + o.LessonData.EndDay.ToShortDateString());
            htmlstr = htmlstr.Replace("@address@", o.LessonData.Address);
            htmlstr = htmlstr.Replace("@ord_code@", o.Ord_code);
            htmlstr = htmlstr.Replace("@DeliveryPrice@", o.OrderData.ShipPrice.ToString());
            htmlstr = htmlstr.Replace("@ordername@", o.OrderData.Ordname);
            htmlstr = htmlstr.Replace("@ordermail@", o.OrderData.Ordemail);
            htmlstr = htmlstr.Replace("@orderphone@", o.OrderData.Ordphone);
            htmlstr = htmlstr.Replace("@shipname@", o.OrderData.Ordname);
            htmlstr = htmlstr.Replace("@shipphone@", o.OrderData.Ordphone);
            htmlstr = htmlstr.Replace("@shipaddress@", o.OrderData.Ordaddress);
            htmlstr = htmlstr.Replace("@TotalPrice@", "NT$:" + o.OrderData.TotalPrice.ToString());
            htmlstr = htmlstr.Replace("@paymode@", OrderLib.getPaymode(o.OrderData.Paymode));
            htmlstr = htmlstr.Replace("@ShipPrice@", o.OrderData.ShipPrice.ToString());
            htmlstr = htmlstr.Replace("@delivery_kind@", OrderLib.getdelivery_kind(o.OrderData.Delivery_kind));
            htmlstr = htmlstr.Replace("@ticketname@", o.LessonData.MainData.Subject);
            htmlstr = htmlstr.Replace("@StartDay@", o.LessonData.MainData.Lesson.StartDay.ToString("yyyy/MM/dd"));
            htmlstr = htmlstr.Replace("@EndDay@", o.LessonData.MainData.Lesson.EndDay.ToString("yyyy/MM/dd"));
            htmlstr = htmlstr.Replace("@Lessontime@", o.LessonData.MainData.Lesson.Lessontime);
            htmlstr = htmlstr.Replace("@paymode@", OrderLib.getPaymode (o.OrderData.Paymode ));
            htmlstr = htmlstr.Replace("@paystatus@", OrderLib.get_ord_status (o.OrderData.Status ));
            SpGatewayHelper.Models.TradeInfoLog log = OrderLib.Get_Tradelog(ord_code);
            string payinfo = "";
            if ( log.Result.TradeNo  != ""  )
            {
            
                payinfo += "<tr><td  colspan=\"4\">轉帳資訊:<br>";
                payinfo += "銀行代碼:" + log.Result.BankCode + "<br>";
                payinfo += "帳號:" + log.Result.CodeNo + "<br></td></tr>";
               
            }
            //  string payinfo = "";
            htmlstr = htmlstr.Replace("@payinfo@", payinfo);

            string temp = "";
            string temp1 = "";           
            foreach (article.LessonDetail d in o.LessonData.LessonDetail)
            {

                var data = o.JoinDetail.Find (y => y.LessonId == d.LessonId);

                // var data = o.LessonData.LessonDetail.FindAll  (y => y.LessonId == d.LessonId).Sum(c => d.Sellprice );
                //  var data = o.LessonData.LessonDetail.FindAll.Where(x => x.ID).Sum(c => c.price)
                if (data != null)
                {

                    temp1 += "<tr><td>" + o.LessonData.MainData.Subject + "</td>";
                    temp1 += "<td  colspan=\"2\">" + d.Description + "</td>";                   
                    temp1 += "<td  class='text-right'>";
                    temp1 += "NT$" + d.Sellprice  + "</td></tr>";
                }
            }
            foreach (LessonLib.JoinDetail d in o.JoinDetail)
            {



                string QrCode = o.Ord_code + "-" + d.JoinId.ToString() + "-" + d.LessonId ;
                string url = "http://www.culturelaunch.net/lib/checkjoin.aspx?code=" + QrCode;
                temp += htmldetail;
                temp = temp.Replace("@secno@", d.JoinId.ToString());
                temp = temp.Replace("@ticketno@", QrCode);
                temp = temp.Replace("@name@", d.Name.ToString());
                temp = temp.Replace("@email@", d.Email.ToString());
                temp = temp.Replace("@phone@", d.Phone.ToString());
                temp = temp.Replace("@qrcode@", QrCode);
                temp = temp.Replace("@orderno@",ord_code );
                QR_Encode qr = new QR_Encode();
                qr.BackColor = Color.White;
                qr.ForeColor = Color.Black;
                int i = qr.EncodeData(1, 0, true , -1, 5, url, HttpContext.Current.Server.MapPath("upload/" + QrCode + ".gif"), false,255, 255);
                //Bitmap b = qr.GetBMP; //輸出至前端
                //Response.ContentType = "image/jpeg";
                //b.Save(Response.OutputStream, ImageFormat.Gif);
                //b.Dispose();
            }
            htmlstr = htmlstr.Replace("@detail@", temp1);
            htmlstr = htmlstr.Replace("@classdetail@", temp);
            return htmlstr;

        }
 
        public static object Tbl_article_tag(int id, string kind = "dt")
        {
            NameValueCollection nvc = new NameValueCollection();
            string strsql = @"select tbl_article_tag.articleId, tbl_article_tag.tagid, tbl_article_tag.unitid,
            tbl_tag.tagname, tbl_tag.pic, tbl_tag.contents, tbl_tag.title
                FROM     tbl_article_tag INNER JOIN tbl_tag ON tbl_article_tag.tagid = tbl_tag.tagid
                where tbl_article_tag.articleId=@id ";
            nvc.Add("id", id.ToString());
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            {
                if (kind == "dt") {
                    return dt;
                }
                else
                {
                    List< article.Lecturer> Lecture = new List<article.Lecturer>();
                    int i = 0;
                    for (i = 0; i < dt.Rows.Count; i++)
                    {
                        Lecture.Add(new article.Lecturer
                        {
                            Id = (int)dt.Rows[i]["tagid"],
                            Title = (string)dt.Rows[i][" Title"],
                            Subject = (string)dt.Rows[i]["tagname"],
                            Contents = (string)dt.Rows[i]["Contents"],
                            Pic = (string)dt.Rows[i]["Contents"]
                        });
                    }
                    dt.Dispose();
                    return Lecture;
                }

            }
        }

        public static JoinData Get_ord_JoinData(string ord_code) {

            string strsql = @"select *  FROM        tbl_Joindata  where ord_code=@ord_code";
            NameValueCollection nvc = new NameValueCollection
            {
                { "ord_code", ord_code }
            };
            DataTable    dt = DbControl.Data_Get(strsql, nvc);
            LessonLib.JoinData n = new LessonLib.JoinData();
            OrderLib.OrderData o  = OrderLib.Get_ordData(ord_code);
            n.Id = 0;

            if (dt.Rows.Count > 0)
            {
                n.Id = (int)dt.Rows[0]["joinid"];
                n.Status = (string)dt.Rows[0]["status"];
                n.TicketKind = (string)dt.Rows[0]["TicketKind"];
                n.Articleid = (int)dt.Rows[0]["Articleid"];
                n.Ord_code = (string)dt.Rows[0]["ord_code"];
                n.OrderData = o;
                n.LessonData = DbHandle.Get_Lesson(n.Articleid.ToString());
                strsql = @"select *  FROM  tbl_joindetail where joinid=@joinid";
                nvc.Clear();
                dt.Dispose();
                nvc = new NameValueCollection
                {
                    { "joinid", n.Id .ToString ()}
                };
                dt = DbControl.Data_Get(strsql, nvc);
                List<JoinDetail> detail = new List<JoinDetail>();
                foreach (DataRow d in dt.Rows)
                {
                    strsql = @"select *  FROM   tbl_joinlog where checkcode=@checkcode";
                    string checkcode = n.Ord_code
                        + "-" + d["joinid"].ToString()
                        + "-" + d["lessonid"].ToString();                    
                     
                    nvc.Clear();
                    nvc = new NameValueCollection
                    {
                        { "checkcode", checkcode}
                    };
                    DataTable c = DbControl.Data_Get(strsql, nvc);

                    detail.Add(new JoinDetail
                    {
                        JoinId = (int)d["joinid"],
                        Name = (string)d["username"],
                        Phone = (string)d["phone"],
                        Email = (string)d["email"],
                        Amount = (int)d["Amount"],
                        LessonId = (int)d["lessonid"],
                        Secno = (int)d["secno"],
                        Status = d["status"].ToString(),
                        Unitname=d["Unitname"].ToString(),
                        Postion = d["Postion"].ToString(),
                        checkin = c.Rows.Count==0 ? "":"Y"
                    });
                    c.Dispose();
                }
                n.JoinDetail = detail;
            }
            return n;


        }
        public static int CheckJoin(string email, int lessonid)
        {
            string strsql = @"select * from tbl_joindetail where 
            email=@email and lessonid=@lessonid and status ='Y'";
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("email", email);
            nvc.Add("lessonid", lessonid.ToString());
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            int result = dt.Rows.Count;
            dt.Dispose();
            return result;
        }
    }
    public class DbHandle
    {
        public static object  JoinAdd(JoinData  item)
        {
                string strsql = @"INSERT  into Tbl_Joindata( status,ticketkind, Articleid,ord_code)   values
                ( @status,@ticketkind, @Articleid ,@ord_code) ";

                NameValueCollection nvc = new NameValueCollection            {
                    { "status","1" },         
                    { "ticketkind",item.TicketKind  },
                    { "Articleid",item.Articleid .ToString ()   },              
                    {"ord_code",item.Ord_code  }
              
                };
                DbControl.Data_add(strsql, nvc);
                int joinid = 0;

                strsql = "select max (joinid) from  Tbl_Joindata";
                nvc.Clear();
                DataTable dt = DbControl.Data_Get(strsql, nvc);
                joinid = (int)dt.Rows[0][0];
                item.Id = joinid;
                foreach (JoinDetail j in item.JoinDetail )
                {
                    strsql = @"INSERT INTO tbl_joindetail( username, phone, email,
                    lessonid,amount,status,postion,unitname,joinid)
                        VALUES ( @username, @phone, @email, @lessonid,@amount,'Y',
                    @postion,@unitname,@joinid)";
                    nvc.Clear();
                    nvc.Add("joinid", joinid.ToString ());
                    nvc.Add("username", j.Name);
                    nvc.Add("phone", j.Phone);
                    nvc.Add("email", j.Email);
                    nvc.Add("amount", j.Amount .ToString ());
                    nvc.Add("lessonid", j.LessonId .ToString());
                    nvc.Add("postion", j.Postion);
                    nvc.Add("unitname", j.Unitname);

                DbControl.Data_add(strsql, nvc);

            };          

            return item ;
        }
        public static LessonData Get_Lesson(string id)
        {
            NameValueCollection nvc = new NameValueCollection();
            string strsql = "select * from    tbl_Lesson  ";        
                strsql += "where articleId =@id";
                nvc.Add("id", id);           
                DataTable dt = DbControl.Data_Get(strsql, nvc);        
                LessonLib.LessonData MainData = new LessonLib.LessonData();
                List<article.LessonDetail> detail = new List<article.LessonDetail>();
                int i = 0;
                for (i = 0; i < dt.Rows.Count; i++)
                {

                    MainData.Id = (int)dt.Rows[i]["articleId"];
                    MainData.StartDay =  (DateTime ) dt.Rows[i]["startday"];
                    MainData.EndDay  = (DateTime)dt.Rows[i]["Endday"];                   
                    MainData.Address = (string)dt.Rows[i]["Address"];
                    MainData.Lessontime = (string)dt.Rows[i]["Lessontime"];
                    MainData.MainData= article.DbHandle.Get_article(MainData.Id);
                    MainData.LecturerData = article.DbHandle.Get_Lecturer_list(MainData.MainData.Lesson.Lecturer); ;
                  
                }
                strsql = "select * from   tbl_lesson_class  where articleId =@id";
                dt = DbControl.Data_Get(strsql, nvc);
            foreach (DataRow d in dt.Rows)
            {
                article.LessonDetail Deta = new article.LessonDetail();
                Deta.LessonId = (int)d["lessonId"];
                Deta.Price = (int)d["price"];
                Deta.Sellprice = (int)d["sellprice"];
                Deta.Limitnum = (int)d["limitnum"];
                Deta.Description = (string )d["description"];
                Deta.Id = MainData.Id;
                detail.Add(Deta);


            }
            MainData.LessonDetail = detail;
            dt.Dispose();
               
               


            return MainData;
            
        }
        public static article.LessonDetail Get_LessonClass(int id)
        {
            NameValueCollection nvc = new NameValueCollection();
            string strsql = "select * from   tbl_lesson_class  ";
            
                strsql += "where lessonId =@id";
                nvc.Add("id", id.ToString ());
         
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            article.LessonDetail   MainData = new article.LessonDetail();
            int i = 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {

                MainData.Id = (int)dt.Rows[i]["articleId"];            
                MainData.Price = (int)dt.Rows[i]["Price"];
                MainData.Description = (string)dt.Rows[i]["description"];
                MainData.Sellprice  = (int)dt.Rows[i]["Sellprice"];
                MainData.Limitnum= (int)dt.Rows[i]["limitnum"];
                MainData.LessonId = (int)dt.Rows[i]["lessonId"];

            }
            dt.Dispose();
            return MainData;

        }
        public static object Get_lecturer(string kind = "dt")
        {
            NameValueCollection nvc = new NameValueCollection();
            string strsql = "select * from       tbl_tag  where unitid=14 ";
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (kind == "dt")
            {
                dt.Dispose();
                return dt;
            }
            else
            {
                List<article.Lecturer> Lecture = new List<article.Lecturer>();
                int i = 0;
                for (i = 0; i < dt.Rows.Count; i++)
                {
                    Lecture.Add(new article.Lecturer
                    {
                        Id = (int)dt.Rows[i]["tagid"],
                        Subject = (string)dt.Rows[i]["tagname"],
                        Contents = (string)dt.Rows[i]["Contents"],
                        Pic = (string)dt.Rows[i]["Contents"]
                    });
                }
                dt.Dispose();
                return Lecture;
            }
        }


    }
    public class JoinData {
        public int Id { get; set; }
        public int Articleid { get; set; }      
        public string TicketKind { get; set; }      
        public string Ord_code { get; set; }
        public string Status { get; set; }    
        public OrderLib.OrderData OrderData { get; set; }
        public List<JoinDetail> JoinDetail { get; set; }
        public LessonData LessonData { get; set; }
}
    public class JoinDetail
    {
        public int Secno { get; set; }
        public int JoinId { get; set; }
        public int LessonId { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }      
        public string Phone { get; set; }
        public int Amount { get; set; }
        public string Unitname { get; set; }
        public string Postion { get; set; }
        public string Status { get; set; }
        public string checkin { get; set; }
    }



    public class LessonData
    {
        public int Id { get; set; }
        public article.MainData MainData {get;set;}
        public DateTime StartDay { get; set; }
        public DateTime EndDay { get; set; }
        public string Lessontime { get; set; }
        public string Address { get; set; }
        public List<article.LessonDetail>LessonDetail { get; set; }
        public List< article.Lecturer> LecturerData { get; set; }
    }

}