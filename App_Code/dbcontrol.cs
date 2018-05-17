using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// dbcontrol 的摘要描述
/// </summary>
public class dbcontrol
{
    public static string dbConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["dbconnConnection"].ConnectionString;

    public dbcontrol()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
}