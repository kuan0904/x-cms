using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections.Specialized;
using System.IO;
using System.Data;
public partial class spadmin_editImages : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack )        selectSQL();
    }
    public void selectSQL()
    {


        string strsql = "select* from tbl_article_file where  status <> 'D' and  (articleid =@articleid or tempid=@articleId) and kind='P' order by sort";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("articleid", Session["uploadid"].ToString ());
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        Repeater_image.DataSource = dt;
        if (Request.QueryString ["type"] =="image")   Repeater_image.DataBind();
      
     
        dt.Dispose();
        strsql = "select* from tbl_article_file where  status <> 'D' and  (articleid =@articleid or tempid=@articleId) and kind='F' order by sort";
        dt = DbControl.Data_Get(strsql, nvc);
        Repeater_file.DataSource = dt;
        if (Request.QueryString["type"] == "file") Repeater_file.DataBind(); ;
       
        dt.Dispose();
        nvc.Clear();

    }


    protected void Btn_cancel_Click(object sender, EventArgs e)
    {
      //  Response.Redirect("editImages.aspx?unitid=" + Request.QueryString["articleid"]);
    }

    protected void Btn_save_Click(object sender, EventArgs e)
    {
      
        deleteBrickImage(Session["uploadid"].ToString ());   
       
        NameValueCollection nvc = new NameValueCollection();
        string[] Hidden_id;
        int j;          
        string strsql = "";
        if (Request.QueryString["type"] == "image")
        {
            Hidden_id = Request.Form["img_id"].Split(',');
            j = Request.Form.GetValues("img_id").Length;
            for (j = 0; j < Request.Form.GetValues("img_id").Length; j++)
            {
                TextBox tx = (TextBox)Repeater_image.Items[j].FindControl("TextBox1");
                strsql = "update tbl_article_file set sort=@sort,link =@link  where imgid=@imgid ;";
                nvc.Clear();
                nvc.Add("sort", j.ToString());
                nvc.Add("link", tx.Text);
                nvc.Add("imgid", Hidden_id[j]);
                int i = DbControl.Data_add(strsql, nvc);
            }
        }
        if (Request.QueryString["type"] == "file")
        {
            Hidden_id = Request.Form["file_id"].Split(',');
            j = Request.Form.GetValues("file_id").Length;
            for (j = 0; j < Request.Form.GetValues("file_id").Length; j++)
            {
                TextBox tx = (TextBox)Repeater_file.Items[j].FindControl("TextBox1");
                strsql = "update tbl_article_file set sort=@sort,link =@link  where imgid=@imgid ;";
                nvc.Clear();
                nvc.Add("sort", j.ToString());
                nvc.Add("link", tx.Text);
                nvc.Add("imgid", Hidden_id[j]);
                int i = DbControl.Data_add(strsql, nvc);

            }
        }
  

         selectSQL();
      //  Response.Redirect("editBrick.aspx?unitid=" + Request.QueryString["fromUnitid"]);
    }

    void deleteBrickImage(string  now_id  ) { 

      foreach (RepeaterItem item in Repeater_image.Items)
        {
            CheckBox chk = (CheckBox)(item.FindControl("chk_del"));
            HiddenField  imgid = (HiddenField)(item.FindControl("Hidden_id"));
            if (chk.Checked )
            {
                string strsql = "delete from   tbl_article_file  where imgid=@imgid ";
                NameValueCollection nvc = new NameValueCollection();
                nvc.Clear();
                nvc.Add("imgid", imgid.Value);
                int i = DbControl.Data_add(strsql, nvc);
            }
        }

        foreach (RepeaterItem item in Repeater_file.Items)
        {
            CheckBox chk = (CheckBox)(item.FindControl("chk_del"));
            HiddenField imgid = (HiddenField)(item.FindControl("Hidden_id"));
            if (chk.Checked)
            {
                string strsql = "delete from   tbl_article_file  where imgid=@imgid ";
                NameValueCollection nvc = new NameValueCollection();
                nvc.Clear();
                nvc.Add("imgid", imgid.Value);
                int i = DbControl.Data_add(strsql, nvc);
            }
        }


    }
    public static string Showico(string filename)
    {
        if (filename.ToLower().IndexOf(".doc") > 0) return "doc.jpg";
        else if (filename.ToLower().IndexOf(".pdf") > 0) return "pdf.jpg";
        else if (filename.ToLower().IndexOf(".ppt") > 0) return "ppt.jpg";
        else if (filename.ToLower().IndexOf(".xls") > 0) return "xls.jpg";
        else return "";
    }
}