﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {



        List<Banner.MainData> banner1 = new List<Banner.MainData>();
        banner1 = Banner.DbHandle.Banner_Get_list(1);
        Repeater1.DataSource  = banner1;
        Repeater1.DataBind();
        banner1.Clear();
        List<article.MainData> hotlist = new List<article.MainData>();
        hotlist = article.DbHandle.Get_article_list("", "", 5,1);
        hot_list_detail.DataSource = hotlist;
        hot_list_detail.DataBind();
        hotlist.Clear();

    }

}