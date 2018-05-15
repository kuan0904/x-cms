<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DotNetZip.aspx.cs" Inherits="DotNetZip_" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
   <div>
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <br />
        <asp:Button ID="Button1" runat="server" Text="上傳並壓縮檔案" onclick="Button1_Click" />
        <br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="Button2" runat="server" Text="解壓檔案" onclick="Button2_Click" />
        <br />
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="Button3" runat="server" Text="壓縮下載" onclick="Button3_Click" /> <br />
       <asp:FileUpload ID="FileUpload2" runat="server" /><asp:Button ID="Button4" runat="server" Text="Button" OnClick="Button4_Click" />
    </div>
    </form>
</body>
</html>
