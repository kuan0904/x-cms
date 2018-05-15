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
       
      //      Response.Redirect(url);
        //   Response.Redirect(Context.Request.Url.ToString().Replace("http://", "https://"));

        }
    }
 </script>
