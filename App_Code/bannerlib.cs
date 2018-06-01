using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;

namespace Banner {
    public class DbHandle
    {

        public static List<Banner.MainData> Banner_Get_list(int ClassId)
        {
            List< Banner.MainData > MainData = new List<Banner.MainData>();       
            string strsql = "select * from  tbl_banner where ClassId =@ClassId and status='Y'";
            NameValueCollection nvc = new NameValueCollection
            {
                { "ClassId", ClassId.ToString() }
            };
            DataTable dt = DbControl.Data_Get(strsql, nvc);
            int i = 0;
            for (i=0;i<dt.Rows.Count;i++)
            {
                MainData.Add(new MainData
                {
                   Subject = dt.Rows[i]["title"].ToString(),
                    Id = (int)dt.Rows[i]["bannerid"],
                    Contents = dt.Rows[i]["contents"].ToString(),
                    Pic = dt.Rows[i]["filename"].ToString(),
                    Path = dt.Rows[i]["path"].ToString(),
                    Url = dt.Rows[i]["url"].ToString(),
                });              
            }
            dt.Dispose();
            nvc.Clear();      
            return MainData;

        }


    
    
       
    }

    public class MainData
        {
            public int Id { get; set; }
            public string Subject { get; set; }
            public string Pic { get; set; }
            public string Contents { get; set; }
            public int Viewcount { get; set; }          
            public string Status { get; set; }
            public string Url { get; set; }
            public int ClassId { get; set; }
            public string Path { get; set; }
       
    }
}