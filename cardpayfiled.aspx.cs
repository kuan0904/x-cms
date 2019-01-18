using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using unity;
using System.IO;
using System.Collections.Specialized;
using SpGatewayHelper.Models;

public partial class carpayfiled : System.Web.UI.Page
{
    public string ord_code = "";
    public string ord_status = "";
    public OrderLib.OrderData o;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ord_code"] != null) ord_code = Session["ord_code"].ToString();
        if (Request.QueryString["ord_code"] != null) ord_code = Request.QueryString["ord_code"];
        if (ord_code == "") Response.End();
        ord_code = classlib.RemoveBadSymbol(ord_code);
        o = OrderLib.Get_ordData(ord_code);
        SpGatewayHelper.Models.TradeInfoLog log = OrderLib.Get_Tradelog(ord_code);
      
        string ord_id = o.Ord_id.ToString();
        temp_product.DataSource = o.OrderDetail;
        temp_product.DataBind();

    }
}