using System;
using System.Text.RegularExpressions;
using System.Web;
/**//// <summary> 
/// SqlKey 的摘要說明。 
/// </summary> 
public class SqlKey
{
    private HttpRequest request;
    private const string StrKeyWord = @"select|insert|delete|from|count(|drop table|update|truncate|asc(|mid(|char(|xp_cmdshell|exec master|netlocalgroup administrators|:|net user|""|or|and";
    private const string StrRegex = @"-|;|,|/|(|)|[|]|}|{|%|@@|*|!|'";
    public SqlKey(System.Web.HttpRequest _request)
    {
        // 
        // TODO: 在此處添加構造函數邏輯 
        // 
        this.request = _request;
    }

    /**//// <summary> 
        /// 唯讀屬性 SQL關鍵字 
        /// </summary> 
    public static string KeyWord
    {
        get
        {
            return StrKeyWord;
        }
    }
    /**//// <summary> 
        /// 唯讀屬性過濾特殊字元 
        /// </summary> 
    public static string RegexString
    {
        get
        {
            return StrRegex;
        }
    }
    /**//// <summary> 
        /// 檢查URL參數中是否帶有SQL注入可能關鍵字。 
        /// </summary> 
        /// <param name="_request">當前HttpRequest物件</param> 
        /// <returns>存在SQL注入關鍵字true存在，false不存在</returns> 
    public bool CheckRequestQuery()
    {
        if (request.QueryString.Count != 0)
        {
            //若URL中參數存在，逐個比較參數。 
            foreach (string i in this.request.QueryString)
            {
                // 檢查參數值是否合法。 
                if (i == "__VIEWSTATE") continue;
                if (i == "__EVENTVALIDATION") continue;
                if (CheckKeyWord(request.QueryString[i].ToString()))
                {
                    return true;
                }
            }
        }
        return false;
    }

    /**//// <summary> 
        /// 檢查提交表單中是否存在SQL注入可能關鍵字 
        /// </summary> 
        /// <param name="_request">當前HttpRequest物件</param> 
        /// <returns>存在SQL注入關鍵字true存在，false不存在</returns> 
    public bool CheckRequestForm()
    {
        if (request.Form.Count > 0)
        {

            //獲取提交的表單項不為0 逐個比較參數 
            foreach (string i in this.request.Form)
            {
                if (i == "__VIEWSTATE") continue;
                if (i == "__EVENTVALIDATION") continue;
                //檢查參數值是否合法 
                if (CheckKeyWord(request.Form[i]))
                {
                    //存在SQL關鍵字 
                    return true;

                }
            }
        }
        return false;
    }

    /**//// <summary> 
        /// 靜態方法，檢查_sword是否包涵SQL關鍵字 
        /// </summary> 
        /// <param name="_sWord">被檢查的字串</param> 
        /// <returns>存在SQL關鍵字返回true，不存在返回false</returns> 
    public static bool CheckKeyWord(string _sWord)
    {
        string word = _sWord;
        string[] patten1 = StrKeyWord.Split('|');
        string[] patten2 = StrRegex.Split('|');
        foreach (string i in patten1)
        {
            if (word.Contains(" " + i) || word.Contains(i + " "))
            {
                return true;
            }
        }
        foreach (string i in patten2)
        {
            if (word.Contains(i))
            {
                return true;
            }
        }
        return false;
    }

    /**//// <summary> 
        /// 反SQL注入:返回1無注入資訊，否則返回錯誤處理 
        /// </summary> 
        /// <returns>返回1無注入資訊，否則返回錯誤處理</returns> 
    public string CheckMessage()
    {
        string msg = "1";
        if (CheckRequestQuery()) //CheckRequestQuery() || CheckRequestForm() 
        {
            //msg = "<span style='font-size:24px;'>非法操作！<br>"; 
            //msg += "操作IP：" + request.ServerVariables["REMOTE_ADDR"] + "<br>"; 
            //msg += "操作時間：" + DateTime.Now + "<br>"; 
            //msg += "頁面：" + request.ServerVariables["URL"].ToLower() + "<br>"; 
            //msg += "<a href="#" onclick="history.back()">返回上一頁</a></span>"; 
        }
        return msg.ToString();
    }
}
