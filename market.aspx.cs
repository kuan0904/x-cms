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

public partial class market : System.Web.UI.Page
{
    public string shippingKind = "";
    public int ship_price = 0;
    public int p_id = 0;
    public int price = 0;
    public int amount = 0;
    public int freeship = 0;
    public string productname = "";
    public string description = "";
    public string pic = "";
    public string pic1 = "";
    public string pic2 = "";
    public string pic3 = "";
    public string productcode = "";
    public string DESCRIPTION = "";
    public string HOWTOUSE = "";
    public string MEMO = "";
    public string videourl = "";
    public int stocknum = 100;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["p_id"] == null || Request["p_id"] == "")
        {
            Response.Write("<script>alert('資料有誤');</script>");
            Response.End();
        }
        p_id = int.Parse(Request["p_id"]);
        productController.MainData pd = productController.GetProduct(p_id.ToString());


        if (pd.Status  != "Y")
        {
            Response.Write("<script>alert('此商品並無販售');history.back();</script>");
            Response.End();

        }
        if (pd.Storage  == 0)
        {
            Response.Write("<script>alert('此商品販售完畢');history.back();</script>");
            Response.End();

        }


        productcode = pd.Productcode ;
        videourl =pd.Videourl ;
        if (videourl.IndexOf("youtube") > 0)
        {

            string videoid = videourl.Substring(videourl.IndexOf("?v=") + 3, videourl.Length - videourl.IndexOf("?v=") - 3);
            videourl = "<div class=\"video-container\"><iframe class=\"media\" width = \"854\" height = \"480\" src = \"https://www.youtube.com/embed/" + videoid + "?rel=0&autoplay=1\" frameborder = \"0\" allowfullscreen></iframe></div>";
        }
        if (pd.Storage  < 100) stocknum = pd.Storage ;

        productname = pd.Productname ;
        description = pd.Description; 
              
        pic1 =  pd.Pic  + "?" + DateTime.Now.ToString()  ;
        ship_price = pd.Shippingfee ;      
        price = pd.Price ;
        freeship = pd.Freeship ;
        if (price > freeship) ship_price = 0;
        amount = price + ship_price;
        shippingKind = pd.ShippingKind ;
        DESCRIPTION = pd.Description ;
        MEMO = pd.Memo;
      

        List<productController.MainData> pdlsit = new List<productController.MainData>
        {
            pd
        };
        foreach (string  s in pd.Groupcode)
        {
           if (s.Trim() != "")
           pdlsit.Add(productController.GetProduct(s));
        }
        Repeater1.DataSource = pdlsit;
        Repeater1.DataBind();

    }
}