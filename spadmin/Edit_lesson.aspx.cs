using System;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Collections.Specialized;
using System.Collections.Generic;
public partial class spadmin_Edit_lesson : System.Web.UI.Page
{
    string unitid = "";
    public static string unitname = "";
  
    protected void Page_Init(object sender, EventArgs e)
    {
        DataTable dt  =(DataTable ) LessonLib.DbHandle.Get_lecturer  ();

        tags.DataSource = dt;
        tags.DataBind();
        dt.Dispose();

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

        string strsql = "select * from tbl_Lesson where lessonId=@lessonId";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("lessonId", Selected_id.Value);
        DataTable dt = DbControl.Data_Get(strsql, nvc);


        subject.Text = dt.Rows[0]["subject"].ToString();       
        contents.Text = dt.Rows[0]["contents"].ToString();
        t_status.SelectedValue = dt.Rows[0]["status"].ToString();
        lessontime.Text = dt.Rows[0]["lessontime"].ToString();
        sdate.Text = DateTime.Parse(dt.Rows[0]["startday"].ToString()).ToString("yyyy/MM/dd");
        edate.Text = DateTime.Parse(dt.Rows[0]["endday"].ToString()).ToString("yyyy/MM/dd");
        address.Text = dt.Rows[0]["address"].ToString();
        price.Text = dt.Rows[0]["price"].ToString();
        sellprice.Text = dt.Rows[0]["sellprice"].ToString();
        dt.Dispose();

        dt =(DataTable ) LessonLib.Web.Tbl_article_tag (int.Parse(Selected_id.Value));
        for (int i= 0; i < dt.Rows.Count ;i++)
        {
           
            foreach (ListItem item in tags.Items)
            {
                if (item.Value == dt.Rows[i]["tagid"].ToString())
                {
                 
                    item.Selected = true; 
                }
            }
        }
    }
    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
        LinkButton obj = sender as LinkButton;


        //-----------------------------------------------------------------------
     

        NameValueCollection nvc = new NameValueCollection();
        string strsql = "";
        if (Btn_save.CommandArgument == "add")
        {
            strsql = @"insert into tbl_Lesson( subject, contents, startday, endday, lessontime, address, price,
            sellprice, status, sort) values  ( @subject, @contents, @startday, @endday, @lessontime, @address, @price,
            @sellprice, @status, @sort) ";
            Selected_id.Value = "";
        }
        else
        {

            strsql = @"UPDATE  tbl_Lesson SET subject =@subject, contents =@contents, 
            startday =@startday, endday =@endday, lessontime =@lessontime, address =@address
            , price =@price, sellprice =@sellprice, status =@status, sort = @sort where lessonId=@lessonId";
            nvc.Add("lessonId", Selected_id.Value);

        }


        nvc.Add("subject", subject.Text );
        nvc.Add("contents", contents.Text);
        nvc.Add("startday", sdate.Text );
        nvc.Add("endday", edate.Text);
      
        nvc.Add("lessontime", lessontime.Text );
        nvc.Add("sort", "1");  
        nvc.Add("sellprice", sellprice.Text);      
        nvc.Add("address", address.Text);
        nvc.Add("price", price.Text);   
        nvc.Add("status", t_status.SelectedValue);
        int i = DbControl.Data_add(strsql, nvc);
        if (Selected_id.Value == "")
        {
            strsql = "select max( articleid) from tbl_article_tag ";          
            DataTable  dt = DbControl.Data_Get (strsql, nvc);
            Selected_id.Value = dt.Rows[0][0].ToString();
            dt.Dispose();
        }

        strsql = "delete from tbl_article_tag where articleid=@id and unitid=14";
        nvc.Clear();
        nvc.Add("id", Selected_id.Value);
        i = DbControl.Data_add(strsql, nvc);

          foreach (ListItem item in tags.Items)            {
            if (item.Selected == true)
            {
                strsql = "insert into tbl_article_tag (articleId, tagid, unitid) values (@id,@tagid,14)";
                nvc.Clear();
                nvc.Add("id", Selected_id.Value);
                nvc.Add("tagid", item.Value);
                i = DbControl.Data_add(strsql, nvc);
            }
        }        
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
    public void selectSQL(string sorttype = "desc", string sortColumn = "lessonId")
    {
        string strsql = "select * from tbl_Lesson where lessonId >0 ";
        strsql += " ORDER BY  " + sortColumn + " " + sorttype;
        NameValueCollection nvc = new NameValueCollection();
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        ListView1.DataSource = dt;

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
        subject .Text = "";
        sellprice.Text = "";
        t_status.SelectedIndex = -1;
        price.Text = "";
        sdate.Text = "";
        edate.Text = "";
        address.Text = "";
        contents.Text = "";
        lessontime.Text = "";
        foreach (ListItem item in tags.Items)
        {
            item.Selected = false;
            
        }
    }
    protected void btn_del_Click(object sender, System.EventArgs e)
    {

        string strsql = "delete fromtbl_Lesson  where lessonId = @id";
        int i = DbControl.Data_delete(strsql, Selected_id.Value);

        ListView1.DataBind();

    }
    public static string show_time(string tt)
    {
        if (tt == "")
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
        string strsql = "update from tbl_Lesson set status='D'  where lessonId = @id";
        int i = DbControl.Data_delete(strsql, Selected_id.Value);
        ListView1.DataBind();
    }
    protected void id_change(object sender, EventArgs e)
    {
        selectSQL();
    }


   
}