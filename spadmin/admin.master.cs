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
        if (Session["userid"] == null || Session["Backmenu"] ==null || Session["Backmenu"].ToString () =="")
            {
                Response.Redirect("~/account/login.aspx?ReturnUrl=" + Request.RawUrl.ToString());
                Response.End();
            }

        Repeater1.DataSource = (DataTable)Session["Backmenu"];
        Repeater1.DataBind();


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
            DataTable dt = DbControl.Data_Get(strsql, nvc);
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
            strsql = @"SELECT * FROM UnitData 
            where  unitdata.upperid=@unitid and  adminpage is not null  and adminpage <> ''
            and status<>'D'  order by sort ";
        }
        else
        { 
            strsql = @"SELECT * FROM PowerList INNER JOIN UnitData ON PowerList.unitid = UnitData.unitid 
            where  adminpage is not null  and adminpage <> '' 
             and  unitdata.upperid=@unitid and PowerList.user_id =@user_id
          and status<>'D' order by sort "; 
        }
        NameValueCollection nvc = new NameValueCollection();
        nvc.Add("unitid", unitid);
        nvc.Add("user_id", userid);
        DataTable dt = DbControl.Data_Get(strsql, nvc);
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
                itemdata += "?unitid=" + dt.Rows[i]["unitid"].ToString() + "\""; 
                if (dt.Rows[i]["ifram"].ToString() == "Y") itemdata +=  " class=\"iframe\" " ;
                itemdata += ">";              
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
