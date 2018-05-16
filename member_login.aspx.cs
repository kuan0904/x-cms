using System;
using System.Configuration;
public partial class member_login : System.Web.UI.Page
{
    string FacebookAppId = "365173480244176"; //正式環境
   
    protected void Page_Load(object sender, EventArgs e)
    {
        Session ["returnurl"]  =      Request.QueryString ["page"];
        FacebookAppId = "1155212207854130"; //開發環境
        //FacebookAppSecret = "12851287e37ab68d499d892256c1ef7e";
        fb_login.NavigateUrl = "https://www.facebook.com/v2.4/dialog/oauth/?client_id=" + FacebookAppId + "&redirect_uri=http://" + Request.ServerVariables["SERVER_NAME"] + "/fb_login.ashx&page=123&response_type=code&state=1";
        if (Session["memberid"] != null )
        {
            Response.Redirect("Member_center.aspx");
        }
    }
}