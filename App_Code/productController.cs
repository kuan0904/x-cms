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

    [ActionName(" GetPackageList")]
    [HttpPost] // post方法二
    public static  List<Package>  GetPackageList(dynamic obj)
    {
        //   return obj.cid;
        int Totalrow = 0;
        string Supplierid = obj.Supplierid ==0 ?"" : Convert.ToString(obj.Supplierid);
        string Categoryid = obj.Categoryid == 0 ? "" : Convert.ToString(obj.Categoryid) ?? "";
        string KeyWords = Convert.ToString(obj.Keyword) ?? "";
        string Packageid = Convert.ToString(obj.Packageid);
        int PageSize = obj.pagesize == null ? 5 : Convert.ToInt16(obj.pagesize);
        int PageIdx = obj.idx == null ? 1 : Convert.ToInt16(obj.idx);
        string sort = Convert.ToString(obj.sort) ?? "";
        List<Package > datalist = new List<Package>();
        int rows = 10;
        int page = 0;
        DataTable dt;
        string strsql = @"select  * from  tbl_package   where status='Y'  ";
        if (Categoryid != "")
        {
            strsql += " and Categoryid = @categoryid ";

        }
        if (Supplierid != "")
        {
            strsql += " and Supplierid = @supplierid ";

        }
        if (KeyWords != "")
        {
            strsql += @" and ( description like @s     )";
        }
        if (Packageid != "")
        {
            strsql += " and Packageid = @Packageid ";
        }
        switch (sort)

        {
            case "id":
                strsql += " order packageid desc ";
                break;
            case "views":
                strsql += " order by ViewCount desc,packageid desc ";
                break;

            default:
                strsql += " order by packageid desc ";
                break;
        }

        NameValueCollection nvc = new NameValueCollection
            {
                { "categoryid", Categoryid },
                { "supplierid", Supplierid },
                { "s", "%" + KeyWords  + "%" },
                { "Packageid", Packageid }
            };
        dt = DbControl.Data_Get(strsql, nvc);
        int idx = 0;

        int totalrow = dt.Rows.Count;
        dt = DbControl.GetPagedTable(dt, page, rows);
        List <Package>maindata = new List<Package>(); 
        for (idx = 0; idx < dt.Rows.Count; idx++)
        {
            Package p = new Package
            {
                Packageid = (int)dt.Rows[idx]["Packageid"],
                Packagename = dt.Rows[idx]["Packagename"].ToString(),
                Description = dt.Rows[idx]["Description"].ToString(),
                Shippingfee = (int)dt.Rows[idx]["Shippingfee"],
                Freeship = (int)dt.Rows[idx]["Freeship"],
                ShippingKind = dt.Rows[idx]["shippingKind"].ToString(),
                Viewcount = (int)dt.Rows[idx]["Viewcount"],
                Status = dt.Rows[idx]["Status"].ToString(),
                Supplierid = (int)dt.Rows[idx]["Supplierid"],
                Refunds = dt.Rows[idx]["Refunds"].ToString(),
                ReMark = dt.Rows[idx]["ReMark"].ToString()
            };
            strsql = @"SELECT tbl_package_product.packageid, tbl_package_product.p_id, tbl_package_product.price, 
            tbl_package_product.storage, tbl_productData.productname, tbl_productData.productcode,
            tbl_productData.logo FROM   tbl_package_product INNER JOIN
            tbl_productData ON tbl_package_product.p_id = tbl_productData.p_id where packageid = @packageid"; 
            DataTable  dl= DbControl.Data_Get(strsql, nvc);
            List <PackageItem>pl = new List<PackageItem>();
           
            foreach (DataRow dr in dl.Rows )
            {
                PackageItem pd = new PackageItem();
                pd.Pic  = "/upload/" +  dr["logo"].ToString();
                pd.Price = (int)dr["price"];
                pd.Productcode = dr["productcode"].ToString();
                pd.Packageid = (int)dr["Packageid"];
                pd.Storage = (int)dr["Storage"];
                pd.Productname =  dr["Productname"].ToString();
                pd.P_id =(int) dr["p_id"];
                pl.Add(pd);
            }
            p.PackageItem = pl;
            maindata.Add(p);

        }
        dt.Dispose();
        return maindata;



    }

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
        List<ProductData> datalist = new List<ProductData>();
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
    public static ProductData GetProduct(string  p_id)
    {
        //   return obj.cid;

        string strsql = "SELECT * FROM tbl_productData WHERE p_id = @p_id ";
        NameValueCollection nvc = new NameValueCollection
            {
                { "p_id", p_id },
               
            };
        ProductData pd = new ProductData
        {
            Status = "-2"
        };
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        foreach (DataRow  d in dt.Rows)
        {
            pd.P_id = p_id;
            pd.Productname = d["Productname"].ToString ();
            pd.Productcode = d["productcode"].ToString();
            pd.Price  =(int) d["Price"];
            pd.Videourl = d["videourl"].ToString();
            pd.Description = d["description"].ToString();
            pd.Logo =   d["logo"].ToString();
            pd.Categoryid = (int)d["Categoryid"];
            pd.Pic1 = d["pic1"].ToString();
            pd.Pic2 = d["pic2"].ToString();
            pd.Pic3 = d["pic3"].ToString();
            pd.Supplierid = (int)d["Supplierid"];
            pd.ShippingKind = d["shippingKind"].ToString();
            pd.Memo = d["memo"].ToString();
            pd.Status = d["status"].ToString();
            pd.Keyword = d["keyword"].ToString();
            pd.Storage = (int)d["Price"];
            pd.Sort = d["Sort"].ToString();
            pd.Keyword  = d["Keyword"].ToString();

        }
        dt.Dispose();
        return pd;

    }

    public class Package
    {
        
        public int Packageid { get; set; }
        public string Packagename { get; set; }
        public string Description { get; set; }
        public int Shippingfee { get; set; }
        public string ShippingKind { get; set; }
        public int Freeship { get; set; }
        public string Status { get; set; }
        public int Viewcount { get; set; }
        public int TotalRows { get; set; }
        public int Categoryid { get; set; }
        public int Supplierid { get; set; }
        public List<ProductData> ProductData { get; set; }
        public List<PackageItem> PackageItem { get; set; }
        public string[] Keyword { get; set; }
        public int pagesize { get; set; }
        public int idx { get; set; }
        public int sort { get; set; }
        public string Refunds { get; set; }
        public string ReMark { get; set; }
      
    }
    public class ProductData
    {
        public string P_id { get; set; }
        public string Productname { get; set; }        
        public string Productcode  { get; set; }
        public string Logo { get; set; }
        public string Pic1 { get; set; }
        public string Pic2 { get; set; }
        public string Pic3 { get; set; }
        public PackageItem ItemData { get; set; }
        public DateTime PostDay { get; set; }
        public string Description { get; set; }     
      
        public string ShippingKind { get; set; }
     
        public string Status { get; set; }
        public string Videourl { get; set; }      
        public string Keyword { get; set; }
        public string[] Groupcode { get; set; }
        public string Memo { get; set; } 
        public int Viewcount { get; set; }     
        public int TotalRows { get; set; }
        public int Categoryid { get; set; }
        public int Supplierid { get; set; }
        public int Price { get; set; }
        public int Storage { get; set; }
        public string Sort { get; set; }
        public string Spec { get; set; }

    }
    public class PackageItem
    {
       
        public int Packageid { get; set; }
        public int P_id { get; set; }
        public string Productname { get; set; }
        public string Productcode { get; set; }
        public string Spec { get; set; }
        public string Pic { get; set; }
        public int Price { get; set; }
        public int Storage { get; set; }
        public string  Status { get; set; }
    }
}
