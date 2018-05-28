using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;
using article;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
public partial class lib_Get_data : System.Web.UI.Page
{
    [WebMethod]
    public static string Get_tbl_article(string articleId)
    {
        article.MainData mainData = article.DbHandle.Get_article(int.Parse(articleId));
        string result = JsonConvert.SerializeObject(mainData);
        return (result);
    }
    [WebMethod]
    public static List<article.ItemData> Get_tbl_article_item(string articleId)
    {
        List<article.ItemData> ItemData = new List<article.ItemData>();
        ItemData = article.DbHandle.Get_article_item(int.Parse(articleId));
        string result = JsonConvert.SerializeObject(ItemData);
        return (ItemData);
    }

    [WebMethod]
    public static List<Banner.MainData >Get_banner_list(string ClassId)
    {
        List<Banner.MainData> MainData = new List<Banner.MainData>();
        MainData = Banner.DbHandle.Banner_Get_list (int.Parse(ClassId));
        string result = JsonConvert.SerializeObject(MainData);
        return (MainData);
    }
}