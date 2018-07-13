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
        if (kind == "photoQuickUpload")
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
                    string strsql = "select max(sort)+1 from tbl_article_file where articleid=@articleid and  kind ='P' ";                   
                    nvc.Add("articleid", Request.QueryString["articleid"]);
                    dt = DbControl.Data_Get(strsql, nvc);

                    if (dt.Rows.Count == 0)
                        sort = "1";
                    else
                        sort =dt.Rows[0][0].ToString ();

                    dt.Dispose();
                    strsql = @"insert into tbl_article_file  (articleid, mainImg, sort, status,kind)  
                    values (@articleid,@pic,@sort,'Y','P')";
                    nvc.Clear();
                    nvc.Add("articleid", Request.QueryString["articleid"]);
                    nvc.Add("sort", sort.ToString ());
                    nvc.Add("pic", fname);
                    DbControl.Data_add  (strsql, nvc);

                    //自動縮圖
                    //  ResizeImg(186, 0, Server.MapPath(setImgPath(fname)), Server.MapPath(setImgPath(fname, "thumbnail")));
                    //Response.Write("{\"result\":\"" + fname + "\"}");
                    //Response.Flush();
                }
            }

        }
        if (kind == "companylogo")
        {
            //img_path = "../webimages/product/";
            //html上傳多個雜誌內頁圖檔
            string fname = "";
           
            //用逗號相隔

            for (int i = 0; i <= Request.Files.Count - 1; i++)
            {
                HttpPostedFile filex = Request.Files[i];

                if (filex.ContentLength > 0)
                {
                    fname = DateTime.Now.ToString("yyyyMMddHHmmssff") +  unity.classlib.GetFileExt (filex.FileName );
                    //新檔案(重新命名)
                    //filex.SaveAs(Server.MapPath(img_path + filex.FileName));
                    filex.SaveAs(Server.MapPath(img_path + fname));
                    //自動縮圖
                    //  ResizeImg(186, 0, Server.MapPath(setImgPath(fname)), Server.MapPath(setImgPath(fname, "thumbnail")));
                    Response.Write ( "{\"result\":\""+ fname + "\"}");
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