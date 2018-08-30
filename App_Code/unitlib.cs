using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections.Specialized;
using System.Data;
/// <summary>
/// web 的摘要描述
/// </summary>
public class Unitlib
{
    public Unitlib()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    public static string GetLnk(string kind, string id, string page = "")
    {
        string result = "";
        if (kind == "1") result = "/catalog/" + id;
        if (kind == "2") result = "/emba/" + id;
        if (kind == "3") result = "/catalog/" + id;
        if (kind == "4") result = "/Article/" + id;
        if (kind == "5") result = "/page/" + id;
        if (page != "") result += "/page/" + page;
        return result;
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
            MainData.Subject = dt.Rows[0]["unitname"].ToString();
            MainData.Contents = dt.Rows[0]["Contents"].ToString();
        }

        dt.Dispose();
        nvc.Clear();
        return MainData;
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
        if (dt.Rows.Count > 0) unitname = dt.Rows[0]["unitname"].ToString();
        dt.Dispose();
        nvc.Clear();
        return unitname;
    }

    public static object Get_menu()
    {

        string strsql = @"SELECT * FROM tbl_category
        WHERE classId = 1  AND status = 'Y' 
        ORDER BY  parentid, sort";
        NameValueCollection nvc = new NameValueCollection
        {
        };
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        dt.DefaultView.RowFilter = "ParentId=0";
        DataTable dt1 = dt.DefaultView.ToTable();

        int i, j;
        List<MenuModel> Menu = new List<MenuModel>();
        for (i = 0; i < dt1.Rows.Count; i++)
        {
            dt.DefaultView.RowFilter = "ParentId=" + dt1.Rows[i]["categoryid"].ToString();
            DataTable dt2 = dt.DefaultView.ToTable();
            List<MenuModel> subMenu = new List<MenuModel>();
            for (j = 0; j < dt2.Rows.Count; j++)
            {
                subMenu.Add(new MenuModel
                {
                    Id = (int)dt2.Rows[j]["categoryid"],
                    Title = dt2.Rows[j]["title"].ToString(),
                    Kind = dt2.Rows[j]["kind"].ToString(),
                    ParentId = (int)dt2.Rows[j]["parentid"]
                });
            }
            dt2.Dispose();
            Menu.Add(new MenuModel
            {
                Id = (int)dt1.Rows[i]["categoryid"],
                Title = dt1.Rows[i]["title"].ToString(),
                Kind = dt1.Rows[i]["kind"].ToString(),
                ParentId = (int)dt1.Rows[i]["parentid"],
                Detial = subMenu

            });
            dt1.Dispose();
        }
        dt.Dispose();

        return Menu;
    }
    public class MainData
    {
        public int Id { get; set; }
        public string Subject { get; set; }
        public string Pic { get; set; }
        public string Contents { get; set; }
        public int Price { get; set; }

    }
    public class MenuModel
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Kind { get; set; }
        public int ParentId { get; set; }
        public List<MenuModel> Detial { get; set; }
    }
    public class WebsiteData
    {
        public string Site_name { get; set; }
        public string Description { get; set; }
        public string Websiteurl { get; set; }     
        public string Keyword{ get; set; }
    }
       
}