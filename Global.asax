<%@ Application Language="C#" %>
<%@ Import Namespace="MyPublic" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Web.Routing" %>
<%@ Import Namespace ="System.Data" %>
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
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        BundleConfig.RegisterBundles(BundleTable.Bundles);
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




    }
    protected void Application_BeginRequest()
    {
        SqlKey myCheck = new SqlKey(this.Request); 
        bool a = myCheck.CheckRequestForm(); 
        bool b = myCheck.CheckRequestQuery(); 
        if (myCheck.CheckRequestForm() || myCheck.CheckRequestQuery()) 
        { 
         Response.Write("有"); 
        } 
        else 
        { 
      //   Response.Write("無"); 
        } 
        if (!Context.Request.IsSecureConnection)
        {
            // 轉到SSL 看要REWRITE還是GLOBAL設定   
            string url = Request.Url.ToString().Replace("http://", "https://");

            //  RegisterRoutes(RouteTable.Routes);
            //      Response.Redirect(url);
            if (Request.Url.Host !="localhost") 
             Response.Redirect(Context.Request.Url.ToString().Replace("http://", "https://"));

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
