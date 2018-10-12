using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class member_class_detail : System.Web.UI.Page
{
    public string htmlstr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["memberdata"] != null)
        {
            MemberLib.Mmemberdata m = (MemberLib.Mmemberdata)Session["memberdata"];
            LessonLib.JoinData o= LessonLib.Web.Get_ord_JoinData (Request.QueryString["ord_code"]);
    

            if (m.Memberid.ToString() == o.OrderData.Memberid )
            {
                htmlstr = unity.classlib.GetTextString(Server.MapPath("/templates/Lessondata.html"));
                htmlstr = htmlstr.Replace("@ord_code@", o.Ord_code);
                htmlstr = htmlstr.Replace("@ordername@", o.OrderData.Ordname );
                htmlstr = htmlstr.Replace("@ordermail@", o.OrderData.Ordemail);
                htmlstr = htmlstr.Replace("@orderphone@", o.OrderData.Ordphone);
                htmlstr = htmlstr.Replace("@shipname@", o.OrderData.Ordname);
                htmlstr = htmlstr.Replace("@shipphone@", o.OrderData.Ordphone);
                htmlstr = htmlstr.Replace("@shipaddress@", o.OrderData.Ordaddress);
                htmlstr = htmlstr.Replace("@TotalPrice@", "NT$:" + o.OrderData.TotalPrice.ToString());
                htmlstr = htmlstr.Replace("@paymode@", OrderLib.getPaymode(o.OrderData.Paymode));
                htmlstr = htmlstr.Replace("@ShipPrice@", o.OrderData.ShipPrice.ToString());
                htmlstr = htmlstr.Replace("@delivery_kind@", OrderLib.getdelivery_kind(o.OrderData.Delivery_kind));
                string detailstr = "";
                foreach(LessonLib.JoinDetail d in  o.JoinDetail  )
                {
                  }
                htmlstr = htmlstr.Replace("@detail@", detailstr);
            }





        }
    }
}