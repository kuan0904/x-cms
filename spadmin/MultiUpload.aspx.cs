using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using unity;
public partial class spadmin_MultiUpload : System.Web.UI.Page
{
    public string p_id ="";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString ["p_id"] != null)
        {
            p_id = Request.QueryString["p_id"];
        }
        else
        {
            p_id = DateTime.Now.ToString("yyyyMMddhhmmss");
        }

        string img_path = "upload/";

        if (Request.QueryString["p_id"] != null)
        {

            //html上傳多個雜誌內頁圖檔
            string fname = "";
            string imgMainStr = "";
            //用逗號相隔
           
            for (int i = 0; i <= Request.Files.Count - 1; i++)
            {
                HttpPostedFile filex = Request.Files[i];
                if (filex.ContentLength > 0)
                {
                    fname = DateTime.Now.ToString("yMdHmsf") + (filex.FileName);
                  
                  
                    filex.SaveAs(Server.MapPath(img_path + filex.FileName));
                    //自動縮圖
                    //  ResizeImg(186, 0, Server.MapPath(setImgPath(fname)), Server.MapPath(setImgPath(fname, "thumbnail")));
                }
            }

        }

    }
    protected void Page_Init(object sender, System.EventArgs e)
    {
        if (Session["userid"] == null )
        {
            Server.Transfer("~/account/login.aspx");
        }
      

          

            //If Request.QueryString("magazine_id") = "11111111-1111-1111-1111-111111111111" Then
            //    InserAction2(Session("UserID").ToString, getIP(Request), "U", "Welcome", "", "圖檔上傳")
            //Else
            //    InserAction2(Session("UserID").ToString, getIP(Request), "U", "Magazine", "", "圖檔上傳")
            //End If

        }


   



  

}