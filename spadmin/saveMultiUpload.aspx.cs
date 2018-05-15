using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class spadmin_saveMultiUpload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userid"] == null)
        {
            Server.Transfer("~/account/login.aspx");
        }
        string img_path = "upload/";
        img_path = "../webimages/product/";
        if (Request.QueryString["p_id"] != null)
        {

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
        
    }

}