using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
public partial class member_edit : System.Web.UI.Page
{
  
    public string result = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["title"] = "個人資料修改│會員中心│" + Application["site_name"];
        if (Session["memberdata"] == null)
        {
            Response.Redirect("login.html?page=member");
        }
        else
        {
             MemberLib.Mmemberdata  memberdata = (MemberLib.Mmemberdata)Session["memberdata"] ;

            result = JsonConvert.SerializeObject(Session["memberdata"]);
           

        }
    }
}