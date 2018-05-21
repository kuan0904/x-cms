using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
namespace article
{
    public class MainData
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Image { get; set; }
        public string SubTitle { get; set; }
        public DateTime PostDay { get; set; }
        public string Contents { get; set; }
        public int Viewcount { get; set; }
        public int FBShare { get; set; }
        public int GoogleShare { get; set; }
        public int TwitterShare { get; set; }
        public int PinterestShare { get; set; }
        public string Status { get; set; }
        public string[] Writer { get; set; }
        public string[] Category { get; set; }
        public string[] Tags { get; set; }
        public string Keywords { get; set; }
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
    public class Writer
    {
        public int Id { get; set; }
        public int Secno { get; set; }
        public int WriterId { get; set; }
    }
    public class Category
    {
        public int Id { get; set; }
        public int categoryId { get; set; }
       
    }
    public class Tags
    {
        public int Id { get; set; }
        public int Secno { get; set; }
        public int TagId { get; set; }
    }
    public class KeyWord
    {
        public int Id { get; set; }      
        public string World { get; set; }
    }
}