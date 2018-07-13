<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pay.aspx.cs" Inherits="pay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body onload="document.Spgateway.submit()">
<form name='Spgateway' method='post' 
action='<%=action %>'>
   
    MerchantID：
    <input type='text' name='MerchantID' value='<%=MerchantID %>'/>
     <input type='text' name='TradeInfo' value='<%= aes %>'/>
     <input type='text' name='TradeSha' value='<%=Sha %>'/>
      <input type='text' name='Version' value='1.4'/>
<input type='submit' value='Submit'/>

</form>
</body>
</html>
