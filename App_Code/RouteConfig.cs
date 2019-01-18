using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;
using Microsoft.AspNet.FriendlyUrls.Resolvers;

namespace MyPublic
{
   
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            // settings.AutoRedirectMode = RedirectMode.Off;
         
            //routes.EnableFriendlyUrls(settings);
            routes.EnableFriendlyUrls(settings, new Microsoft.AspNet.FriendlyUrls.Resolvers.IFriendlyUrlResolver[] { new MyWebFormsFriendlyUrlResolver() });

            routes.MapPageRoute("article", "Article/{Articleid}", "~/detail.aspx",false, null,new RouteValueDictionary { { "Articleid", "^[0-9]*$" } });
            routes.MapPageRoute("class", "Class/{Articleid}", "~/detail-course.aspx", false, null,new RouteValueDictionary { { "Articleid", "^[0-9]*$" } });
            routes.MapPageRoute("buy", "1shop/{id}", "~/product.aspx", false, null,
            new RouteValueDictionary { { "id", "^[0-9]*$" } });

            routes.MapPageRoute("list", "news/{id}", "~/list-text.aspx", false, null,
            new RouteValueDictionary { { "id", "^[0-9]*$" }});
            routes.MapPageRoute("listpage", "news/{id}/page/{*pageindex}", "~/list-text.aspx", false, null,
             new RouteValueDictionary { { "id", "^[0-9]*$" }, { "pageindex", "^[0-9]*$" } });

            routes.MapPageRoute("catalog", "catalog/{cid}", "~/list.aspx", false, null,
            new RouteValueDictionary { { "id", "^[0-9]*$" } });
            routes.MapPageRoute("catalog_page", "catalog/{cid}/page/{*pageindex}", "~/list.aspx", false, null,
            new RouteValueDictionary { { "id", "^[0-9]*$" }, { "pageindex", "^[0-9]*$" } }  );

            routes.MapPageRoute("grid", "emba/{cid}", "~/list-grid.aspx", false, null,
            new RouteValueDictionary { { "id", "^[0-9]*$" } });
            routes.MapPageRoute("grid_page", "emba/{cid}/page/{*pageindex}", "~/list-grid.aspx", false, null,
            new RouteValueDictionary { { "id", "^[0-9]*$" }, { "pageindex", "^[0-9]*$" } });

            routes.MapPageRoute("lesson", "lesson/{id}/page/{*pageindex}", "~/list-grid.aspx",
               false, null, new RouteValueDictionary { { "id", "^[0-9]*$" }, { "pageindex", "^[0-9]*$" } });

            routes.MapPageRoute("process-step", "class/Article/{ArticleId}/lesson/{lessonId}", "~/process-step1.aspx",
                false, null,new RouteValueDictionary { { "ArticleId", "^[0-9]*$" }, { "lessonId", "^[0-9]*$" } }   );
            //routes.MapPageRoute("listpage", "{unitname}/{*pageindex}", "~/list.aspx", false, null,                 
            //        new RouteValueDictionary {
            //{ "unitname", "catalog|industry|culture|folkart|exhibtion|perform|practice|operate|design|crossborder|localization|classess|News|Events|ArtMBA" }
            //, { "pageindex", "^[0-9]*$" } });

            routes.MapPageRoute("search", "search/{keyword}/{*pageindex}", "~/list-search.aspx",  false, null,
                new RouteValueDictionary { { "pageindex", "^[0-9]*$" } });
            routes.MapPageRoute("unitdata", "page/{pagename}", "~/unitdata.aspx", false,null);

            routes.MapPageRoute("Copyright", "CopyRight/{id}", "~/unitdata.aspx", true, new RouteValueDictionary { { "id", "22" } });
            routes.MapPageRoute("aboutus", "AboutUs/{id}", "~/unitdata.aspx", true,new RouteValueDictionary { { "id", "20" } });
            routes.MapPageRoute("Advertisement", "Advertisement/{id}", "~/unitdata.aspx", true, new RouteValueDictionary { { "id", "21" } });
        }
    }
  


    public class MyWebFormsFriendlyUrlResolver : WebFormsFriendlyUrlResolver
    {
        public MyWebFormsFriendlyUrlResolver() { }

        public override string ConvertToFriendlyUrl(string path)
    {   /// /// 把ckfinder文件夾以FriendlyUrl機制中排除掉，防止出现The uploaded file is corrupt错误 /// /// /// 
        if (!string.IsNullOrEmpty(path))
            {
                   if (path.ToLower().Contains("/spadmin") || path.ToLower().Contains("/editor") || path.ToLower().Contains("/ckfinder") )
                { // Here the filter code
                    return path;
                }
            }
            return base.ConvertToFriendlyUrl(path);
        }
    }
}