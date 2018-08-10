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
    public static string  GetLnk(string kind ,string id ,string page=""  )
    {
        string result = "";
            if (kind == "1") result = "/news/" + id ;
            if (kind == "2") result = "/catalog/" + id;
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

    public static object Get_menu()
    {
       
        string strsql = @"SELECT * FROM tbl_category
        WHERE classId = 1  AND status = 'Y' AND parentid = 0
        ORDER BY   sort";
        NameValueCollection nvc = new NameValueCollection
        {
        };
        DataTable dt = DbControl.Data_Get(strsql, nvc);
        int i = 0;
        List<MenuModel> Menu  = new List<MenuModel>();
        for (i = 0; i < dt.Rows.Count; i++)
        {
           Menu.Add(new MenuModel 
            {
              Id  = (int)dt.Rows[i]["categoryid"],
              Title = dt.Rows[i]["title"].ToString (),
              Kind = dt.Rows[i]["kind"].ToString (),
            
            });
        }
        dt.Dispose();
        strsql = @"SELECT * FROM tbl_category
        WHERE classId = 1  AND status = 'Y' AND parentid = @id
        ORDER BY   sort";
        foreach (MenuModel m in Menu)
        {
            nvc.Clear();
            nvc.Add("id", m.Id.ToString());
            dt = DbControl.Data_Get(strsql, nvc);

            List<MenuModel> subMenu = new List<MenuModel>();
            for (i = 0; i < dt.Rows.Count; i++)
            {
                subMenu.Add(new MenuModel
                {
                    Id = (int)dt.Rows[i]["categoryid"],
                    Title = dt.Rows[i]["title"].ToString(),
                    Kind = dt.Rows[i]["kind"].ToString(),

                });
            }
            m.Detial = subMenu;

        }
   
   
       
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
        public List<MenuModel> Detial { get; set; }
    }
    
}