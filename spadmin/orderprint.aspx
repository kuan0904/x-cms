<%@ Page Language="C#" AutoEventWireup="true" CodeFile="orderprint.aspx.cs" Inherits="spadmin_orderprint" %>
<html>
    <head  >
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body onload ="window.print();">
   
         <style >
        .fa {
  line-height:2;
}
    </style>
    <table border="0"   class ="fa" width="80%"  align="center">
            <tr>
                <td colspan="2"><img src="img/logo.png" /></td>
                 <td  colspan="2" style="text-align: right">  訂單號碼:<b><%=ord_code  %> </b> <br />
                        訂購日期:<%=ord_date %><br />
                        付款方式:<b><%=paymode %></b> <br />
                        訂單狀態:<%=ord_status%><br />
                        付款狀態:<%=paid %>
                 </td>     
            </tr>
            <tr>
                <td >訂購人:</td>
                <td><%=ordname %></td>
                <td >取貨方式: </td>
                <td>宅配到府</td>                                                                                                                   
            </tr>                                     
            <tr>
                <td>訂購人Email: </td>
                <td><%=ordemail  %></td>
                <td>收件時間:</td>
                <td><b><%=receivetime %></b></td>                                                                                                                   
            </tr> 
              <tr>
                <td>訂購人電話: </td>
                <td><%=ordphone  %></td>
                <td>發票資訊:</td>
                <td><%=invoice  %> </td>                                                                                                                   
            </tr> 
            <tr>
                <td>姓別: </td>
                <td><%=ordgender%></td>
                <td>統一編號:</td>
                <td><%=companyno %></td>                                                                                                                   
            </tr> 
              <tr>
                <td>收件人:</td>
                <td><b><%=shipname %></b></td>
                <td>發票抬頭:</td>
                <td><%=title %>  </td>                                                                                                                   
            </tr>                                     
     
              <tr>
                <td>收件人電話: </td>
                <td><b><%=shipphone  %></b></td>
                <td>收件時間:</td>
                <td><b><%=receivetime %> </b></td>                                                                                                                   
            </tr> 
            <tr>
                <td>姓別: </td>
                <td><%=shipgender  %></td>
                <td  >備註說明：</td>
                <td   ><%=contents %> </td>                                                                                                                   
            </tr> 
                              
                                        <tr>
                                            <td>收件地址</td>
                                            <td  colspan ="3"> <b><%=shipaddress %></b></td>                                           
                                        
                                    </tr>
                                
                            
                                    <tr>
                                        <td colspan="4">
                                                <table   align="center"  width="100%"  style="border-width:1px;border-color:black ; border-style:dotted ;">
                                                <tr>
                                                    <td> 訂購明細</td>
                                                </tr>
                                            </table>
                                           </td>                                         
                                           
                                    </tr>
                                  
                                    <tr>
                                        <td colspan ="4">
                                            <table width="100%" border="1" cellpadding="0" cellspacing=" 0" >
                                                  <tr>
                                      <td>品名</td>
                                        <td  align="center">單價</td>
                                        <td  align="center">數量</td>
                                        <td align="center">小計</td>
                                    </tr>
                                            
                                    <asp:Repeater ID="Repeater1" runat="server">
                                        <ItemTemplate>
                                        <tr>                                        
                                        <td><%#Eval("productname") %></td>
                                        <td align="right" >$<%#Eval("price") %></td>
                                        <td align="center" ><%#Eval("num") %></td>
                                        <td align="right" >$<%#Eval("amount") %></td>
                                    </tr>

                                        </ItemTemplate>

                                    </asp:Repeater></table>
                                            </td>
                                    </tr>
                                <tr> 
                                     <td  colspan="4" align="right" >
                                            <table      style="border-width:1px;border-color:black ; border-style:dotted ;">
                                                <tr>
                                                    <td  align="right" >   商品小計$<%=SubPrice %></td>
                                                </tr>
                                            </table>
                                            <table      style="border-width:1px;border-color:black ; border-style:dotted ;">
                                                <tr>
                                                    <td  align="right" >   運費$<%=DeliveryPrice %></td>
                                                </tr>
                                            </table>
                                            <table        style="border-width:1px;border-color:black ; border-style:dotted ;">
                                                <tr>
                                                    <td  align="right" >   訂單金額<b>$<%=totalprice %></b> </td>
                                                </tr>
                                            </table>
                                   
                                </td>
                                </tr>

                              
                            </table>
    
</body>
</html>
