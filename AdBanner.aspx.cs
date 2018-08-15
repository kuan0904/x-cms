using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdBanner : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string classid = Request ["classid"];
        if (classid != null)
        {
            List<Banner.MainData> banner1 = new List<Banner.MainData>();
            banner1 = Banner.DbHandle.AD_Get_list(int.Parse (classid));
            bannerlist.DataSource = banner1;
            bannerlist.DataBind();
            banner1.Clear();
        }
    }
}