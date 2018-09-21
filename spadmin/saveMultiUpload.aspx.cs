using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Data;
public partial class spadmin_saveMultiUpload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userid"] == null)
        {
            Server.Transfer("~/account/login.aspx");
        }
        string img_path = "upload/";
        string kind = Request.QueryString["kind"];
        string type = Request.QueryString["type"];
        if (kind == "imageUpload")
        {
            img_path = "../webimages/images/";
            //html上傳多個雜誌內頁圖檔
            string fname = "";
            for (int i = 0; i <= Request.Files.Count - 1; i++)
            {
                HttpPostedFile filex = Request.Files[i];

                if (filex.ContentLength > 0)
                {
                    fname = DateTime.Now.ToString("yyyyMMddHHmmssff") + unity.classlib.GetFileExt(filex.FileName);
                    filex.SaveAs(Server.MapPath(img_path + fname));
                    Response.Write("{ \"fileName\":\"" + img_path + fname + "\",\"uploaded\":1,\"url\":\"" + img_path + fname + "\"}");
                 
                }
            }

        }
        if (kind == "fileUpload")
        {
            img_path = "../webimages/files/";
            //html上傳多個雜誌內頁圖檔
            string fname = "";
            for (int i = 0; i <= Request.Files.Count - 1; i++)
            {
                HttpPostedFile filex = Request.Files[i];

                if (filex.ContentLength > 0)
                {
                    fname = DateTime.Now.ToString("yyyyMMddHHmmssff") + unity.classlib.GetFileExt(filex.FileName);
                    filex.SaveAs(Server.MapPath(img_path + fname));
                    Response.Write("{ \"fileName\":\"" + img_path + fname + "\",\"uploaded\":1,\"url\":\"" + img_path + fname + "\"}");

                }
            }

        }
        if (kind == "photoQuickUpload" && type == "file")
        {
            img_path = "../webimages/gallery/";
            //html上傳多個雜誌內頁圖檔
            string fname = "";
            for (int i = 0; i <= Request.Files.Count - 1; i++)
            {
                HttpPostedFile filex = Request.Files[i];

                if (filex.ContentLength > 0)
                {
                    fname = filex.FileName;
                       img_path = "../webimages/files/";
                    filex.SaveAs(Server.MapPath(img_path + fname ));
                    Response.Write("{ \"fileName\":\"" + img_path + fname + "\",\"uploaded\":1,\"url\":\"" + img_path + fname + "\"}");
                    NameValueCollection nvc = new NameValueCollection();
                    DataTable dt;
                    string sort;
                    string strsql = "select max(sort)+1 from tbl_article_file where (articleid=@articleid or tempid=@articleid) and  kind ='F' ";
                    nvc.Add("articleid", Session["uploadid"].ToString());
                    dt = DbControl.Data_Get(strsql, nvc);

                    if (dt.Rows.Count == 0)
                        sort = "1";
                    else
                        sort = dt.Rows[0][0].ToString();

                    dt.Dispose();
                    strsql = @"insert into tbl_article_file  (articleid, filename, sort, status,kind,tempid)  
                    values (@articleid,@pic,@sort,'Y','F',@articleid)";
                    nvc.Clear();
                    nvc.Add("articleid", Session["uploadid"].ToString());
                    nvc.Add("sort", sort.ToString());
                    nvc.Add("pic", fname);
                    DbControl.Data_add(strsql, nvc);

                    //自動縮圖
                    //unity.classlib. ResizeImg(186, 0, Server.MapPath(unity.classlib.setImgPath(fname)), Server.MapPath(unity.classlib.setImgPath(fname, "thumbnail")));
                    //Response.Write("{\"result\":\"" + fname + "\"}");
                    //Response.Flush();
                }
            }

        }
        if (kind == "photoQuickUpload" && type == "image")
        {
            img_path = "../webimages/gallery/";
            //html上傳多個雜誌內頁圖檔
            string fname = "";         
            for (int i = 0; i <= Request.Files.Count - 1; i++)
            {
                HttpPostedFile filex = Request.Files[i];

                if (filex.ContentLength > 0)
                {
                    fname = DateTime.Now.ToString("yyyyMMddHHmmssff") + unity.classlib.GetFileExt(filex.FileName);
                    filex.SaveAs(Server.MapPath(img_path + fname));
                     Response.Write("{ \"fileName\":\""+ img_path + fname  + "\",\"uploaded\":1,\"url\":\""+ img_path + fname + "\"}");
                    NameValueCollection nvc = new NameValueCollection();
                    DataTable dt;
                   string  sort  ;
                    string strsql = "select max(sort)+1 from tbl_article_file where (articleid=@articleid or tempid=@articleid)  and  kind ='P' ";                   
                    nvc.Add("articleid", Session["uploadid"].ToString ());
                    dt = DbControl.Data_Get(strsql, nvc);

                    if (dt.Rows.Count == 0)
                        sort = "1";
                    else
                        sort =dt.Rows[0][0].ToString ();

                    dt.Dispose();
                    strsql = @"insert into tbl_article_file  (articleid, filename, sort, status,kind,tempid)  
                    values (@articleid,@pic,@sort,'Y','P',@articleid)";
                    nvc.Clear();
                    nvc.Add("articleid", Session["uploadid"].ToString());
                    nvc.Add("sort", sort.ToString ());
                    nvc.Add("pic", fname);
                    DbControl.Data_add  (strsql, nvc);

                    //自動縮圖
                    //unity.classlib. ResizeImg(186, 0, Server.MapPath(unity.classlib.setImgPath(fname)), Server.MapPath(unity.classlib.setImgPath(fname, "thumbnail")));
                    //Response.Write("{\"result\":\"" + fname + "\"}");
                    //Response.Flush();
                }
            }

        }
        if (kind == "companylogo")
        {
            
            string fname = "";
           
            //用逗號相隔

            for (int i = 0; i <= Request.Files.Count - 1; i++)
            {
                HttpPostedFile filex = Request.Files[i];

                if (filex.ContentLength > 0)
                {
                
                    filex.SaveAs(Server.MapPath("/images/logo.jpg"));
                    Response.Write ("{\"result\":\"/images/logo.jpg\"}");
                    Response.Flush();
                }
            }

        }
        if (kind == "article")
        {
            img_path = "../webimages/article/";
            string fname = "";
            //用逗號相隔
            for (int i = 0; i <= Request.Files.Count - 1; i++)
            {
                HttpPostedFile filex = Request.Files[i];

                if (filex.ContentLength > 0)
                {
                    fname = DateTime.Now.ToString("yyyyMMddHHmmssff") + unity.classlib.GetFileExt(filex.FileName);
                    //新檔案(重新命名)
                    //filex.SaveAs(Server.MapPath(img_path + filex.FileName));
                    filex.SaveAs(Server.MapPath(img_path + fname));
                    //自動縮圖
                    //  ResizeImg(186, 0, Server.MapPath(setImgPath(fname)), Server.MapPath(setImgPath(fname, "thumbnail")));
                    Response.Write("{\"result\":\"" + fname + "\"}");
                    Response.Flush();
                }
            }

        }
    }

}