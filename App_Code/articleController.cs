using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
public class articleController : ApiController
{
    // GET api/<controller>
    public IEnumerable<string> Get()
    {
        return new string[] { "value1", "value2" };
    }

    
    public object  Get(int id)
    {
        object dd = article.DbHandle.Get_article(id);
        return dd; 
    }
    [ActionName("GetArticleList")]
    [HttpPost] // post方法二
    public object GetArticleList(dynamic obj)
    {
        //   return obj.cid;
        int Totalrow = 0;
        string cid = Convert.ToString(obj.cid);
        string keyword = obj.keyword == null ? "" : Convert.ToString(obj.keyword);
        int PageSize = obj.pagesize == null ? 5 : Convert.ToInt16(obj.pagesize);
        int PageIdx = obj.idx == null ? 1 : Convert.ToInt16(obj.idx);
        List<article.MainData> hotlist = new List<article.MainData>();

        hotlist = article.DbHandle.Get_article_list(cid, keyword, PageSize, PageIdx);

        foreach (var p in hotlist)
        {


            Totalrow = p.TotalRows;
            break;
        }


        return hotlist;
        // string result = JsonConvert.SerializeObject(hotlist);
    }

    [ActionName("Getwebmenu")]
    public object Getwebmenu()
    {
        return unitlib.Get_menu();
        // string result = JsonConvert.SerializeObject(hotlist);
    }
    [ActionName("Getbanner")]
    public object Getbanner(int id = 1)
    {
        List<Banner.MainData> banner1 = new List<Banner.MainData>();
        banner1 = Banner.DbHandle.Banner_Get_list(1);
        return banner1;
        // string result = JsonConvert.SerializeObject(hotlist);
    }
}

