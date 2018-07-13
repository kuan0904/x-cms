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
      
        if (!IsPostBack )
        selectSQL();
    }
    public void selectSQL()
    {


        string strsql = "select* from tbl_article_file where  status <> 'D' and articleid = @articleid and kind='P' order by sort";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("articleid", Request.QueryString["articleid"]);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        Repeater_page.DataSource = dt;
        Repeater_page.DataBind();
        dt.Dispose();
        nvc.Clear();

    }


    protected void Btn_cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("editImages.aspx?unitid=" + Request.QueryString["articleid"]);
    }

    protected void Btn_save_Click(object sender, EventArgs e)
    {
      
        deleteBrickImage(Request.QueryString["articleid"]);   
        if ( Request.Form.GetValues("Hidden_id") != null){
            NameValueCollection nvc = new NameValueCollection();
            string[] Hidden_id = Request.Form["Hidden_id"].Split (',');
            string strsql = ""; 
            int j   =  Request.Form.GetValues("Hidden_id").Length;
           
            for (j = 0; j< Request.Form.GetValues("Hidden_id").Length; j++) {
                TextBox tx = (TextBox)Repeater_page.Items[j].FindControl("TextBox1");
                strsql  = "update tbl_article_file set sort=@sort,link =@link  where imgid=@imgid ;";
              
                nvc.Clear();
                nvc.Add("sort", j.ToString () );
                nvc.Add("link", tx.Text) ;
                nvc.Add("imgid", Hidden_id[j]);
                int i =  DbControl.Data_add(strsql, nvc);
            }

     
        }

        selectSQL();
      //  Response.Redirect("editBrick.aspx?unitid=" + Request.QueryString["fromUnitid"]);
    }

    void deleteBrickImage(string  now_id  ) { 

      foreach (RepeaterItem item in Repeater_page.Items)
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


     

    }

}