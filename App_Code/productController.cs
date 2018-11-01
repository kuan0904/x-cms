using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Collections.Specialized;
using System.Data;

public class productController : ApiController
{
    [ActionName("GetProductList")]
    [HttpPost] // post方法二
    public object GetProductList(dynamic obj)
    {
        //   return obj.cid;
        int Totalrow = 0;
        string Supplierid = Convert.ToString(obj.supplierid);
        string Categoryid = Convert.ToString(obj.categoryid);
        string KeyWords = Convert.ToString(obj.keyword) ?? "";
        int PageSize = obj.pagesize == null ? 5 : Convert.ToInt16(obj.pagesize);
        int PageIdx = obj.idx == null ? 1 : Convert.ToInt16(obj.idx);
        string sort = Convert.ToString(obj.sort) ?? "";
        List<MainData> datalist = new List<MainData>();
        int rows = 10;
        int page = 0;
        DataTable dt;
        string strsql = @"select  * from  tbl_productData  where status='Y'  ";
        if (Categoryid.ToString () != "")
        {
            strsql += " and Categoryid = @categoryid ";                

        }
        if (Supplierid.ToString() != "")
        {
            strsql += " and Supplierid = @supplierid ";

        }
        if (KeyWords != "")
        {
            strsql += @" and ( description like @s   or keyword like @s
            or memo like @s or spec like @s or memo like @s  )";   
        }
        switch (sort)

        {
            case "id":
                strsql += " order p_id desc ";
                break;
            case "views":
                strsql += " order by ViewCount desc,p_id desc ";
                break;

            default:
                strsql += " order by p_id desc ";
                break;
        }

        NameValueCollection nvc = new NameValueCollection
            {
                { "categoryid", Categoryid },
                { "supplierid", Supplierid },
                { "s", "%" + KeyWords  + "%" }

            };
        dt = DbControl.Data_Get(strsql, nvc);
        int idx = 0;
       
        int totalrow = dt.Rows.Count;
        dt = DbControl.GetPagedTable(dt, page, rows);
        for (idx = 0; idx < dt.Rows.Count; idx++)
        {

            datalist.Add(GetProduct(dt.Rows[idx]["p_id"].ToString()));
               
        }
        dt.Dispose();
        return datalist;
      

      
    }
    [ActionName("GetProduct")]
    [HttpPost] 
    public static  MainData GetProduct(string  p_id)
    {
        //   return obj.cid;

        string strsql = "SELECT * FROM tbl_productData WHERE p_id = @p_id ";
        NameValueCollection nvc = new NameValueCollection
            {
                { "p_id", p_id },
               
            };
        MainData pd = new MainData();
        pd.Status = "-2";
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        foreach (DataRow  d in dt.Rows)
        {
            pd.P_id = p_id;
            pd.Productname = d["Productname"].ToString ();
            pd.Productcode = d["productcode"].ToString();
            pd.Price = (int)d["price"];
            pd.Videourl = d["videourl"].ToString();
            pd.Description = d["description"].ToString();
            pd.Pic="/upload/" +  d["pic1"].ToString();
            pd.Shippingfee = (int)d["shippingfee"];
            pd.Storage = (int)d["storage"];
            pd.Freeship = (int)d["freeship"];
            pd.ShippingKind = d["shippingKind"].ToString();
            pd.Memo = d["memo"].ToString();
            pd.Status = d["status"].ToString();
            pd.Keyword = d["keyword"].ToString().Split(',');
            pd.Groupcode = d["groupproductcode"].ToString().Split(',');
            pd.Spec = d["spec"].ToString();
        }
        dt.Dispose();
        return pd;

    }


    public class MainData
    {
        public string P_id { get; set; }
        public string Productname { get; set; }        
        public string Productcode  { get; set; }
        public string Pic { get; set; }
        public ItemData  ItemData { get; set; }
        public DateTime PostDay { get; set; }
        public string Description { get; set; }
        public int Storage { get; set; }
        public int Price { get; set; }
        public int Shippingfee { get; set; }
        public string ShippingKind { get; set; }
        public int Freeship { get; set; }
        public string Status { get; set; }
        public string Videourl { get; set; }      
        public string[] Keyword { get; set; }
        public string[] Groupcode { get; set; }
        public string Memo { get; set; } 
        public int Viewcount { get; set; }
        public string Spec { get; set; }
        public int TotalRows { get; set; }
        public int Categoryid { get; set; }
        public int Supplierid { get; set; }
    }
    public class ItemData
    {
        public int Id { get; set; }
        public int Secno { get; set; }
        public string Title { get; set; }
        public string Image { get; set; }
        public string Contents { get; set; }
        public string Layout { get; set; }

    }
}
