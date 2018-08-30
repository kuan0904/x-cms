using Microsoft.Owin;
using Owin;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Net.Http.Headers;
using Newtonsoft.Json.Serialization;

[assembly: OwinStartupAttribute(typeof(MyPublic.Startup))]
namespace MyPublic
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
            HttpConfiguration config = new HttpConfiguration();
            WebApiConfig.Register(config);
            app.UseWebApi(config);
        }
    }
    public class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            config.MapHttpAttributeRoutes();

        
            config.Routes.MapHttpRoute(
            name: "DefaultApi",
                  routeTemplate: "api/{controller}/ID/{id}",
                  defaults: new { id = System.Web.Http.RouteParameter.Optional }
             );
            config.Routes.MapHttpRoute(
            name: "DefaultApi1",
            routeTemplate: "api/{controller}/{action}/{id}",
            defaults: new { action = "Default", id = System.Web.Http.RouteParameter.Optional });

        
            GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.Clear();

            var cors = new EnableCorsAttribute("*", "*", "*") //打開cors
            {
                SupportsCredentials = true //允許ajax可以傳送cookie
            };
            config.EnableCors(cors);
            config.Formatters.JsonFormatter.SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/html"));//永遠使用json
            config.Formatters.JsonFormatter.SerializerSettings.ContractResolver = new CamelCasePropertyNamesContractResolver();//預設直接把首字改小寫
            config.Formatters.JsonFormatter.UseDataContractJsonSerializer = false;
        }
    }
}
