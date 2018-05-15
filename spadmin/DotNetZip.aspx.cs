using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ionic;
using Ionic.Zip;
using System.IO;
using System.Collections;


public partial class DotNetZip_ : System.Web.UI.Page
{
    string dirPath = "upload";
    protected void Page_Load(object sender, EventArgs e)
    {
        //在這邊提醒一下，DotNetZip 支援多檔案壓縮，只要在增加  zip.AddFile(filePath, "");  這行程式及可。
      
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        // 檢查檔案是否存在
        if (FileUpload1.HasFile)
        {
            try
            {
                string filePath = Server.MapPath(dirPath) + FileUpload1.FileName;
                string zipPath = "";
                // 儲存檔案
                FileUpload1.SaveAs(filePath);
                // 壓縮檔案
                using (ZipFile zip = new ZipFile())
                {
                    zip.Password = "arvin"; // 加入密碼
                    zip.AddFile(filePath, "");
                    zipPath = string.Format("{0}{1}\\{2}.zip", Server.MapPath(dirPath), "Compress", DateTime.Now.ToString("yyyyMMddHHmmss"));
                    zip.Save(zipPath);
                }
                TextBox1.Text = zipPath;
                TextBox2.Text = filePath;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        string zipFilePath = TextBox1.Text;
        // 檢查檔案是否存在
        if (File.Exists(zipFilePath))
        {
            try
            {
                var options = new ReadOptions { StatusMessageWriter = System.Console.Out };
                using (ZipFile zip = ZipFile.Read(zipFilePath, options))
                {
                    zip.Password = "arvin"; // 解壓密碼
                    zip.ExtractAll(Server.MapPath(dirPath) + "Extract\\");  // 解壓全部
                }
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        string filePath = TextBox2.Text;

        Response.Clear();
        Response.ContentType = "application/zip";
        Response.AddHeader("content-disposition", "filename=" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".zip");

        using (ZipFile zip = new ZipFile())
        {
            zip.AddFile(filePath, "");
            zip.Save(Response.OutputStream);
        }
        Response.End();
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        string filePath = Server.MapPath(dirPath) + FileUpload2.FileName;
       
        // 儲存檔案
        FileUpload2.SaveAs(filePath);
        var options = new ReadOptions { StatusMessageWriter = System.Console.Out };
        using (ZipFile zip = ZipFile.Read(filePath, options))
        {
            
            zip.ExtractAll(Server.MapPath(dirPath) + "/Extract", ExtractExistingFileAction.OverwriteSilently);  // 解壓全部
        }


  
    }

    private void btZip_Click(object sender, EventArgs e)
    {
        string path = @"d:\tmp\test";//要壓縮檔案的目錄路徑
        ZipFiles(path, string.Empty, string.Empty);
    }

    private void btUnzip_Click(object sender, EventArgs e)
    {
        string path = @"d:\tmp\test1\test.zip";//壓縮檔案路徑
        UnZipFiles(path, string.Empty);
    }

    //讀取目錄下所有檔案
    private static ArrayList GetFiles(string path)
    {
        ArrayList files = new ArrayList();

        if (Directory.Exists(path))
        {
            files.AddRange(Directory.GetFiles(path));
        }

        return files;
    }

    //建立目錄
    private static void CreateDirectory(string path)
    {
        if (!Directory.Exists(path))
        {
            Directory.CreateDirectory(path);
        }
    }

    //壓縮檔案
    //path: 壓縮檔案路徑
    //password: 密碼
    //comment: 註解
    private void ZipFiles(string path, string password, string comment)
    {
        string zipPath = path + @"\" + Path.GetFileName(path) + ".zip";
        ZipFile zip = new ZipFile();
        if (password != null && password != string.Empty) zip.Password = password;
        if (comment != null && comment != "") zip.Comment = comment;
        ArrayList files = GetFiles(path);
        foreach (string f in files)
        {
            zip.AddFile(f, string.Empty);//第二個參數設為空值表示壓縮檔案時不將檔案路徑加入
        }
        zip.Save(zipPath);
    }

    //解壓縮檔案
    //path: 解壓縮檔案目錄路徑
    //password: 密碼
    private void UnZipFiles(string path, string password)
    {
        ZipFile unzip = ZipFile.Read(path);
        if (password != null && password != string.Empty) unzip.Password = password;
        string unZipPath = path.Replace(".zip", "");

        foreach (ZipEntry e in unzip)
        {
            e.Extract(unZipPath, ExtractExistingFileAction.OverwriteSilently);
        }
    }

}