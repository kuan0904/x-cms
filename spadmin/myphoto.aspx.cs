using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Specialized;
public partial class spadmin_myphoto : System.Web.UI.Page
{
    string strsql= "";
    protected void Page_Load(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        if (Request.QueryString["catalogue"] != null)
        {
            strsql= "SELECT * from uploadfile  where  status <> 'D' and filekind='A' ";
            if (Request.QueryString["catalogue"] != "不區分")
            {               
                strsql += " and catalogue ='" + Request.QueryString["catalogue"] + "' ";
            }

       
               
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = DbControl.Data_Get(strsql, nvc);
           
            if (!IsPostBack )
            {
                dbinit(dt, DataList1);
            }

        }
        else if (!IsPostBack)
        {
            string strsql = @"SELECT '不區分' AS catalogue UNION ALL SELECT catalogue FROM UpLoadfile WHERE(status <> 'D')
            AND(catalogue IS NOT NULL) AND(fileKind <> 'D' and fileKind <> 'M')  AND(catalogue <>'' )  GROUP BY catalogue";
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = DbControl.Data_Get(strsql, nvc);

            dbinit(dt, DataList2);
        }

        if (Request["uploadid"] != null)
        {
            strsql= "SELECT * from uploadfile  where  status <> 'D'  ";
            strsql += " and uploadid = " + Request["uploadid"];

            MultiView1.ActiveViewIndex = 2;
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            if (!IsPostBack)
            {
                dbinit(dt, DataList1);
            }

        }

    }

    void dbinit(DataTable  sqldata, DataList datalistitem)
    {
        PagedDataSource Pgds = new PagedDataSource();
        Pgds.DataSource = sqldata.DefaultView;
        Pgds.AllowPaging = true;
        Pgds.PageSize = 10;
        dlblTotalPage.Text = "共" + Pgds.PageCount.ToString() + "頁/" + Pgds.Count.ToString () + "筆";

    
        int CurrentPage;
        if (((Request.QueryString["Page"]) != null))
        {
            CurrentPage = Convert.ToInt32((Request.QueryString["Page"]));
        }
        else
        {
            CurrentPage = 1;
        }

        Pgds.CurrentPageIndex = (CurrentPage - 1);
        dlblCurrentPage.Text = (("," + CurrentPage.ToString())
                    + "");
        if (!Pgds.IsFirstPage)
        {
            dlnkPrev.NavigateUrl = Request.CurrentExecutionFilePath + "?catalogue=" + Request.QueryString["catalogue"] +
                "&uploadid=" + Request["uploadid"] + "&Page=" + Convert.ToString(CurrentPage - 1);

        }

        if (!Pgds.IsLastPage)
        {
            dlnkNext.NavigateUrl = Request.CurrentExecutionFilePath + "?catalogue=" + Request.QueryString["catalogue"] +
                "&uploadid=" + Request["uploadid"] + "&Page=" + Convert.ToString(CurrentPage + 1);

        }

        int i;
        dpagelink.Text = "";
        for (i = 1; (i <= Pgds.PageCount); i++)
        {
            dpagelink.Text += " <a href=\"" +  Request.CurrentExecutionFilePath + "?catalogue=" + Request.QueryString["catalogue"] +
                    "&uploadid="+ Request ["uploadid"] + "&Page=" + Convert.ToString(i) + "\">" + i.ToString() + ".</a> ";
        }
       
        datalistitem.DataSource = Pgds;
        datalistitem.DataBind();
    }
    protected void DataList1_ItemDataBound(object sender, System.Web.UI.WebControls.DataListItemEventArgs e)
    {
        //   Dim img As Image = CType(e.Item.FindControl("mypic"), Image)
        ImageButton img = ((ImageButton)(e.Item.FindControl("mypic")));
        DataRowView rowView =(DataRowView ) e.Item.DataItem ;
        img.ImageUrl = "../upload/pic/" + rowView["filename"].ToString ();
        image1.ImageUrl = "../upload/pic/" + rowView["filename"].ToString ();
    }

    protected void Button1_Click(object sender, System.EventArgs e)
    {
       
        int i;
        string strFileName = "";
        string FIleExt;
        string DirName = "upload";
        string albumid = "";
        DirName = "../upload/pic/";
        NameValueCollection nvc = new NameValueCollection();
        DataTable dt = new DataTable();
        System.IO.Directory.CreateDirectory(Server.MapPath(DirName));
        for (i = 0; i <= Request.Files.Count - 1; i++)
        {
            HttpPostedFile filUpFile = Request.Files[i];
            string[] arrFileSplit = filUpFile.FileName.Split('/');
            strFileName = arrFileSplit[(arrFileSplit.Length - 1)];
         
            if ((strFileName != ""))
            {
                FIleExt = unity.classlib . GetFileExt(strFileName);
                strFileName = (Guid.NewGuid().ToString() + FIleExt);
                filUpFile.SaveAs(Server.MapPath((DirName + ("\\" + strFileName))));
              
                if ((catalogue.Text == ""))
                {
                    catalogue.Text = (Request.QueryString["catalogue"]);
                }

                strsql= "insert into uploadfile (filename,status,catalogue,filekind) values ('"
                            + strFileName + "','Y','" + catalogue.Text + "','A' )";
              
                DbControl.Data_add(strsql, nvc);

            }

        }

        strsql= "SELECT * from uploadfile  where  status <> 'D' and filekind='A' ";
        if (Request.QueryString["catalogue"] != "")
        {
          
            strsql+= " and catalogue ='"    + catalogue.Text + "' ";
        }

     
        catalogue.Text = "";
         dt = DbControl.Data_Get(strsql, nvc);
      
        dbinit(dt, DataList1);
    }


    protected void Button3_Click(object sender, System.EventArgs e)
    {
        Response.Redirect("myphoto.aspx");
    }

    protected void Button4_Click(object sender, System.EventArgs e)
    {
        Response.Redirect("myphoto.aspx");
    }

    protected void Button6_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 3;
        strsql= "SELECT * from uploadfile  where  status <> 'D' and filekind='M' order by uploadid desc  ";
        NameValueCollection nvc = new NameValueCollection();
        DataTable dt = DbControl.Data_Get(strsql, nvc);

        dbinit(dt, DataList3);
    }
    protected void DataList3_ItemDataBound(object sender, System.Web.UI.WebControls.DataListItemEventArgs e)
    {
        DataRowView rowView = (DataRowView)e.Item.DataItem;
        ((ImageButton)(e.Item.FindControl("cover"))).ImageUrl = "../upload/mov/" + rowView["filename"].ToString ().Replace(".flv", ".jpg");
        ((ImageButton)(e.Item.FindControl("cover"))).Attributes.Add("OnClick", "return selectavi(this.src, '"
                        + rowView["uploadid"].ToString ()  + "')");
    }

    protected void Btn_upload_Click(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
    }
}