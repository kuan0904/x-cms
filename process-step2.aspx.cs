using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class process_step2 : System.Web.UI.Page
{
    public string pagetitle = "";
    public string pageunit = "";
    public int totalprice = 0;
    public int totalnum= 0;
    List<LessonLib.ItemData> classdata = new List<LessonLib.ItemData>();
    List<LessonLib.JoinData> joindata = new List<LessonLib.JoinData>();
    protected void Page_Load(object sender, EventArgs e)
    {
       
        string[] joinnum  =Request.Form["joinnum"].Split (',');
        string[] lessonid = Request.Form["lessonid"].Split(',');
        int i = 0;
        foreach (string s in joinnum)
        {
            if (joinnum[i] != "0")
            {
                LessonLib.ItemData ItemData = (LessonLib.ItemData)LessonLib.DbHandle.Get_LessonClass(int.Parse(lessonid[i]));
                classdata.Add(new LessonLib.ItemData
                {
                    Id = (int)ItemData.Id,
                    Description = (string)ItemData.Description,
                    Price = (int)ItemData.Price,
                    Sellprice = (int)ItemData.Sellprice,
                    Num =int.Parse (joinnum[i])
                });
                int j = 0;
                for (j = 1; j <= int.Parse(joinnum[i]); j++)
                {
                   
                    joindata.Add(new LessonLib.JoinData
                    {
                         Id = int.Parse(lessonid[i])
                     


                    });
                }
                totalnum += int.Parse(joinnum[i]);
                totalprice += (int)ItemData.Sellprice * int.Parse(joinnum[i]);
            }
            i++;
        }
     
        Repeater1.DataSource = classdata;
        Repeater1.DataBind();
        Repeater2.DataSource = joindata;
        Repeater2.DataBind();

    }
}