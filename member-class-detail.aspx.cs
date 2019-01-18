using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using QR_Encode_Class;
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

                htmlstr = LessonLib.Web.Get_JoinData(Request.QueryString["ord_code"]);
            }

        }
    }
   
}