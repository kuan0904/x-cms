using System;
using System.Security.Cryptography;
using System.Text;
/// <summary>
/// MySecurity 的摘要描述
/// </summary>
/// 

public static class MySecurity
{
    public static string getHashSha256(string text) {
        byte[] bytes = Encoding.UTF8.GetBytes(text);
        SHA256Managed hashstring = new SHA256Managed();
        byte[] hash = hashstring.ComputeHash(bytes);
        string hashString = string.Empty;
        foreach (byte x in hash) {
            hashString += String.Format("{0:x2}", x);
        }
        return hashString.ToUpper();
    }
    public static string EncryptAES256(string source)//加密 
    { string sSecretKey = "12345678901234567890123456789012";
        string iv = "1234567890123456";
        byte[] sourceBytes = AddPKCS7Padding(Encoding.UTF8.GetBytes(source), 32);
        var aes = new RijndaelManaged(); aes.Key = Encoding.UTF8.GetBytes(sSecretKey);
        aes.IV = Encoding.UTF8.GetBytes(iv);
        aes.Mode = CipherMode.CBC;
        aes.Padding = PaddingMode.None;
        ICryptoTransform transform = aes.CreateEncryptor();
        return ByteArrayToHex(transform.TransformFinalBlock(sourceBytes, 0, sourceBytes.Length)).ToLower();
    }
    public static  string DecryptAES256(string encryptData)//解密 
    { string sSecretKey = "12345678901234567890123456789012";
        string iv = "1234567890123456";
        var encryptBytes = HexStringToByteArray(encryptData.ToUpper());
        var aes = new RijndaelManaged();
        aes.Key = Encoding.UTF8.GetBytes(sSecretKey);
        aes.IV = Encoding.UTF8.GetBytes(iv); aes.Mode = CipherMode.CBC;
        aes.Padding = PaddingMode.None;
        ICryptoTransform transform = aes.CreateDecryptor();
        return Encoding.UTF8.GetString(RemovePKCS7Padding(transform.TransformFinalBlock(encryptBytes, 0, encryptBytes.Length)));
    }
    private static byte[] AddPKCS7Padding(byte[] data, int iBlockSize)
    {
        int iLength = data.Length; byte cPadding = (byte)(iBlockSize - (iLength % iBlockSize));     

        var output = new byte[iLength + cPadding]; Buffer.BlockCopy(data, 0, output, 0, iLength); for (var i = iLength; i < output.Length; i++) output[i] = (byte)cPadding; return output;
    }
    private static byte[] RemovePKCS7Padding(byte[] data) { int iLength = data[data.Length - 1]; var output = new byte[data.Length - iLength]; Buffer.BlockCopy(data, 0, output, 0, output.Length); return output; }
    private static string ByteArrayToHex(byte[] barray) { char[] c = new char[barray.Length * 2]; byte b; for (int i = 0; i < barray.Length; ++i) { b = ((byte)(barray[i] >> 4)); c[i * 2] = (char)(b > 9 ? b + 0x37 : b + 0x30); b = ((byte)(barray[i] & 0xF)); c[i * 2 + 1] = (char)(b > 9 ? b + 0x37 : b + 0x30); } return new string(c); }

    private static byte[] HexStringToByteArray(string hexString)
    { int hexStringLength = hexString.Length; byte[] b = new byte[hexStringLength / 2]; for (int i = 0; i < hexStringLength; i += 2) { int topChar = (hexString[i] > 0x40 ? hexString[i] - 0x37 : hexString[i] - 0x30) << 4; int bottomChar = hexString[i + 1] > 0x40 ? hexString[i + 1] - 0x37 : hexString[i + 1] - 0x30; b[i / 2] = Convert.ToByte(topChar + bottomChar); }
        return b;
    }
    
    internal static string ByteArrayToHexString(byte[] inputArray)
    {
        if (inputArray == null)
            return null;
        var o = new StringBuilder("");
        for (var i = 0; i < inputArray.Length; i++)
            o.Append(inputArray[i].ToString("X2"));
        return o.ToString();
    }
    public static string HashMD5(string phrase)
    {
        if (phrase == null)
            return null;
        var encoder = new UTF8Encoding();
        var md5Hasher = new MD5CryptoServiceProvider();
        var hashedDataBytes = md5Hasher.ComputeHash(encoder.GetBytes(phrase));
        return ByteArrayToHexString(hashedDataBytes);
    }
    public static string SimpleTripleDes(string Data)
 
        {
            byte[] key = Encoding.UTF8.GetBytes("networld23222635");
            byte[] iv = Encoding.UTF8.GetBytes("xnet2322");
            byte[] data = Encoding.UTF8.GetBytes(Data);
            byte[] enc = new byte[0];


            //System.Security.Cryptography.TripleDESCryptoServiceProvider des = new System.Security.Cryptography.TripleDESCryptoServiceProvider();
            //byte[] inputByteArray = System.Text.Encoding.UTF8.GetBytes(Data);
            //des.Key = System.Text.Encoding.UTF8.GetBytes("edcvfrtg");
            //des.IV = System.Text.Encoding.UTF8.GetBytes("xnet2635");
            //des.Mode = System.Security.Cryptography.CipherMode.CBC;
            //des.Padding = System.Security.Cryptography.PaddingMode.PKCS7;
            //System.IO.MemoryStream ms = new System.IO.MemoryStream();
            //System.Security.Cryptography.CryptoStream cs = new System.Security.Cryptography.CryptoStream(ms, des.CreateEncryptor(), System.Security.Cryptography.CryptoStreamMode.Write);
            //System.IO.StreamWriter swEncrypt = new System.IO.StreamWriter(cs);




            TripleDES tdes = TripleDES.Create();

            tdes.IV = iv;
            tdes.Key = key;
            tdes.Mode = CipherMode.CBC;
            tdes.Padding = PaddingMode.Zeros;
            ICryptoTransform ict = tdes.CreateEncryptor();
            enc = ict.TransformFinalBlock(data, 0, data.Length);
            return ByteArrayToString(enc);
        }

    public  static string SimpleTripleDesDecrypt(string Data)
    {
            byte[] key = Encoding.UTF8.GetBytes("networld23222635");
            byte[] iv = Encoding.UTF8.GetBytes("xnet2322");
            byte[] data = StringToByteArray(Data);
            byte[] enc = new byte[0];
            TripleDES tdes = TripleDES.Create();
            tdes.IV = iv;
            tdes.Key = key;
            tdes.Mode = CipherMode.CBC;
            tdes.Padding = PaddingMode.Zeros;
            ICryptoTransform ict = tdes.CreateDecryptor();
            enc = ict.TransformFinalBlock(data, 0, data.Length);
            return Encoding.UTF8.GetString(enc);
        }

    public static string ByteArrayToString(byte[] ba)
    {
        string hex = BitConverter.ToString(ba);
        return hex.Replace("-", "");
    }

    public static byte[] StringToByteArray(String hex)
    {
        int NumberChars = hex.Length;
        byte[] bytes = new byte[NumberChars / 2];
        for (int i = 0; i < NumberChars; i += 2)
            bytes[i / 2] = Convert.ToByte(hex.Substring(i, 2), 16);
        return bytes;
    }

    public static string test()
    {
        string result = SimpleTripleDes("林小如");

       
        // DECRYPTING
        result = SimpleTripleDesDecrypt(result);
        return("<br>" + result);

    }

}

public static class Crypto
{
    static readonly string keyString = "edcvfrtg";
    static readonly string iv = "3456ytre";
    static Encoding TheEncoding = Encoding.UTF8;
    #region MD5

    public static string HashMD5(string phrase)
    {
        if (phrase == null)
            return null;
        var encoder = new UTF8Encoding();
        var md5Hasher = new MD5CryptoServiceProvider();
        var hashedDataBytes = md5Hasher.ComputeHash(encoder.GetBytes(phrase));
        return ByteArrayToHexString(hashedDataBytes);
    }

    #endregion

    #region SHA

    public static string HashSHA1(string phrase)
    {
        if (phrase == null)
            return null;
        var encoder = new UTF8Encoding();
        var sha1Hasher = new SHA1CryptoServiceProvider();
        var hashedDataBytes = sha1Hasher.ComputeHash(encoder.GetBytes(phrase));
        return ByteArrayToHexString(hashedDataBytes);
    }

    public static string HashSHA256(string phrase)
    {
        if (phrase == null)
            return null;
        var encoder = new UTF8Encoding();
        var sha256Hasher = new SHA256CryptoServiceProvider();
        var hashedDataBytes = sha256Hasher.ComputeHash(encoder.GetBytes(phrase));
        return ByteArrayToHexString(hashedDataBytes);
    }

    public static string HashSHA384(string phrase)
    {
        if (phrase == null)
            return null;
        var encoder = new UTF8Encoding();
        var sha384Hasher = new SHA384CryptoServiceProvider();
        var hashedDataBytes = sha384Hasher.ComputeHash(encoder.GetBytes(phrase));
        return ByteArrayToHexString(hashedDataBytes);
    }

    public static string HashSHA512(string phrase)
    {
        if (phrase == null)
            return null;
        var encoder = new UTF8Encoding();
        var sha512Hasher = new SHA512CryptoServiceProvider();
        var hashedDataBytes = sha512Hasher.ComputeHash(encoder.GetBytes(phrase));
        return ByteArrayToHexString(hashedDataBytes);
    }

    #endregion

  

    #region 3DES

    public static string EncryptTripleDES(string phrase, string key, bool hashKey = true)
    {
        var keyArray = HexStringToByteArray(hashKey ? HashMD5(key) : key);
        var toEncryptArray = Encoding.UTF8.GetBytes(phrase);

        var tdes = new TripleDESCryptoServiceProvider
        {
            Key = keyArray,
            Mode = CipherMode.ECB,
            Padding = PaddingMode.PKCS7
        };

        var cTransform = tdes.CreateEncryptor();
        var resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);

        tdes.Clear();
        return ByteArrayToHexString(resultArray);
    }

    public static string DecryptTripleDES(string hash, string key, bool hashKey = true)
    {
        var keyArray = HexStringToByteArray(hashKey ? HashMD5(key) : key);
        var toEncryptArray = HexStringToByteArray(hash);

        var tdes = new TripleDESCryptoServiceProvider
        {
            Key = keyArray,
            Mode = CipherMode.ECB,
            Padding = PaddingMode.PKCS7
        };

        var cTransform = tdes.CreateDecryptor();
        var resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);

        tdes.Clear();
        return Encoding.UTF8.GetString(resultArray);
    }

    #endregion

    #region Helpers

    internal static string ByteArrayToHexString(byte[] inputArray)
    {
        if (inputArray == null)
            return null;
        var o = new StringBuilder("");
        for (var i = 0; i < inputArray.Length; i++)
            o.Append(inputArray[i].ToString("X2"));
        return o.ToString();
    }

    internal static byte[] HexStringToByteArray(string inputString)
    {
        if (inputString == null)
            return null;

        if (inputString.Length == 0)
            return new byte[0];

        if (inputString.Length % 2 != 0)
            throw new Exception("Hex strings have an even number of characters and you have got an odd number of characters!");

        var num = inputString.Length / 2;
        var bytes = new byte[num];
        for (var i = 0; i < num; i++)
        {
            var x = inputString.Substring(i * 2, 2);
            try
            {
                bytes[i] = Convert.ToByte(x, 16);
            }
            catch (Exception ex)
            {
                throw new Exception("Part of your \"hex\" string contains a non-hex value.", ex);
            }
        }
        return bytes;
    }

    #endregion
}
