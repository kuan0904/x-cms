using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using SpGatewayHelper.Helper;
using System.Collections.Specialized;
using System.IO;
using SpGatewayHelper.Models;

namespace SpGatewayHelper
{
    public class SpGatewayResponse
    {
        public string Status { get; set; }
        public string MerchantId { get; set; }
        public string TradeInfo { get; set; }
        public string TradeSha { get; set; }
        public string Version { get; set; }
        public string Key { get; set; }
        public string Vi { get; set; }
        
        public string  SaveLog()
        {
            try
            {
                string msg = "";
            string xml_file = DateTime.Today.ToString("yyyyMMdd") + ".txt";
            //"/log/" +
            xml_file = System.Web.HttpContext.Current.Server.MapPath("/log/" + xml_file);
            if (System.IO.File.Exists(xml_file))
            {
                msg = unity.classlib.GetTextString(xml_file);
            }
            StreamWriter fp = new StreamWriter(xml_file);
            msg += "\r\n[" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "]\r\n";
            msg += "Status:" + Status + "\r\n";
            msg += "MerchantID:" + MerchantId + "\r\n";
            msg += "TradeInfo:" + TradeInfo + "\r\n";
            var cryptoHelper = new CryptoHelper(Key, Vi);
            var jsonString = cryptoHelper.DecryptAesString(TradeInfo);
            msg += JsonConvert.DeserializeObject(jsonString);
            fp.WriteLine(msg);
            fp.Close();
            fp.Dispose();
            }
            catch (Exception e)
            {
                unity.classlib.SendsmtpMail("leokuan@xnet.world", "error", e.Message);
            }
            return "";
        }
        public TradeInfoLog AddCardlog()
        {   var cryptoHelper = new CryptoHelper(Key, Vi);
            var jsonString = cryptoHelper.DecryptAesString(TradeInfo);
            TradeInfoLog log = JsonConvert.DeserializeObject<TradeInfoLog>(jsonString);
            try
            {
               
            string strsql = @"insert into TradeInfolog (MerchantID, Amt, TradeNo, MerchantOrderNo, 
                RespondType, IP, EscrowBank,PaymentType, RespondCode, Auth, Card6No, Card4No,Exp 
                ,TokenUseStatus, InstFirst, InstEach, Inst, ECI, PayTime,PaymentMethod, status,ord_code ) 
                values  (  @MerchantID, @Amt, @TradeNo, @MerchantOrderNo, 
                @RespondType, @IP, @EscrowBank,@PaymentType, @RespondCode, @Auth, @Card6No, @Card4No,@Exp 
               , @TokenUseStatus, @InstFirst, @InstEach, @Inst, @ECI, @PayTime,@PaymentMethod, @status,@ord_code)";
            NameValueCollection nvc = new NameValueCollection
            {
                { "MerchantID", MerchantId },
                { "Amt", log.Result.Amt },
                { "TradeNo", log.Result.TradeNo },
                { "MerchantOrderNo", log.Result.MerchantOrderNo },
                { "RespondType", log.Result.RespondType??""  },
                { "IP", log.Result.IP ??"" },
                { "EscrowBank", log.Result.EscrowBank??""  },
                { "PaymentType", log.Result.PaymentType ??"" },
                { "RespondCode", log.Result.RespondCode ??"" },
                { "Auth", log.Result.Auth ??"" },
                { "Card6No", log.Result.Card6No ?? "" },
                { "Card4No", log.Result.Card4No ??"" },
                { "Exp", log.Result.Exp ??"" },
                { "TokenUseStatus", log.Result.TokenUseStatus ?? "" },
                { "InstFirst", log.Result.InstFirst ??""  },
                { "InstEach", log.Result.InstEach ??""  },
                { "Inst", log.Result.Inst ??""  },
                { "ECI", log.Result.ECI ??"" },
                { "PayTime", log.Result.PayTime },
                { "PaymentMethod", log.Result.PaymentMethod ??"" },
                { "status", Status },
                { "ord_code", log.Result.MerchantOrderNo }
            };
       
                DbControl.Data_add(strsql, nvc);
                if (Status == "SUCCESS")
                {
                    strsql = @"update tbl_OrderData set paid='Y' ,status='2'
                        where ord_code=@ord_code";
                    nvc.Clear();
                    nvc.Add("ord_code", log.Result.MerchantOrderNo);
                    DbControl.Data_add(strsql, nvc);
                    

                }
            }
            catch (Exception e)
            {
                unity.classlib.SendsmtpMail("leokuan@xnet.world", "error", e.Message);
            }
            return log;
        }
        public TradeInfoLog AddAtmlog()
        {
            var cryptoHelper = new CryptoHelper(Key, Vi);
            var jsonString = cryptoHelper.DecryptAesString(TradeInfo);
            TradeInfoLog log = JsonConvert.DeserializeObject<TradeInfoLog>(jsonString);
            string strsql = @"insert into TradeInfolog (MerchantID, Amt, TradeNo, MerchantOrderNo, 
                RespondType, PaymentType, ExpireDate,ExpireTime, BankCode,CodeNo,status,ord_code ) 
                values  (  @MerchantID, @Amt, @TradeNo, @MerchantOrderNo, 
                @RespondType, @PaymentType, @ExpireDate,@ExpireTime, @BankCode,@CodeNo,@status
                ,@ord_code)";
            NameValueCollection nvc = new NameValueCollection
            {
                { "MerchantID", MerchantId },
                { "Amt", log.Result.Amt },
                { "TradeNo", log.Result.TradeNo },
                { "MerchantOrderNo", log.Result.MerchantOrderNo },
                { "PaymentType",log.Result.PaymentType  },
                { "RespondType", log.Result.RespondType },
                { "ExpireDate", log.Result.ExpireDate??""  },
                { "ExpireTime", log.Result.ExpireTime ??"" },
                { "BankCode", log.Result.BankCode  ??"" },
                { "CodeNo", log.Result.CodeNo ??""  },
                { "status", Status },
                { "ord_code", log.Result.MerchantOrderNo }
            };
            try
            {
                DbControl.Data_add(strsql, nvc);

            }
            catch (Exception e)
            {
                unity.classlib.SendsmtpMail("leokuan@xnet.world", "error", e.Message);
            }
            return log;
        }
        /// <summary>
        /// 驗證資料正確性
        /// </summary>
        /// <param name="merchantId">The merchant identifier.</param>
        /// <returns></returns>
        public bool Validate(string merchantId)
        {
            if (merchantId != MerchantId)
            {
                return false;
            }
            var cryptoHelper = new CryptoHelper(Key, Vi);
            var sha = cryptoHelper.GetSha256String(TradeInfo);
            return sha == TradeSha;
        }

        /// <summary>
        /// Gets the response model.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public T GetResponseModel<T>()
        {
            var cryptoHelper = new CryptoHelper(Key, Vi);
            var jsonString = cryptoHelper.DecryptAesString(TradeInfo);
            return JsonConvert.DeserializeObject<T>(jsonString);
        }

    }
}