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


public partial class shoppingcart : System.Web.UI.Page
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
        string status = "";
        int storage = 0;
        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            conn.Open();
            string strsql = "SELECT * FROM tbl_productData WHERE p_id = @p_id ";
            SqlCommand cmd = new SqlCommand();
            SqlDataReader rs;
            cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.Add("p_id", SqlDbType.Int).Value = p_id;
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                if (rs["status"].ToString () != "Y")
                {
                    Response.Write("<script>alert('資料有誤');</script>");
                    rs.Close();
                    conn.Close();
                    Response.End();
                }
                productcode = rs["productcode"].ToString();
                videourl = rs["videourl"].ToString();
                if (videourl.IndexOf("youtube") > 0)
                {

                    string videoid = videourl.Substring(videourl.IndexOf("?v=") + 3, videourl.Length - videourl.IndexOf("?v=") - 3);
                    videourl = "<div class=\"video-container\"><iframe class=\"media\" width = \"854\" height = \"480\" src = \"https://www.youtube.com/embed/" + videoid + "?rel=0&autoplay=1\" frameborder = \"0\" allowfullscreen></iframe></div>";
                }
                if ((int)rs["storage"] < 100) stocknum = (int)rs["storage"];
            
                productname = rs["productname"].ToString();
                description = rs["description"].ToString();
                pic1 = rs["pic1"].ToString();
                pic2 = rs["pic2"].ToString();
                pic3 = rs["pic3"].ToString();
                if (pic1 != "")
                    pic = pic1;
                 pic1 = "<img src = \"upload/"+ pic1+ "?" + DateTime.Now.ToString() + "\"  class=\"img-responsive\">";
                if (pic2 != "")
                    pic2 = "<img src = \"upload/" + pic2 +"?" + DateTime.Now.ToString()  + "\" class=\"img-responsive\" >";
                if (pic3 != "")
                    pic3 = "<img src = \"upload/" + pic3 + "?" + DateTime.Now.ToString() + "\"  class=\"img-responsive\" >";
                ship_price =(int)rs["shippingfee"];
                storage = (int)rs["storage"];
                if (storage < 1) status = "-1";           
                price = (int)rs["price"];
                if (rs["freeship"].ToString() != "")    freeship = (int)rs["freeship"];
                if (price > freeship) ship_price = 0;
                amount = price + ship_price;
                shippingKind = rs["shippingKind"].ToString();
                 DESCRIPTION =rs["DESCRIPTION"].ToString();            
                MEMO = rs["MEMO"].ToString();
                if (rs["kindid"].ToString() == "2") {
                    NameValueCollection nvc = new NameValueCollection();
                    string[] strary = rs["id_list"].ToString().Split(';');
                    strsql = "select * from tbl_productData where status <> 'D'  and p_id in ( ";                  
                    for (int i = 0; i <  strary.Length ; i++)
                    {
                        if (strary[i].ToString().Trim () != "")
                        {
                            if (i > 0) strsql += ",";
                            strsql += strary[i];
                        }
                    }
                    strsql +=" )";
                
                    DataTable dt = DbControl .Data_Get (strsql, nvc);
                    Repeater1.DataSource = dt;
                    Repeater1.DataBind();
                    dt.Dispose();

                }
            }
            cmd.Dispose();
            rs.Close();

         

           
            conn.Close();
          
        }
        if (status == "-2")
        {
            Response.Write("<script>alert('此商品並無販售');history.back();</script>");
            Response.End();

        }
        if (status == "-1")         
            {
                Response.Write("<script>alert('此商品販售完畢');history.back();</script>");
                Response.End();

            }


    }
}