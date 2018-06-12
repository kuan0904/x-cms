using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// LessonLib 的摘要描述
/// </summary>
public class LessonLib
{
    public LessonLib()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    public class DbHandle
    {

     




    }

    public class MainData
    {
        public int Id { get; set; }
        public string Subject { get; set; }
        public string Pic { get; set; }
        public string Contents { get; set; }
        public int Price { get; set; }
        public string Sellprice { get; set; }
        public string Status { get; set; }
        public string Sddress { get; set; }   
        public string Lessontime { get; set; }     
  
    }
    public class ItemData
    {
        public int Id { get; set; }
        public int Tagid { get; set; }
        public string Subject { get; set; }
        public string Pic { get; set; }
        public string Contents { get; set; }
    }
}