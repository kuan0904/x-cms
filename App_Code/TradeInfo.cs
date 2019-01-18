using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpGatewayHelper.Models
{
    public class TradeInfo
    {
        /// <summary>
        /// 商店代號 
        /// </summary>
        /// <value>
        /// The merchant identifier.
        /// </value>
        public string MerchantID { get; set; }
        /// <summary>
        /// 回傳格式 
        /// <para>JSON 或是 String</para>
        /// </summary>
        /// <value>
        /// The type of the respond.
        /// </value>
        public string RespondType { get; set; }
        /// <summary>
        /// TimeStamp
        /// <para>自從 Unix 纪元（格林威治時間 1970 年 1 月 1 日 00:00:00）到當前時間的秒數。</para>
        /// </summary>
        /// <value>
        /// The time stamp.
        /// </value>
        public string TimeStamp { get; set; }
        /// <summary>
        /// 串接程式版本 
        /// </summary>
        /// <value>
        /// The version.
        /// </value>
        public string Version { get; set; }
        /// <summary>
        /// 商店訂單編號 
        /// <para>限英、數字、_ 格式</para>
        /// </summary>
        /// <value>
        /// The merchant order no.
        /// </value>
        public string MerchantOrderNo { get; set; }
        /// <summary>
        /// 訂單金額 
        /// </summary>
        /// <value>
        /// The amt.
        /// </value>
        public int Amt { get; set; }
        /// <summary>
        /// 商店備註 
        /// </summary>
        /// <value>
        /// The order comment.
        /// </value>
        public string OrderComment { get; set; }
        /// <summary>
        /// 商品資訊 
        /// </summary>
        /// <value>
        /// The item desc.
        /// </value>
        public string ItemDesc { get; set; }
        /// <summary>
        /// 交易限制秒數 
        /// </summary>
        /// <value>
        /// The trade limit.
        /// </value>
        public int TradeLimit { get; set; }
        /// <summary>
        /// 支付完成 返回商店網址 
        /// </summary>
        /// <value>
        /// The return URL.
        /// </value>
        public string ReturnURL { get; set; }
        /// <summary>
        /// 支付通知網址 
        /// </summary>
        /// <value>
        /// The notify URL.
        /// </value>
        public string NotifyURL { get; set; }
        /// <summary>
        /// 商店取號網址 
        /// </summary>
        /// <value>
        /// The customer URL.
        /// </value>
        public string CustomerURL { get; set; }
        /// <summary>
        /// 支付取消 返回商店網址 
        /// </summary>
        /// <value>
        /// The client back URL.
        /// </value>
        public string ClientBackURL { get; set; }
        /// <summary>
        /// 付款人電子信箱 
        /// </summary>
        /// <value>
        /// The email.
        /// </value>
        public string Email { get; set; }
        /// <summary>
        /// 付款人電子信箱 是否開放修改 
        /// <para>1=可修改 0=不可修改 </para>
        /// </summary>
        /// <value>
        /// The email modify.
        /// </value>
        public int EmailModify { get; set; }
        /// <summary>
        /// 智付通會員 
        /// <para>0=不須登入智付通會員</para>
        /// <para>1=須要登入智付通會員</para>
        /// </summary>
        /// <value>
        /// The type of the login.
        /// </value>
        public int LoginType { get; set; }
        /// <summary>
        /// ATM 轉帳啟用
        /// </summary>
        /// <value>
        /// The webatm.
        /// </value>
        public int? VACC { get; set; }
        /// <summary>
        /// 超商條碼繳費啟用 
        /// </summary>
        /// <value>
        /// The webatm.
        /// </value>
        public int? BARCODE { get; set; }
        /// <summary>
        /// 超商代碼繳費 啟用
        /// </summary>
        /// <value>
        /// The webatm.
        /// </value>
        public int? CVS { get; set; }
        /// <summary>
        /// 繳費有效期限 
        /// <para>格式為 date('Ymd') ，例：20140620</para> 
        /// </summary>
        /// <value>
        /// The credit red.
        /// </value>
        public string ExpireDate { get; set; }
        /// <summary>
        /// 信用卡 一次付清啟用 
        /// </summary>
        /// <value>
        /// The credit.
        /// </value>
        public int? CREDIT { get; set; }
        /// <summary>
        /// 信用卡 紅利啟用 
        /// <para>1=啟用</para> 
        /// </summary>
        /// <value>
        /// The credit red.
        /// </value>
        public int? CreditRed { get; set; }
        /// <summary>
        /// 信用卡 分期付款啟用 
        /// <para>3=分3期功能</para>
        /// <para>6=分6期功能</para>
        /// <para>12=分12期功能</para>  
        /// <para>18=分18期功能</para>  
        /// <para>24=分24期功能</para>   
        /// <para>30=分30期功能</para> 
        /// </summary>
        /// <value>
        /// 
        /// </value>
        public string InstFlag { get; set; }

        public int? WEBATM { get; set; }
        /// <summary>
        /// WEBATM 啟用
        /// <para>1=啟用</para> 
        /// </summary>
        /// <value>
        /// The credit red.
        /// </value>
        public int? UNIONPAY { get; set; }
        /// <summary>
        /// 信用卡 銀聯卡啟用
        /// <para>1=啟用</para> 
        /// </summary>
        /// <value>
        /// The credit red.
        /// </value>
        public int? ANDROIDPAY { get; set; }
        /// <summary>
        /// Google Pay啟用
        /// <para>1=啟用</para> 
        /// </summary>
        /// <value>
        /// The credit red.
        /// </value>
        ///     public int? ANDROIDPAY { get; set; }
        /// <summary>
        public int? SAMSUNGPAY { get; set; }
        /// SAMSUNGPAY啟用
        /// <para>1=啟用</para> 
        /// </summary>
        /// <value>
        /// The credit red.
        /// </value>
      
    }
    public class TradeInfoLog
    {
        public string Status { get; set; }
        public string Message { get; set; }
        public TradeInfoResult Result { get; set; }

    }
    public class TradeInfoResult
    {
        //所有支付方式共同回傳參數
        public string MerchantID { get; set; }
        public string Amt { get; set; }
        public string TradeNo { get; set; }
        public string MerchantOrderNo { get; set; }
        public string RespondType { get; set; }
        public string IP { get; set; }
        public string EscrowBank { get; set; }
        //信用卡支付回傳參數（包含：Google Pay、Samaung Pay）
        public string PaymentType { get; set; }
        public string RespondCode { get; set; }
        public string Auth { get; set; }
        public string Card6No { get; set; }
        public string Card4No { get; set; }
        public string Exp { get; set; }
        public string TokenUseStatus { get; set; }
        public string InstFirst { get; set; }
        public string InstEach { get; set; }
        public string Inst { get; set; }
        public string ECI { get; set; }
        public string PayTime { get; set; }
        public string PaymentMethod { get; set; }
        public string RedAmt { get; set; }
        public string CardType { get; set; }
        //WEBATM、ATM 繳費回傳參數      
        public string ExpireDate { get; set; }
        public string ExpireTime { get; set; }
        public string BankCode { get; set; }
        public string CodeNo { get; set; }
        //超商條碼繳費回傳參數
        public string Barcode_1 { get; set; }
        public string Barcode_2 { get; set; }
        public string Barcode_3 { get; set; }
        public string PayStore { get; set; }
        //超商物流回傳參數
        public string StoreCode { get; set; }
        public string StoreName { get; set; }
        public string StoreType { get; set; }
        public string StoreAddr { get; set; }
        public string TradeType { get; set; }
        public string CVSCOMName { get; set; }
        public string CVSCOMPhone { get; set; }

    }
}
namespace pay2go.Models
{
    public class pay2goInfo
    {
       
        /// <summary>
        /// 回傳格式 
        /// <para>JSON 或是 String</para>
        /// </summary>
        /// <value>
        /// The type of the respond.
        /// </value>
        public string RespondType { get; set; }
        /// <summary>
        /// TimeStamp
        /// <para>自從 Unix 纪元（格林威治時間 1970 年 1 月 1 日 00:00:00）到當前時間的秒數。</para>
        /// </summary>
        /// <value>
        /// The time stamp.
        /// </value>
        public string TimeStamp { get; set; }
        /// <summary>
        /// 串接程式版本 
        /// </summary>
        /// <value>
        /// The version.
        /// </value>
        public string Version { get; set; }
        /// <summary>
        /// 智付寶平台交易序號
        /// </summary>
        /// <value>
        /// The TransNum .
        /// </value>
        public string TransNum { get; set; }
        /// <summary>
        /// 商店訂單編號 
        /// <para>限英、數字、_ 格式</para>
        /// </summary>
        /// <value>
        /// The merchant order no.
        /// </value>
        public string MerchantOrderNo { get; set; }
        /// <summary>
        /// 開立發票方式
        /// <para>1=即時開立發票</para>
        /// <para>0=等待觸發開立發票</para>
        /// <para>3=預約自動開立發票(</para>         
        /// </summary>
        /// <value>
        /// 1/2/3
        /// </value>
        public string Status { get; set; }
        /// <summary>
        /// 預計開立日期 
        /// </summary>
        /// <value>
        ///YYYY-MM-DD
        /// </value>
        public string CreateStatusTime { get; set; }
        /// <summary>
        /// 發票種類 
        /// </summary>
        /// <value>
        /// B2B/ B2C
        /// </value>
        public string Category { get; set; }
        /// <summary>
        /// 買受人名稱 
        /// </summary>
        /// <value>
        /// BuyerName
        /// </value>
        public string BuyerName { get; set; }
        /// <summary>
        /// 買受人統一編號
        /// </summary>
        /// <value>
        ///  BuyerUBN
        /// </value>
        public string BuyerUBN { get; set; }
        /// <summary>
        /// 買受人地址
        /// </summary>
        /// <value>
        /// address
        /// </value>
        public string BuyerAddress { get; set; }
        /// <summary>
        /// 買受人電子信箱
        /// </summary>
        /// <value>
        /// BuyerEmail.
        /// </value>
        public string BuyerEmail { get; set; }
        /// <summary>
        /// 買受人電話
        /// </summary>
        /// <value>
        /// BuyerEmail.
        /// </value>
        public string BuyerPhone { get; set; }
        /// <summary>
        /// 載具類別
        /// </summary>
        /// <value>
        ///Varchar(2)
        /// </value>
        public string CarrierType { get; set; }
        /// <summary>
        /// 載具編號 
        /// </summary>
        /// <value>
        ///Varchar(50)
        /// </value>
        public string  CarrierNum { get; set; }
        /// <summary>
        /// 愛心碼 
        /// </summary>
        /// <value>
        ///Varchar(7)
        /// </value>
        public string  LoveCode { get; set; }
        /// <summary>
        /// 索取紙本發票
        /// </summary>
        /// <value>
        ///Varchar(1)
        /// </value>
        public string PrintFlag { get; set; }
        /// <summary>
        /// 課稅別
        /// </summary>
        /// <value>
        ///Varchar(2)
        /// </value>
        public string TaxType { get; set; }
        /// <summary>
        /// 稅率
        /// </summary>
        /// <value>
        ///18.5.0
        /// </value>       
         public int TaxRate { get; set; }
        /// <summary>
        /// 報關標記
        /// </summary>
        /// <value>
        ///Varchar(1)
        /// </value>
        public string CustomsClearance { get; set; }
        /// <summary>
        /// 銷售額合計
        /// </summary>
        /// <value>
        ///amt
        /// </value>
        public int Amt { get; set; }
        /// <summary>
        /// 銷售額(課稅別應稅)
        /// </summary>
        /// <value>
        ///AmtSales
        /// </value>
        public int AmtSales { get; set; }
        /// <summary>
        /// 銷售額(課稅別零稅率)
        /// </summary>
        /// <value>
        /// AmtZero
        /// </value>
        public int AmtZero { get; set; }
        /// <summary>
        /// 銷售額(課稅別免稅)
        /// </summary>
        /// <value>
        /// AmtFree
        /// </value>
        public int AmtFree { get; set; }
        /// <summary>
        /// 稅額
        /// </summary>
        /// <value>
        ///TaxAmt 
        /// </value>
        public int TaxAmt { get; set; }
        /// <summary>
        /// 發票金額
        /// </summary>
        /// <value>
        ///TotalAmt 
        /// </value>
        public int TotalAmt { get; set; }
        /// <summary>
        /// 商品名稱
        /// </summary>
        /// <value>
        ///PDname|pdname
        /// </value>
        public string ItemName { get; set; }
        /// <summary>
        /// 商品數量
        /// </summary>
        /// <value>
        ///ItemCount
        /// </value>
        public string ItemCount { get; set; }
        /// <summary>
        /// 商品單位
        /// </summary>
        /// <value>
        ///ItemUnit
        /// </value>
        public string ItemUnit { get; set; }
        /// <summary>
        /// 商品單價
        /// </summary>
        /// <value>
        ///ItemPrice 
        /// </value>
        public string ItemPrice { get; set; }
        /// <summary>
        /// 商品小計
        /// </summary>
        /// <value>
        ///ItemAmt 
        /// </value>
        public string ItemAmt { get; set; }
        /// <summary>
        /// 商品課稅別
        /// </summary>
        /// <value>
        ///ItemTaxType
        /// </value>
        public string  ItemTaxType { get; set; }

        /// <summary>
        /// 備註
        /// </summary>
        /// <value>
        /// 備註
        /// </value>
        public string Comment { get; set; }
        
    

    }
}