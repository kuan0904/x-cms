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

            routes.MapPageRoute("article", "{unitname}/{id}", "~/detail.aspx",
                false, null,
                new RouteValueDictionary { { "id", "^[0-9]*$" }, { "unitname", "industry|culture|folkture|exhibtion|operate|design|crossborder|localizationLclassess" } });
   

            routes.MapPageRoute("listpage", "{unitname}/{*pageindex}", "~/list.aspx",
                 false, null,                 
                    new RouteValueDictionary { { "unitname", "News|Events|ArtMBA" }, { "pageindex", "^[0-9]*$" } }
                );

            routes.MapPageRoute("issue", "issue/{id}", "~/detail.aspx",
           false, null,
           new RouteValueDictionary { { "id", "[0-9]*" } });

            routes.MapPageRoute("integration", "integration/{id}", "~/detail.aspx",
           false, null,
           new RouteValueDictionary { { "id", "[0-9]*" } });


            routes.MapPageRoute("talent", "talent/{id}", "~/detail.aspx",
           false, null,
           new RouteValueDictionary { { "id", "[0-9]*" } });

            routes.MapPageRoute("fundraising", "fundraising/{id}", "~/detail.aspx",
           false, null,
           new RouteValueDictionary { { "id", "[0-9]*" } });
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