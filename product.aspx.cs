using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using unity;
using System.Collections.Specialized;
using System.Text.RegularExpressions;
using System.Web.Routing;
public partial class product : System.Web.UI.Page
{
    public Unitlib.MainData s = new Unitlib.MainData();
    public string shippingKind = "";
    public int ship_price = 0;
    public int p_id = 0;
    public int price = 0;
    public int amount = 0;
    public int freeship = 0;
    public string productname = "";
    public string description = "";
    public string pic = "";
    public string packageid = "";
    public string DESCRIPTION = "";
    public string HOWTOUSE = "";
    public string ReMark = "";
    public string Refunds = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        packageid = Request["packageid"];       
        Route myRoute = RouteData.Route as Route;
        if (myRoute != null)
        {
            packageid  = RouteData.Values["id"].ToString();
        }
        if ( packageid == null || packageid == "")
        {
            Response.Write("<script>alert('資料有誤');</script>");
            Response.End();
        }
        List<  productController.Package> gd = new List<productController.Package>();
        productController.Package pd = new productController.Package();
        pd.Packageid = int.Parse (packageid);
        gd = productController.GetPackageList(pd);
        string pic = "";
        foreach (var g in gd)
        {
            if (g.Status != "Y")
                {
                    Response.Write("<script>alert('此商品並無販售');history.back();</script>");
                    Response.End();

                }
            productname = g.Packagename;
            description = g.Description;           
            ship_price = g.Shippingfee;
            shippingKind = g.ShippingKind;
            DESCRIPTION = g.Description;
            freeship = g.Freeship;
            Repeater1.DataSource = g.PackageItem ;
            Repeater1.DataBind();
            pic = g.PackageItem[0].Pic;
            ReMark = g.ReMark;
            Refunds = g.Refunds;

           
        }

        Session["title"] = productname + "│" + Application["site_name"];      
        Session["image"] = Session["websiteurl"] + pic;    
        Session["description"] = unity.classlib.noHTML(description);
        Session["keywords"] = productname;

      
        s = Unitlib.Get_UnitData(37, "");
       











    }

}