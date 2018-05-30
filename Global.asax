<%@ Application Language="C#" %>
<%@ Import Namespace="MyPublic" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        BundleConfig.RegisterBundles(BundleTable.Bundles);

    }
    protected void Application_BeginRequest()
    {
          if (!Context.Request.IsSecureConnection)
        {
            // 轉到SSL 看要REWRITE還是GLOBAL設定   
            string url = Request.Url.ToString().Replace("http://", "https://");
       
      //  RegisterRoutes(RouteTable.Routes);
      //      Response.Redirect(url);
        //   Response.Redirect(Context.Request.Url.ToString().Replace("http://", "https://"));

        }
    }
    void RegisterRoutes(RouteCollection routes)
{
    /*  Create a routing which maps SayHello to ShowGreeting.aspx
        and defines 2 parameters, greeting and name. */
    routes.MapPageRoute("ShowGreetingRoute",
        "SayHello/{greeting}/{name}", 
        "~/ShowGreeting.aspx");
} 
 </script>
