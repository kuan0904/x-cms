using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class member_order_detail : System.Web.UI.Page
{
    public string htmlstr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["memberdata"] != null)
        {
            MemberLib.Mmemberdata m = (MemberLib.Mmemberdata)Session["memberdata"];
            OrderLib.OrderData o = OrderLib.Get_ordData(Request.QueryString["ord_code"]);
          
            if (m.Memberid.ToString() == o.Memberid)
            {
                htmlstr = unity.classlib.GetTextString(Server.MapPath("/templates/orderdata.html"));
                htmlstr = htmlstr.Replace("@ord_code@", o.Ord_code);
                htmlstr = htmlstr.Replace("@ordername@", o.Ordname);
                htmlstr = htmlstr.Replace("@ordermail@", o.Ordemail);
                htmlstr = htmlstr.Replace("@orderphone@", o.Ordphone);
                htmlstr = htmlstr.Replace("@shipname@", o.Ordname);
                htmlstr = htmlstr.Replace("@shipphone@", o.Ordphone );
                htmlstr = htmlstr.Replace("@shipaddress@", o.Ordaddress);
                htmlstr = htmlstr.Replace("@TotalPrice@", "NT$:" + o.TotalPrice.ToString ());
                htmlstr = htmlstr.Replace("@paymode@", OrderLib.getPaymode ( o.Paymode) );
                htmlstr = htmlstr.Replace("@ShipPrice@", o.ShipPrice.ToString ());
                htmlstr = htmlstr.Replace("@delivery_kind@", OrderLib.getdelivery_kind (o.Delivery_kind));
                string detailstr = "";
               foreach (var d in o.OrderDetail)
                {
                    detailstr += "<tr><td>"+ d.P_name  + "</td><td>" + d.Price.ToString () + "</td><td>" + d.Num .ToString () + "</td><td>"+ d.Amount .ToString () +"</td></tr>";
                }
                htmlstr = htmlstr.Replace("@detail@", detailstr);
            }
           
       }
    }
}