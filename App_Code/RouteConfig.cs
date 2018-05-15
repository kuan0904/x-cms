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
            
        }
    }
   

    public class MyWebFormsFriendlyUrlResolver : WebFormsFriendlyUrlResolver
    {
        public MyWebFormsFriendlyUrlResolver() { }

        public override string ConvertToFriendlyUrl(string path)
    {   /// /// 把ckfinder文件夹从FriendlyUrl机制中排除掉，防止出现The uploaded file is corrupt错误 /// /// /// 
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