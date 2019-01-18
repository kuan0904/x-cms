using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class login : System.Web.UI.Page
{
    public string fblogin = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string returnurl = (Request.QueryString["page"] != null) ? Request.QueryString["page"] : "";
        fblogin = "https://www.facebook.com/v2.10/dialog/oauth/?client_id=164103481107660&redirect_uri=https://www.culturelaunch.net/fb_login.ashx&response_type=code";


    }
}