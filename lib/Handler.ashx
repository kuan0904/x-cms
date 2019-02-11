<%@ WebHandler Language="C#" Class="Handler" %>

using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;
using System.Web;
using System.Collections.Generic;
    using System.Web.Script.Serialization;
public class Handler : IHttpHandler  {

    public void ProcessRequest (HttpContext context) {
      
        string  kind =  context.Request["kind"];
        if (kind == "contactus")
        {
           Unitlib .ContactData .ItemData itemData = new Unitlib .ContactData.ItemData();
            itemData.Email = context.Request["email"];
            itemData.Contents = context.Request["Contents"];
            itemData.Phone = context.Request["Phone"];
            itemData.Usermame = context.Request["username"];

            itemData.Secno = 0;
            itemData.Status = "Y";
            itemData = Unitlib .ContactData.Add ( itemData);
            context.Response.Write(new JavaScriptSerializer().Serialize(itemData));
        }
        if (kind == "bookingepeper")
        {
            string msg = DbControl.EmailRegist(context.Request["email"]);
            context.Response.Write("Y");
        }

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}