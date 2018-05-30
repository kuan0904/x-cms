using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TopBanner : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        List<Banner.MainData> banner1 = new List<Banner.MainData>();
        banner1 = Banner.DbHandle.Banner_Get_list(1);
        Repeater1.DataSource = banner1;
        Repeater1.DataBind();
        banner1.Clear();
    }
}