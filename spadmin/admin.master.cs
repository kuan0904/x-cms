using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
using System.Collections.Specialized;

public partial class spadmin_admin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (Session["userid"] == null)
            {
                Response.Redirect("~/account/login.aspx?ReturnUrl=" + Request.RawUrl.ToString());
                Response.End();
            }

    
           


                //------第一層------
                string strsql = "";
               
                if (Session["userid"].ToString() == "1")
                {
                    //不分權限
                    strsql = @"SELECT *,(select count(*) from unitdata a where a.upperid= b.unitid) as rows 
                    FROM  UnitData b
                     where  adminpage is  not null  and b.upperid = 0  and adminpage <> ''
                      order by sort ";
                }
                else {
                    //第二層有權限的
                    strsql = @"SELECT distinct u1.unitname, u1.unitid,
                    (select count(*) from unitdata a where a.upperid= b.unitid) as rows 
                    FROM  UnitData b FROM UnitData as u1
                            INNER JOIN UnitData as u2 on u2.upperid = u1.unitid  
                            INNER JOIN PowerList ON PowerList.unitid = u2.unitid 
                            where  u1.upperid = 0  and u1.adminpage <> '' and u2.adminpage <> '' 
                            and u1.adminpage is not null  and u2.adminpage is not null 
                            and user_id = ";

                  strsql  += Session["userid"].ToString() + " and u1.status<>'D' and u2.status<>'D'  ";
                }

               SqlDataSource1.SelectCommand = strsql;
                SqlDataSource1.DataBind();

    }


    public static string Set_active(string unitid ,  string thisid)
    {
        string msg = "";
        if (thisid == unitid)
        {
            msg = "class=\"active\"";

        }
        if (thisid != null)
        {
            string strsql = "select * from unitdata where unitid=" +  thisid;
            NameValueCollection nvc = new NameValueCollection();
            DataTable dt = admin_contrl.Data_Get(strsql, nvc);
            if (dt.Rows.Count >0)
            {
                if (dt.Rows [0]["upperid"].ToString () == unitid)
                {
                    msg = "class=\"active open\"";

                }
            }
            dt.Dispose();
            nvc.Clear();
        }
      
        return msg;

    }
    public static string Set_submenu(string unitid,string userid,string thisid)
    {
        string strsql = "";
        if (userid == "1")
        {
            //不分權限
            strsql = "SELECT * FROM UnitData ";
            strsql += " where  unitdata.upperid=" + unitid + " and  adminpage is not null  and adminpage <> '' ";
            strsql += "and status<>'D'  order by sort ";
        }
        else
        {
            strsql = "SELECT * FROM PowerList INNER JOIN UnitData ON PowerList.unitid = UnitData.unitid ";
            strsql += " where  adminpage is not null  and adminpage <> '' ";
            strsql += " and  unitdata.upperid=" + unitid;
            strsql += " and user_id = " + userid + " and status<>'D' order by sort ";
        }
        NameValueCollection nvc = new NameValueCollection();
        DataTable dt = admin_contrl.Data_Get(strsql, nvc);
        string itemdata = "";
        if (dt.Rows.Count > 0)    
        {
            itemdata = "<ul class=\"submenu\">";
            int i= 0;
            for (i = 0; i < dt.Rows.Count; i++)
            {
                itemdata += "<li ";
                if (thisid == dt.Rows[i]["unitid"].ToString() ) itemdata += "class=\"active\"";
                itemdata += " ><a href = \"" + dt.Rows[i]["adminpage"].ToString();
                itemdata += "?unitid=" + dt.Rows[i]["unitid"].ToString();
                if (dt.Rows[i]["ifram"].ToString() == "Y") itemdata +=  " class=\"iframe\" " ;
                itemdata +=   "\">";              
                itemdata += "<i class=\"icon-double-angle-right\"></i>" + dt.Rows[i]["unitname"].ToString() + "</a></li>";        
            }
            itemdata += "</ul>";
            
        }
        dt.Dispose();
        nvc.Clear ();
        return itemdata ;
    }

    protected void ImageButton_SignOut_Click(object sender, EventArgs e)
    {
        Response.Redirect("SignOut.aspx");
    }
}
