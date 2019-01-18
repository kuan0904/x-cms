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
     

    }
}