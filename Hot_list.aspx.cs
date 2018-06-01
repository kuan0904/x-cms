using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Hot_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        List<article.MainData> hotlist = new List<article.MainData>();
        hotlist = article.DbHandle.Get_article_list("", "", 5,1);

        news_hotlist.DataSource = hotlist;
        news_hotlist.DataBind();
        hotlist.Clear();
    }
}