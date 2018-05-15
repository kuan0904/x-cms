using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class spadmin_SignOut : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["userid"] = null;
        Session["username"] = null;
        Session.Abandon();

        var ctx = Request.GetOwinContext();
        var authenticationManager = ctx.Authentication;
        authenticationManager.SignOut();

        Response.Redirect("~/account/login.aspx");
        Response.End();
    }
}