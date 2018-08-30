<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pay.aspx.cs" Inherits="pay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body onload="document.Spgateway.submit()">
<form name='Spgateway' method='post' action='<%=action %>'>
資料處理中...請稍後!
    <input type='hidden' name='MerchantID' value='<%=MerchantID %>'/>
     <input type='hidden' name='TradeInfo' value='<%= aes %>'/>
     <input type='hidden' name='TradeSha' value='<%=Sha %>'/>
      <input type='hidden' name='Version' value='1.4'/>
</form>
</body>
</html>
