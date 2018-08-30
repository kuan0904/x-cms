<%@ Application Language="C#" %>
<%@ Import Namespace="MyPublic" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Web.Routing" %>
<%@ Import Namespace ="System.Data" %>
<%@ Import Namespace="System.Web.Http" %>
<%@ Import Namespace="System.Net.Http" %>
<script runat="server">
    void Session_Start(object sender,EventArgs e)
    {  DataTable dt;
        NameValueCollection nvc = new NameValueCollection();
        string strsql  = "SELECT * FROM   WebSiteInfo where webid= 'keywords' ";
        dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count !=0)
            Session ["keywords"] = dt.Rows[0]["value"].ToString ();
        dt.Dispose();
        strsql  = "SELECT * FROM   WebSiteInfo where webid= 'description' ";
        dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count !=0)
            Session ["description"] = dt.Rows[0]["value"].ToString ();
        dt.Dispose();

        strsql  = "SELECT * FROM   WebSiteInfo where webid= 'websiteurl' ";
        dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count !=0)
            Session ["websiteurl"] = dt.Rows[0]["value"].ToString ();
        dt.Dispose();

        Application["description"] = Session["description"];
        Application["keywords"] = Session["keywords"];

    }
    void Application_Start(object sender, EventArgs e)
    {
        Application["FacebookAppId"]   = "1764690486918673";
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        //  BundleConfig.RegisterBundles(BundleTable.Bundles);
        string strsql = "";
        DataTable dt;
        NameValueCollection nvc = new NameValueCollection();
        if (Application["category"] == null)
        {
            strsql = "SELECT * FROM  tbl_category where status='Y' ";

            dt = DbControl.Data_Get(strsql, nvc);
            Application["category"] = dt;
            dt.Dispose();
        }
        if (Application["site_name"] == null)
        {

            strsql = "SELECT * FROM   WebSiteInfo where webid= 'site_name' ";

            dt = DbControl.Data_Get(strsql, nvc);
            if (dt.Rows.Count !=0)
                Application["site_name"] = dt.Rows[0]["value"].ToString ();
            dt.Dispose();
        }

        // 在應用程式啟動時執行的程式碼     
        RouteTable.Routes.MapHttpRoute(
        name: "DefaultApi",
              routeTemplate: "api/{controller}/ID/{id}",
              defaults: new { id = System.Web.Http.RouteParameter.Optional }
         );
        RouteTable.Routes.MapHttpRoute(
        name: "DefaultApi1",
        routeTemplate: "api/{controller}/{action}/{id}",
        defaults: new { action = "Default", id =System.Web.Http.RouteParameter.Optional });

        GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.Clear();
        // var appXmlType = config.Formatters.XmlFormatter.SupportedMediaTypes.FirstOrDefault(t => t.MediaType == "application/xml");
        //config.Formatters.XmlFormatter.SupportedMediaTypes.Remove(appXmlType);
    }
    protected void Application_BeginRequest()
    {
        //  SqlKey myCheck = new SqlKey(this.Request); 
        //  bool a = myCheck.CheckRequestForm(); 
        //  bool b = myCheck.CheckRequestQuery(); 
        //  if (myCheck.CheckRequestForm() || myCheck.CheckRequestQuery()) 
        //  { 
        //   Response.Write("有"); 
        //  } 
        //  else 
        //  { 
        ////   Response.Write("無"); 
        //  } 
        //  if (!Context.Request.IsSecureConnection)
        //  {
        //      // 轉到SSL 看要REWRITE還是GLOBAL設定   
        //      string url = Request.Url.ToString().Replace("http://", "https://");

        //      //  RegisterRoutes(RouteTable.Routes);
        //      //      Response.Redirect(url);
        //      if (Request.Url.Host !="localhost") 
        //       Response.Redirect(Context.Request.Url.ToString().Replace("http://", "https://"));

        //  }
    }

 </script>
