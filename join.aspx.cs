using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class join : System.Web.UI.Page
{
    public string lessonid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        lessonid = Request.QueryString["lessonid"];
    }
}