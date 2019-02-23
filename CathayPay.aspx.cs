using System;
using System.Web;
using System.Data;
using System.Data.OleDb;
using unity;
using System.Xml;
using System.IO;

using System.Security.Cryptography;
using System.Text;
public partial class CathayPayaspx : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string msg = "<?xml version=\"1.0\" encoding=\"big5\"?><MYB2B><HEADER><TXNO>2019021216594860</TXNO><SecureFunc>1</SecureFunc></HEADER><BODY><DATA>4300760066004D002F0065003300300063003200530048003800550069004B006200420048004B0041006400450066004C0048004C0076005900730053005400590032004E004200530051005A00460065004200530041007900660062002B007600300045003400750057002B006200770050006100760072005600410052005900490038006200670048006B0039007800380037004F0071004E007700380032006E00690053005900540045006700630039007200320052004A006A002B004600340043004B0069003300430072007900770077006E007500490066007A007300330035007700530045002B0077006D00420054006200460073006E004400470051005900750070006A0063003900390045006D00300039006E00620037004E005500420051002F005A0072004C005100690033006500360043003000640075006A0037004800790041006600360050005A006500610079003000490074003300750067007400480062006F002B0078003800670048002B006A00320058006D007300740043004C00640037006F004C00520032003600500073006600490042002F006F0039006C00780034003200790038007400720038006B00630057004300320070007A0031006B004200430067005A00450063007600730039005A004E0043002F004500750041006800590039004700330054003700350051006A0061007100790039004E00720043006900350034004C00630069007600680076005A0031006E007500350051003D003D00</DATA></BODY></MYB2B>";
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.LoadXml(msg);
        string key = "rollersports7211";       
        byte[] bdata ;       
        foreach (XmlNode xNode in xmlDoc.SelectNodes("//MYB2B/BODY"))
        {
           
            string data= xNode.SelectSingleNode("DATA").InnerText;   
            bdata = HexToByte(data);
            data = System.Text.Encoding.ASCII .GetString(bdata);   
            msg = "";
            foreach (char c in data)
            {
                int unicode = c;
                if (unicode  !=0   ) msg += Convert.ToChar(c);
            }
            Response.Write(AES_Decrypt(msg, key));
        }
       
    }

  
    public static byte[] HexToByte( string hexString)
    {
        //運算後的位元組長度:16進位數字字串長/2
        byte[] byteOUT = new byte[hexString.Length / 2];
        for (int i = 0; i < hexString.Length; i = i + 2)
        {
            //每2位16進位數字轉換為一個10進位整數
            byteOUT[i / 2] = Convert.ToByte(hexString.Substring(i, 2), 16);
        }
        return byteOUT;
    }

  
    public string  AES_Decrypt(string strData, string strKey )
    {


                Encoding encoding = Encoding.GetEncoding("utf-8");
                byte[] keyArray = encoding.GetBytes(strKey);
                byte[] toEncryptArray = Convert.FromBase64String(strData);
                RijndaelManaged rDel = new RijndaelManaged();
                rDel.Key = keyArray;
                rDel.Mode = CipherMode.ECB;
                rDel.Padding = PaddingMode.PKCS7;
                ICryptoTransform cTransform = rDel.CreateDecryptor();
                byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0,
                toEncryptArray.Length);
                //strResult = UTF8Encoding.UTF8.GetString(resultArray);
                strData = Encoding.GetEncoding("big5").GetString(resultArray);
               

        return strData;
    }

}