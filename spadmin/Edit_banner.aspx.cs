using System;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Collections.Specialized;

public partial class spadmin_Edit_banner : System.Web.UI.Page    
{
    string unitid = "";
    public static string unitname = "";

    protected void Page_Init(object sender, EventArgs e)
    {
        for (int i = 0;i <= 23;i++)
        {
            stime.Items.Add(i.ToString() );
            etime.Items.Add(i.ToString() );
        }
        unitid = Request.QueryString["unitid"];
        unitname = unitlib.Get_UnitName(int.Parse(unitid));
        string strsql = "SELECT *  FROM tbl_banner_class where classid > @id order by  sort ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", Selected_id.Value);
        DataTable dt = DbControl.Data_Get (strsql, nvc);
        DropDownList1.DataSource = dt;
        DropDownList1.DataBind();


    }
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {

            MultiView1.ActiveViewIndex = 0;
            selectSQL();
        }

    }
    //編輯
    protected void link_edit(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        Selected_id.Value = obj.CommandArgument;
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "edit";

        string strsql= "select * from tbl_banner where bannerid=@bannerid";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add ("bannerid", Selected_id.Value);
        DataTable dt = DbControl.Data_Get(strsql, nvc);

      
            t_title.Text = dt.Rows[0]["title"].ToString ();
            t_url.Text = dt.Rows[0]["url"].ToString();
            t_sort.Text  = dt.Rows[0]["sort"].ToString ();
            t_status.SelectedValue = dt.Rows[0]["status"].ToString ();
            t_targetblank.Text  = dt.Rows[0]["targetblank"].ToString ();
            sdate.Text = DateTime.Parse(dt.Rows[0]["enabledate"].ToString ()).ToString("yyyy/MM/dd");
            stime.SelectedValue =DateTime.Parse ( dt.Rows[0]["enabledate"].ToString ()).Hour.ToString () ;
            Literal1.Text = "<img src=\"../webimages/banner/" +  dt.Rows[0]["filename"].ToString () + "\" height =\"200\"/>";
            HiddenField1.Value = dt.Rows[0]["filename"].ToString();
            contents.Text = dt.Rows[0]["contents"].ToString();
        if (dt.Rows[0]["disabledate"].ToString () !="")
            {

                DateTime ee = DateTime.Parse(dt.Rows[0]["disabledate"].ToString());
                edate.Text = ee.ToString("yyyy/MM/dd");
                etime.SelectedValue = ee.Hour.ToString();

            }
            else
            {
                edate.Text = "";
                  

            }

        dt.Dispose();

       


    }
    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
     

        //-----------------------------------------------------------------------
        string uploadPath = Server.MapPath("~/webimages/banner/");
        string Filename ="";
        string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif"  };
        
        string fileExtension ;
        if (FileUpload1.HasFile)
        {
            fileExtension = Path.GetExtension(FileUpload1.FileName.ToLower () );
            if (Array.IndexOf(allowedExtensions, fileExtension) >= 0)
            {
                Filename = DateTime.Now.ToString("yyyyMMddhhmmssfff") + fileExtension;
                FileUpload1.PostedFile.SaveAs(uploadPath + Filename );
                HiddenField1.Value = Filename;
            }
            else
            {
                Response.Write("檔案格式有誤");

            }

        }

        NameValueCollection nvc = new NameValueCollection();
        string strsql = "";
        if (Btn_save.CommandArgument == "add")
        {
            strsql = @"INSERT  INTO tbl_banner(filename, path, url, targetblank, sort, enabledate, disabledate, 
                status, title, createdate, createuserid,  classId,viewcount,contents) VALUES (@filename, @path, @url, @targetblank,
                @sort, @enabledate, @disabledate, @status, @title, @createdate, @createuserid,  @classId,0,@contents) ";
            nvc.Add("createdate", DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"));
            nvc.Add("createuserid", Session["userid"].ToString());
        }
        else {

            strsql = @"UPDATE  tbl_banner SET filename =@filename, path =@path, url =@url, targetblank =@targetblank, 
            sort =@sort, enabledate =@enabledate, disabledate =@disabledate, status =@status, title =@title, 
             classId =@classId ,contents=@contents where bannerid=@bannerid";
            nvc.Add("bannerid", Selected_id.Value);
           
        }
      
       
        nvc.Add("filename", HiddenField1.Value);
        nvc.Add("path", "webimages/banner/");
        nvc.Add("url", t_url.Text);
        nvc.Add("targetblank", t_targetblank.Text);
        nvc.Add("sort", t_sort.Text);
        nvc.Add("enabledate",sdate.Text + " " + stime.SelectedValue + ":00:00");
        nvc.Add("status", t_status.SelectedValue);
        nvc.Add("title", t_title.Text);      
        nvc.Add("classId", DropDownList1.SelectedValue);
        if (edate.Text != "")           
            nvc.Add("disabledate", edate.Text + " " + etime.SelectedValue + ":00:00");       
        else       
            nvc.Add("disabledate", "DBNull");
        nvc.Add("contents", contents.Text );
        int i = DbControl.Data_add(strsql, nvc);
     
        selectSQL();
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
      

    }
    protected void sortdata(object sender, EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        string sorttype = obj.CommandArgument;
        string sortColumn = obj.CommandName;
        sorttype = (sorttype == "desc") ? "asc" : "desc";
        obj.CommandArgument = sorttype;
        selectSQL(sorttype, sortColumn);

    }
    public void selectSQL(string sorttype = "desc", string sortColumn = "bannerid")
    {
        string strsql = "select * from  tbl_banner  where classid=@classid ";
        strsql += " ORDER BY  " + sortColumn + " " + sorttype;
        viewDataSource.SelectParameters.Clear();
        viewDataSource.SelectCommand = strsql;
        viewDataSource.SelectParameters.Add ("classid", DropDownList1.SelectedValue );
        ListView1.DataSourceID = viewDataSource.ID ;
        ListView1.DataBind();
      

    }
    protected void ContactsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {    
        var pager = (DataPager)ListView1.FindControl("DataPager1");
        pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        selectSQL();
    }
    protected void Btn_add_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        Btn_save.CommandArgument = "add";
        cleaninput();
    }
    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        cleaninput();
    }
    public void cleaninput()
    {
        Selected_id.Value = "";
        t_title.Text = "";
        t_sort.Text = "";
        t_status.SelectedIndex = -1;
        t_targetblank.SelectedIndex  = -1;
        sdate.Text = "";
        edate.Text = "";
        t_url.Text  = "";
        Literal1.Text = "";
        stime.SelectedIndex = 0;
        etime.SelectedIndex = 0;
        contents.Text = "";
    }
    protected void btn_del_Click(object sender, System.EventArgs e)
    {

        string strsql = "delete from tbl_banner  where bannerid = @id";  
        int i = DbControl.Data_delete(strsql, Selected_id.Value);    
        
        ListView1.DataBind();

    }
    public static string show_time(string tt)
    {
        if (tt ==  ""  )
        {
            tt = "";    
        }
        else
        {
            tt = DateTime.Parse(tt).ToString("yyyy/MM/dd:hh");

        }

        return tt;
    }
    //刪除
    protected void link_delete(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;
        Selected_id.Value = obj.CommandArgument;
        string strsql = "update from tbl_banner set status='D'  where bannerid = @id";
        int i = DbControl.Data_delete(strsql, Selected_id.Value);
        ListView1.DataBind();
    }
    protected void id_change(object sender, EventArgs e)
    {
        selectSQL();
    }

}