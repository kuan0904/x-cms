<%@ Page Language="C#" AutoEventWireup="true" CodeFile="invoive.aspx.cs" Inherits="invoive" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
<form name='pay2go' method='post' action='<%=action %>'/>
   
    MerchantID：
    <input type='text' name="MerchantID_" value='<%=MerchantID %>'/>  
     <input type='text' name='PostData_' value='<%=Sha %>'/>
   
<input type='submit' value='Submit'/>
</body>
</html>
