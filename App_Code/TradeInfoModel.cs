﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json.Linq;

namespace SpGatewayHelper.Models
{

    public class TradeInfoModel
    {
        public string Status { get; set; }
        public string Message { get; set; }
        public Result Result { get; set; }
    }

    public class Result
    {
        public string MerchantID { get; set; }
        public int Amt { get; set; }
        public string TradeNo { get; set; }
        public string MerchantOrderNo { get; set; }
        public string RespondType { get; set; }
        public string IP { get; set; }
        public string EscrowBank { get; set; }
        public string PaymentType { get; set; }
        public string PayTime { get; set; }
        public string PayerAccount5Code { get; set; }
        public string PayBankCode { get; set; }
        public string RespondCode { get; set; }
        public string Auth { get; set; }
        public string Card6No { get; set; }
        public string Card4No { get; set; }
        public int Inst { get; set; }
        public int RedAmt { get; set; }
        public string CodeNo { get; set; }
        public string Barcode_1 { get; set; }
        public string Barcode_2 { get; set; }
        public string Barcode_3 { get; set; }
        public string PayStore { get; set; }
        public string ExpireDate { get; set; }
        public string ExpireTime { get; set; }
        public string BankCode { get; set; }

    }
}
namespace pay2go.Models
{

    public class pay2goModel
    {
        public string Status { get; set; }
        public string Message { get; set; }
        public Result Result { get; set; }
    }

    public class Result
    {
      
        public string MerchantID { get; set; }
        public string InvoiceTransNo { get; set; }
        public string MerchantOrderNo { get; set; }
        public int TotalAmt { get; set; }
        public string InvoiceNumber  { get; set; }
        public string RandomNum { get; set; }
        public string CreateTime { get; set; }
        public string CheckCode { get; set; }
        public string BarCode { get; set; }
        public string QRcodeL { get; set; }
        public string QRcodeR { get; set; }
        public string AllowanceAmt { get; set; }
        public string RemainAmt { get; set; }

        public static implicit operator Result(JToken v)
        {
            throw new NotImplementedException();
        }
    }
}
