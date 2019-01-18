using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Data;
public partial class lib_checkjoin : System.Web.UI.Page
{
    public string msg = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt;
        string code = Request["code"];
        string[] ary = code.Split('-');
        code = ary[0] + "-" + ary[1] + "-" + ary[2];

        if (code==null || code == "")
        {
            msg = "無編號";
        }       
      
        else
        {
            LessonLib.JoinData l = LessonLib.Web.Get_ord_JoinData(ary[0]);
            if (l.Id == 0)
            {
                msg = "報名資料不存在";
            }
            else
            {
             
                string strsql = "select * from  tbl_joindetail where joinid=@joinid ";
                NameValueCollection nvc = new NameValueCollection
                {
                    { "joinid", ary[1] },

                };
                strsql = "select * from tbl_joinlog where checkcode=@checkcode ";
                nvc.Clear();
                nvc = new NameValueCollection
                {
                    { "checkcode", code },

                };
                dt = DbControl.Data_Get(strsql, nvc);
                if (dt.Rows.Count > 0)
                {
                    msg = "已報到過!";
                }
                else
                {
                    strsql = "insert into tbl_joinlog (checkcode) values (@checkcode)";
                    DbControl.Data_add(strsql, nvc);
                    msg = "報到成功!";
                }
                msg += "<br>訂單編號:" + l.Ord_code + "<br>";
                msg += "付款方式:" + OrderLib.getPaymode(l.OrderData.Paymode) + "<br>";
                msg += "訂單狀態:" + OrderLib.get_ord_status(l.OrderData.Status) + "<br>";

            }
        }
          
          
        
        

        }
       

       
        
       
    }
