using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;


public partial class spadmin_menu : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {
        if (Session["userid"] == null)
        {
            Response.Write ("<script>location.href='/account/login.aspx?ReturnUrl='</script>");
            Response.End();
        }

        if (!IsPostBack)
        {
           
            //------第一層------
            string strsql = "";
            //Or Session("userid") = "2"
            if (Session["userid"].ToString() == "1")
            {
                //不分權限
                strsql = "SELECT * FROM  UnitData ";
                strsql += " where  adminpage is  not null  and unitdata.upperid = 0  and adminpage <> '' ";
                strsql += "  order by sort ";
            }
            else {
                //第二層有權限的
                strsql = "SELECT distinct u1.unitname, u1.unitid FROM UnitData as u1 ";
                strsql += " INNER JOIN UnitData as u2 on u2.upperid = u1.unitid ";
                strsql += " INNER JOIN PowerList ON PowerList.unitid = u2.unitid";

                strsql += " where  u1.upperid = 0  and u1.adminpage <> '' and u2.adminpage <> '' and u1.adminpage is not null  and u2.adminpage is not null ";
                strsql += " and user_id = " + Session["userid"].ToString() + " and u1.status<>'D' and u2.status<>'D'  ";
            }

            SqlDataSource1.SelectCommand = strsql;

        }

    }
    protected void R1_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
    {

        if (e.Item.ItemType != ListItemType.Footer && e.Item.ItemType != ListItemType.Header)
        {
            SqlDataSource SqlDataSource2 = (SqlDataSource)e.Item.FindControl("SqlDataSource2");
            Repeater Repeater2 = (Repeater)e.Item.FindControl("Repeater2");
            HiddenField Hidden_id = (HiddenField)e.Item.FindControl("Hidden_id");
            DataRowView row = (DataRowView)e.Item.DataItem;
            string unitid = row["unitid"].ToString();
            string strsql = null;
            // Or Session("userid") = "2"
            if (Session["userid"].ToString() == "1")
            {
                //不分權限
                strsql = "SELECT * FROM UnitData ";
                strsql += " where  unitdata.upperid=" + unitid + " and  adminpage is not null  and adminpage <> '' ";
                strsql += "and status<>'D'  order by sort ";
            }
            else {
                strsql = "SELECT * FROM PowerList INNER JOIN UnitData ON PowerList.unitid = UnitData.unitid ";
                strsql += " where  adminpage is not null  and adminpage <> '' ";
                strsql += " and  unitdata.upperid=" + unitid ;
                strsql += " and user_id = " + Session["userid"].ToString() + " and status<>'D' order by sort ";
            }


            SqlDataSource2.SelectCommand = strsql;
            Repeater2.DataBind();

        }
    }


}