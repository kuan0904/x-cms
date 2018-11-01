using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
public partial class admin_Default : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Session["userid"] == null)
        {
            Response.Redirect("~/account/login.aspx?ReturnUrl=" + Request.RawUrl.ToString());
            Response.End();
        }

      


    }



}