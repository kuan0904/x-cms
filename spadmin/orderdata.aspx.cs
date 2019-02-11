using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Diagnostics;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using unity;
using System.Collections.Specialized;

public partial class spadmin_orderdata : System.Web.UI.Page
{
    public OrderLib.OrderData o = new OrderLib.OrderData();

    public string ord_code = "";

    public string CardAUTHINFO = "";
    public string outfile = "";

    protected void Page_Init(object sender, EventArgs e)
    {
        //   Export("application/ms-excel", "employee.xls")
        enddate.Text = DateTime.Today.ToString("yyyy/MM/dd");
        strdate.Text = DateTime.Today.AddDays (-7).ToString("yyyy/MM/dd");
        DataTable dt = new DataTable();
        string strsql = "select * from tbl_Receivetime where status=@status";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("status", "Y");
        dt = DbControl.Data_Get(strsql, nvc);
        receivetime.DataSource = dt;
        receivetime.DataBind();
        dt.Dispose();

        strsql = "select * from tbl_invoice ";
        dt = DbControl.Data_Get(strsql, nvc);
        invoice.DataSource = dt;
        invoice.DataBind();
        invoice.Items.Insert(0, new ListItem("無", ""));
        dt.Dispose();

        strsql = "select * from tbl_paymode";
        dt = DbControl.Data_Get(strsql, nvc);
        qpaykind.DataSource = dt;
        qpaykind.DataBind();
        qpaykind.Items.Insert(0, new ListItem("不區分", ""));
        paymode.DataSource = dt;
        paymode.DataBind();
        dt.Dispose();

        strsql = "select * from tbl_payStatus ";
        dt = DbControl.Data_Get(strsql, nvc);
        payStatus.DataSource = dt;
        payStatus.DataBind();
        qstatus.DataSource = dt;
        qstatus.DataBind();
        qstatus.Items.Insert(0, new ListItem("不區分"));
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        outfile = "";
        if (!IsPostBack)
        {
          MultiView1.ActiveViewIndex = 0;
           
        }
        
    }
    protected void link_edit(object sender, System.EventArgs e)
    {
        MultiView1.ActiveViewIndex = 1;
        LinkButton obj = sender as LinkButton;
        Selected_id.Value = obj.CommandArgument;
        o = OrderLib.Get_ordData(Selected_id.Value);
        payStatus.SelectedValue = o.Status;
        MultiView1.ActiveViewIndex = 1;
        LessonLib.JoinData l = LessonLib.Web.Get_ord_JoinData(o.Ord_code );
        joindata.Visible = false;
        companyno.Text = l.OrderData.Companyno;
        title.Text = l.OrderData.Title;
        if (l.JoinDetail.Count > 0)
        {
           
            joindata.Visible = true ;
            Lstatus.SelectedValue = l.JoinDetail[0].Status;
            
        }
        paymode.SelectedValue = o.Paymode;
        Btn_save.CommandArgument = "edit";
        string strsql = "select * from Log_Sms where ord_code=@ord_code";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_code", Selected_id.Value);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        Repeater2.DataSource = dt;
        Repeater2.DataBind();
    }
    protected void Btn_save_Click(object sender, System.EventArgs e)
    {
      
        string strsql = @"update tbl_OrderData set 
       
        invoice=@invoice,
        receivetime=@receivetime,
        shipname=@shipname,
        shipphone=@shipphone,
        shipaddress=@shipaddress,     
        contents=@contents,
        companyno=@companyno,paymode=@paymode,
        status =@status,coupon_no=@coupon_no,
        title=@title
        where ord_code=@ord_code";
        NameValueCollection nvc = new NameValueCollection();
       
        nvc.Add("invoice", invoice.SelectedValue);
        nvc.Add("receivetime", receivetime.SelectedValue);
        nvc.Add("status", payStatus.SelectedValue);
        nvc.Add("shipname", shipname.Text);
        nvc.Add("shipphone", shipphone.Text);
        nvc.Add("shipaddress", shipaddress.Text);
        nvc.Add("contents", contents.Text );
        nvc.Add("paymode", paymode.SelectedValue );

        nvc.Add("ord_code", Selected_id.Value);
        nvc.Add("companyno", companyno.Text);
        nvc.Add("coupon_no", coupon_no.Text);
        nvc.Add("title", title.Text);
        DbControl.Data_add(strsql, nvc);

        strsql = @"update  tbl_Joindata set      
            status=@status
            where ord_code=@ord_code";      
            DbControl.Data_add(strsql, nvc);

            string jstatus = Lstatus.SelectedValue;
            if (payStatus.SelectedValue == "2") jstatus = "Y";
            else if (payStatus.SelectedValue == "10") jstatus = "N";
            else if (payStatus.SelectedValue == "7") jstatus = "N";
            else if (payStatus.SelectedValue == "0") jstatus = "D";
          
            strsql = @"UPDATE  tbl_joindetail
                SET        tbl_joindetail.status =@jstatus           
                FROM              tbl_Joindata INNER JOIN
                                            tbl_joindetail ON tbl_Joindata.joinid = tbl_joindetail.joinid
                WHERE          tbl_Joindata.ord_code = @ord_code";
          
            nvc.Add("jstatus", jstatus);
            DbControl.Data_add(strsql, nvc);

      
        

        LinkButton obj = sender as LinkButton;
        selectSQL();
        MultiView1.ActiveViewIndex = 0;
    }
    protected void Btn_cancel_Click(object sender, System.EventArgs e)
    {

        MultiView1.ActiveViewIndex = 0;
    }

    protected void btn_search_Click(object sender, EventArgs e)
    {
        //        string.Contains("pattern") is equivalent to LIKE '%pattern%'
        //string.StartsWith("pattern") is equivalent to LIKE 'pattern%'
        //string.EndsWith("pattern") is equivalent to LIKE '%pattern'
       selectSQL();
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


    public void selectSQL(string sorttype = "desc", string sortColumn = "ord_id")
    {

        NameValueCollection nvc = new NameValueCollection();
        string strsql = @" SELECT  *  FROM   tbl_OrderData INNER JOIN
                      tbl_payStatus ON tbl_OrderData.status =tbl_payStatus.id  where ord_id > 0 ";
        if ( qpaykind.SelectedIndex > 0)
        {
            strsql += " and paymode= '" + qpaykind.SelectedValue + "' ";
        }
        if (qstatus .SelectedIndex > 0)
        {
            strsql += " and tbl_OrderData.status= '" +  qstatus .SelectedValue + "' ";
        }
        if (strdate.Text != "")   strsql += " and ord_date >= '" + strdate.Text  + "'";               
        if (enddate.Text != "")   strsql += " and ord_date <= '" +  enddate.Text + "'";        
      
        if (keyword.Text != "")
        {
            strsql += " and ( ord_code like '%'+@S+'%'  or ordname like '%'+@S+'%' or email like '%'+@S+'%' or shipname like '%'+@S+'%' or ordphone like '%'+@S+'%' ) ";
           
            //SqlDataSource3.SelectParameters.Add("S", keyword.Text);
            nvc.Add("S", keyword.Text);
        }
        if (price.Text != "")
        {
            strsql += " and TotalPrice=@price ";

           
            nvc.Add("price", price.Text);
        }
        if (kind.SelectedValue == "P")
        {
            strsql += " and ord_id in (select ord_id from tbl_OrderDetail) ";
        }
        else if (kind.SelectedValue == "L")
        {
            strsql += " and ord_id not in (select ord_id from tbl_OrderDetail) ";
        }
       
        string sql_select = strsql + " ORDER BY  " + sortColumn + " " + sorttype;
        DataTable dt = DbControl.Data_Get(sql_select, nvc);
        ListView1.DataSource = dt;
        ListView1.DataBind();
     
        dt = DbControl.Data_Get(strsql.Replace ("*", "COUNT(*), SUM(totalprice)"), nvc);
        Literal1.Text = "<b> 訂單筆數:" + dt.Rows[0][0].ToString() + "   訂單金額合計:" + dt.Rows[0][1].ToString() + "</b>" ;
    

    }
    protected void ContactsListView_PagePropertiesChanging(object sender,  PagePropertiesChangingEventArgs e)
    {
        var pager = (DataPager)ListView1.FindControl("DataPager1");
        pager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        selectSQL();
    }

    protected void btn_search_click(object sender, EventArgs e)
    {
       selectSQL();
    }



    public string get_ld(string ord_code)
    {
        string msg = "";
        LessonLib.JoinData o = LessonLib.Web.Get_ord_JoinData(ord_code);
        if (o .Articleid != 0)
        {
            foreach (article.LessonDetail d in o.LessonData.LessonDetail)
            {

                var data = o.JoinDetail.Find(y => y.LessonId == d.LessonId);
                msg = o.LessonData.MainData.Subject + d.Description ;

            }

        }
 
          
        return msg;
    }

    public string get_pd(string ord_code)
    {
        string msg = "";
        string strsql = @"SELECT cast(tbl_productdata.productname AS NVARCHAR) + ','
        FROM tbl_productdata INNER JOIN tbl_orderdetail ON  tbl_productdata.p_id = tbl_orderdetail.p_id
        WHERE tbl_orderdetail.ord_code = @ord_code
        FOR XML PATH('') ";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("ord_code", ord_code);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
   
        if (dt.Rows.Count >0 )   msg = dt.Rows[0][0].ToString ();
        return msg;
    }



    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Button b1 = (Button)e.Item.FindControl("Button1");
            System.Data.DataRowView rowView = e.Item.DataItem as System.Data.DataRowView;

        }
   
   
    }






    protected void Button1_Click(object sender, EventArgs e)
    {
       
        o = OrderLib.Get_ordData(Selected_id.Value);


        string ord_code = o.Ord_code ;
        string site_name = HttpContext.Current.Application["site_name"].ToString();
        string filename = HttpContext.Current.Server.MapPath("/templates/letter.html");
        DataTable dt = unity.classlib.Get_Message(14);
        LessonLib.JoinData l = LessonLib.Web.Get_ord_JoinData(o.Ord_code);
     
        string mailsubject = dt.Rows[0]["title"].ToString();
        string mailbody = dt.Rows[0]["contents"].ToString();
        mailsubject = mailsubject.Replace("@classname@",   get_ld(o.Ord_code));
        mailbody = mailbody.Replace("@classname@", get_ld(o.Ord_code));
        mailbody = mailbody.Replace("@username@", o.Ordname );
        mailbody = mailbody.Replace("@url@", "<a href=\"http://www.culturelaunch.net/Class/" + l.LessonData.MainData.Id + "\">http://www.culturelaunch.net/Class/" + l.LessonData.MainData.Id + "</a>");
        string textbody = unity.classlib.GetTextString(filename);
        mailbody = textbody.Replace("@mailbody@", mailbody);
        string msg = unity.classlib.SendsmtpMail(o.Ordemail , mailsubject, mailbody, "gmail");
        outfile = "<script>alert('己送出');</script>";

    }

    protected void Button2_Click(object sender, EventArgs e)
    {
       
        o = OrderLib.Get_ordData(Selected_id.Value);
        string ord_code = o.Ord_code;
        string site_name = HttpContext.Current.Application["site_name"].ToString();
        string filename = HttpContext.Current.Server.MapPath("/templates/letter.html");
        DataTable dt = unity.classlib.Get_Message(15);
        LessonLib.JoinData l = LessonLib.Web.Get_ord_JoinData(o.Ord_code);
        string mailsubject = dt.Rows[0]["title"].ToString();
        string mailbody = dt.Rows[0]["contents"].ToString();

        mailsubject = mailsubject.Replace("@classname@", l.LessonData.MainData.Subject);
        mailbody = mailbody.Replace("@classname@", l.LessonData.MainData.Subject);
        mailbody = mailbody.Replace("@username@", o.Ordname);
        mailbody = mailbody.Replace("@url@", "<a href=\"http://www.culturelaunch.net/Class/" + l.LessonData.MainData.Id + "\">http://www.culturelaunch.net/Class/" + l.LessonData.MainData.Id + "</a>");
        string textbody = unity.classlib.GetTextString(filename);
        mailbody = textbody.Replace("@mailbody@", mailbody);
        string msg = unity.classlib.SendsmtpMail(o.Ordemail, mailsubject, mailbody, "gmail");
        outfile = "<script>alert('己送出');</script>";
    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        o = OrderLib.Get_ordData(Selected_id.Value);
        string ord_code = o.Ord_code;
        DataTable dt = unity.classlib.Get_Message(17);
        LessonLib.JoinData l = LessonLib.Web.Get_ord_JoinData(o.Ord_code);
        string smsbody = dt.Rows[0]["contents"].ToString();
     
        smsbody = smsbody.Replace("@username@", l.OrderData.Ordname);
    // smsbody = smsbody.Replace("@date@", l.LessonData.StartDay.ToString ("MM月dd日") );
        smsbody = smsbody.Replace("@classtime@",l.LessonData.Lessontime  );
        smsbody = smsbody.Replace("@classname@", l.LessonData.MainData.Subject);
        classlib.Log_Sms log = classlib.Sendsms(l.OrderData.Ordphone, smsbody);
        string strsql = "update log_SMS set ord_code= @ord_code where msgid=@msgid";
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("msgid", log.Msgid);
        nvc.Add("ord_code", o.Ord_code);
        DbControl.Data_add(strsql, nvc);
        outfile = "<script>alert('己送出');</script>";
    }
}