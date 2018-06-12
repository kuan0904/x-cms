using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections.Specialized;
using System.Data;
/// <summary>
/// web 的摘要描述
/// </summary>
public class unitlib
{
    public unitlib()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    public static MainData Get_UnitData(int unitid)
    {
      
        string strsql = "SELECT *  FROM unitdata  where unitid =  @unitid  ";
        NameValueCollection nvc = new NameValueCollection
        {
            { "unitid", unitid.ToString() }
        };
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        MainData MainData = new MainData();

        if (dt.Rows.Count > 0) {
            MainData.Subject  = dt.Rows[0]["unitname"].ToString();
            MainData.Contents  = dt.Rows[0]["Contents"].ToString();
        }

        dt.Dispose();
        nvc.Clear();
        return MainData ;
    }
    public static string Get_UnitName(int unitid)
    {
        string unitname = "";
        string strsql = "SELECT unitname  FROM unitdata  where unitid =  @unitid  ";
        NameValueCollection nvc = new NameValueCollection
        {
            { "unitid", unitid.ToString() }
        };
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        if (dt.Rows.Count >0)        unitname = dt.Rows[0]["unitname"].ToString();
        dt.Dispose();
        nvc.Clear();
        return unitname;
    }
    public class MainData
    {
        public int Id { get; set; }
        public string Subject { get; set; }
        public string Pic { get; set; }
        public string Contents { get; set; }
        public int Price { get; set; }
   

    }
}