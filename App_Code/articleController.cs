using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

[EnableCors(origins: "*", headers: "*", methods: "*")]
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
    }
  
    [ActionName("Getwebmenu")]
    public object Getwebmenu()
    {
        return Unitlib.Get_menu();
        // string result = JsonConvert.SerializeObject(hotlist);
    }

    [ActionName("SocialShare")]
    [HttpPost] // post方法二
    public object SocialShare(dynamic obj)
    {

        article.Web.Add_Socialshare (Convert.ToString(obj.id), Convert.ToString(obj.kind), Convert.ToString(obj.url));
        return "";
    }


    [ActionName("AddCollection")]
    [HttpPost] // post方法二
    public object AddCollection(dynamic obj)
    {

        article.Web.Add_Collection (Convert.ToString(obj.id), Convert.ToString(obj.memberid));
        return "";
    }


    [ActionName("Getbanner")]
    public object Getbanner(int id = 1)
    {
        List<Banner.MainData> banner1 = new List<Banner.MainData>();
        banner1 = Banner.DbHandle.Banner_Get_list(id);
        return banner1;
        // string result = JsonConvert.SerializeObject(hotlist);
    }
    // [Route("api/GetPopular/ID/{id:int}")]    
    [ActionName("Popular")]
    public object GetPopular(int id = 0)
    {
        ;
        List<article.MainData> hotlist = new List<article.MainData>();
        hotlist = article.DbHandle.Get_article_list(id.ToString (), "", 5, 1);

        return hotlist;
       
    }
    [ActionName("Recommad")]
    public object GetRecommad(int id = 0)
    {
        List<Banner.MainData> banner1 = new List<Banner.MainData>();
        banner1 = Banner.DbHandle.Banner_Get_list(id);
        return banner1;

    }

}

