﻿using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using MyPublic;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;

using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web.Security;
using System.Web.UI.WebControls;
using unity;

public partial class Account_Login : Page
{
    private const string AntiXsrfTokenKey = "__AntiXsrfToken";
    private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
    private string _antiXsrfTokenValue;
    
    public string systemName = "";
    protected void Page_Init(object sender, EventArgs e)
    {
        Session["userid"] = "";
        // 下面的程式碼有助於防禦 XSRF 攻擊
        var requestCookie = Request.Cookies[AntiXsrfTokenKey];
        Guid requestCookieGuidValue;
        if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
        {
            // 使用 Cookie 中的 Anti-XSRF 權杖
            _antiXsrfTokenValue = requestCookie.Value;
            Page.ViewStateUserKey = _antiXsrfTokenValue;
        }
        else
        {
            // 產生新的防 XSRF 權杖並儲存到 cookie
            _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
            Page.ViewStateUserKey = _antiXsrfTokenValue;

            var responseCookie = new HttpCookie(AntiXsrfTokenKey)
            {
                HttpOnly = true,
                Value = _antiXsrfTokenValue
            };
            if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
            {
                responseCookie.Secure = true;
            }
            Response.Cookies.Set(responseCookie);
        }

        using (SqlConnection conn = new SqlConnection(classlib.dbConnectionString))
        {
            string sql;
            sql = "select * from CompanyData ";
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader rs;
            rs = cmd.ExecuteReader();
            if (rs.Read())
            {
                Session["companyName"] = rs["companyName"].ToString();
                Session["systemName"] = rs["systemName"].ToString();
            }
            rs.Close();
            cmd.Dispose();
            conn.Close();

        }
    }


    protected void Page_Load(object sender, EventArgs e)
        {

      
        if (!IsPostBack)
        {
            // 設定 Anti-XSRF 權杖
            ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
            ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
        }
        else
        {
            // 驗證 Anti-XSRF 權杖
            if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
            {
                throw new InvalidOperationException("Anti-XSRF 權杖驗證失敗。");
            }
        }

        var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
           
        }

    protected void LogIn(object sender, EventArgs e)
    {

        //  Context.GetOwinContext().Authentication.SignOut();
        if (IsValid)
        {
            if (Session["CAPTCHA"].ToString() == VERIFYCODE.Text)
            {
                string sql;
                sql = "select * from admin_account where account_pid = @account_pid and account_pwd = @account_pwd  ";
                bool results = false;
                SqlConnection conn = new SqlConnection(unity.classlib.dbConnectionString);
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                SqlDataReader rs;
                cmd.Parameters.Add("@account_pid", SqlDbType.VarChar, 20).Value = UserName.Text.Trim();
                cmd.Parameters.Add("@account_pwd", SqlDbType.VarChar, 20).Value = Password.Text.Trim();
                rs = cmd.ExecuteReader();
                if (rs.Read())
                {
                    Session["userid"] = rs["user_id"].ToString();
                    Session["username"] = rs["name"].ToString();
                    Session.Timeout = 300;
                    rs.Close();
                    cmd.Dispose();
                    //sql = "insert into login_log ( account_pid, login_time, login_ip) ";
                    //sql += " values (@username,getdate(),'" + unity.classlib.getIP(Request) + "');";
                    sql = "update  admin_account set login_times =  login_times +1, last_lgoin_ip = '" + unity.classlib.getIP(Request) + "' ";
                    sql += " where user_id =@userid ";
                    cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.Add("@userid", SqlDbType.Int).Value = Session["userid"].ToString();

                    rs = cmd.ExecuteReader();
                    //cmd.ExecuteNonQuery();
                    //cmd.Dispose();
                    results = true;
                }
                else
                {
                    FailureText.Text = "Invalid username or password.";
                }
                rs.Close();
                cmd.Dispose();





                //------第一層------
                string strsql = "";
                if (Session["userid"].ToString() == "1")
                {
                    //不分權限
                    strsql = @"SELECT *,(select count(*) from unitdata a where a.upperid= b.unitid) as rows 
                FROM  UnitData b
                    where  adminpage is  not null  and b.upperid = 0  and adminpage <> ''
                    order by sort ";
                }
                else
                {
                    //第二層有權限的               
                    strsql = @"SELECT DISTINCT u1.unitname, u1.unitid, u1.adminpage, 1 AS rows
                    FROM              UnitData AS u1 INNER JOIN
                                                UnitData AS u2 ON u2.upperid = u1.unitid INNER JOIN
                                                Powerlist ON Powerlist.unitid = u2.unitid
                    WHERE          (Powerlist.user_id = @uid) AND (u1.status <> 'D') AND (u1.adminpage <> '') AND (u1.adminpage IS NOT NULL) AND 
                                                (u2.adminpage <> '') AND (u2.adminpage IS NOT NULL) AND (u1.upperid = 0) AND (u2.status <> 'D')
                    UNION ALL
                    SELECT          UnitData.unitname, Powerlist_1.unitid, UnitData.adminpage, 0 AS rows
                    FROM              UnitData INNER JOIN
                                                Powerlist AS Powerlist_1 ON UnitData.unitid = Powerlist_1.unitid
                    WHERE          (Powerlist_1.user_id = @uid) AND (UnitData.upperid = 0) AND (UnitData.unitid NOT IN
                                (SELECT          upperid
                                  FROM               UnitData AS UnitData_1))     ";


                }
                NameValueCollection nvc = new NameValueCollection
                {
                    { "uid",  Session["userid"].ToString() }
                };

                DataTable menu = DbControl.Data_Get(strsql, nvc);
                Session["Backmenu"] = menu;
                menu.Dispose();

                conn.Close();
                // Validate the user password
                var manager = new UserManager();
                ApplicationUser user = manager.Find(UserName.Text, "xnet1234");
                if (results == true && user == null)
                {
                    user = new ApplicationUser() { UserName = UserName.Text };
                    IdentityResult result = manager.Create(user, "xnet1234");
                    //新增一個帳號（與密碼）            
                    if (result.Succeeded)
                    {
                        // IdentityHelper已經寫好。放在 /App_Code目錄下的 IdentityModels檔案。
                        IdentityHelper.SignIn(manager, user, isPersistent: false);
                        IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                    }
                    else
                        FailureText.Text = "Invalid username or password.";

                    foreach (string dt in result.Errors)
                    {
                        FailureText.Text = dt;
                    }
                }

                if (user != null && results == true)
                {
                    IdentityHelper.SignIn(manager, user, false);
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
                if (FailureText.Text == "")
                {
                    FailureText.Text = "帳戶或密碼有誤";

                }

            }
            else
            {
                VERIFYCODE.Text = "";
                FailureText.Text = "驗証碼有誤";
            }
        }
    }
}
