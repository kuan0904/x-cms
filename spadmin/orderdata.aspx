<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="orderdata.aspx.cs" Inherits="spadmin_orderdata" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        $(document).ready(function(){ 
          $("#<%=strdate.ClientID %>").datepicker();
          $("#<%=strdate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");
          $("#<%=enddate.ClientID %>").datepicker();
          $("#<%=enddate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");

      });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="DataOrderDataDataContext" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="OrderData">
    </asp:LinqDataSource>
  
            <div class="box-content">

             
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>" SelectCommand=""></asp:SqlDataSource>

                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                     <div >
                        <h2>訂單管理</h2>
                            日期區間<asp:TextBox ID="strdate" runat="server" Width="100px"></asp:TextBox>
                        至<asp:TextBox ID="enddate" runat="server" Width="100px"></asp:TextBox>                                                
                        付款方式:<asp:DropDownList ID="qpaykind" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem  Value="">不區分</asp:ListItem>
                            <asp:ListItem  Value="2">atm</asp:ListItem>
                            <asp:ListItem Value="3">貨到付款</asp:ListItem>
                            <asp:ListItem  Value="1">信用卡</asp:ListItem>
                        </asp:DropDownList>
                         狀態:<asp:DropDownList ID="qstatus" DataValueField="id" DataTextField ="name" runat="server"></asp:DropDownList>
                        關鍵字<asp:TextBox ID="keyword" runat="server"></asp:TextBox>
                        <asp:Button ID="btn_search" runat="server" Text="訂單查詢" OnClick="btn_search_Click" class="btn btn-success" />
                                         <asp:Button ID="btn_csv" runat="server" Text="匯出出貨單" OnClick="btn_csv_Click"  class="btn btn-success" />
                    <%=outfile  %>
                </div> 
                                 <asp:ListView ID="ListView1" runat="server" DataKeyNames="ord_code" 
                            OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging" OnItemDataBound ="ListView1_ItemDataBound">


                            <EmptyDataTemplate>
                                <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                                    <tr>
                                        <td>未傳回資料。</td>
                                    </tr>
                                </table>
                            </EmptyDataTemplate>

                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="EditButton" runat="server" Text="" OnClick="link_edit" CommandName="Edit1" CommandArgument='<%# Eval("ord_id")%>'
                                            class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                                    </td>
                                      <td><%# Eval("ord_id") %> </td>
                                    <td><%# Eval("ord_code") %> </td>
                                    <td><%# DateTime.Parse ( Eval("crtdat").ToString()).ToString ("yyyy/MM/dd")  %></td>
                                    <td><%# Eval("ordname") %></td>
                                    <td><%# get_pd(Eval ("ord_code").ToString () ).Replace (",","<BR>")   %></td>
                                    <td><%# Eval("TotalPrice") %></td>
                                     <td><%#  unity.classlib.getPaymode ( Eval ("paymode").ToString ()) %> </td>
                                      <td><%# unity.classlib.get_ord_status  ( Eval ("status").ToString ())%>  </td>
                                    <td><%# Eval ("paid").ToString ()=="Y" ? "Y":"N"%>  </td>
                                                              
                                       </tr>
                            </ItemTemplate>
                            <LayoutTemplate>
                                <table runat="server">
                                    <tr runat="server">
                                        <td runat="server">
                                            <table id="itemPlaceholderContainer" runat="server" class="table table-striped table-bordered bootstrap-datatable datatable">
                                                <thead>
                                                    <tr runat="server">
                                                        <th runat="server"></th>
                                                        <th runat="server">序號</th>
                                                        <th runat="server"><asp:LinkButton ID="sort1" runat="server" CommandArgument="desc" CommandName="ord_code" onclick ="sortdata">訂單編號</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton1" runat="server" CommandArgument="desc" CommandName="ord_date" onclick ="sortdata">訂單日期</asp:LinkButton></th>
                                                        <th runat="server">訂單人</th>
                                                        <th runat="server">商品明細</th>
                                                        <th runat="server">訂單金額</th>
                                                        <th runat="server">付款方式</th>                                                   
                                                        <th runat="server">狀態</th>
                                                        <th runat ="server">已付款</th>
                                                    </tr>
                                                </thead>
                                                <tr id="itemPlaceholder" runat="server">
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server">

                                            <asp:DataPager ID="DataPager1" runat="server" class="pagenavi">
                                                <Fields>
                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                    <asp:NumericPagerField ButtonCount="10" NextPageText="下十頁" PreviousPageText="上十頁" />
                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                </Fields>
                                            </asp:DataPager>
                                        </td>
                                    </tr>
                                </table>
                            </LayoutTemplate>

                        </asp:ListView>
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                        <asp:HiddenField runat="server" ID="Selected_id"></asp:HiddenField>
                    </asp:View>


                    <asp:View ID="View2" runat="server">
                        <input id="Btn_back" type="button" value=" 返  回 " onclick="history.back();" class="btn btn-primary" />
                       <a href="orderprint.aspx?ord_id=<%=ord_id%>"  target ="_blank" ><input id="Btn_print" type="button" value="列印訂單"  class="btn btn-primary" /></a>
                     
                            <table width="100%" border="0" class="table table-striped table-bordered bootstrap-datatable datatable">
                             
                                <tbody>
                                    <tr>
                                        <td>訂單序號:<%=ord_id %></td>
                                        <td>訂單編號:<%=ord_code %></td>
                                        <td>訂購時間:<%=ord_date %></td>                                                                                                                   
                                        <td>訂單狀態:<asp:DropDownList ID="payStatus" DataValueField="id" DataTextField ="name" runat="server"></asp:DropDownList><br />
                                            <asp:RadioButtonList ID="paid" runat="server" >
                                                <asp:ListItem Value ="Y">已付款</asp:ListItem>
                                                <asp:ListItem  Value ="N">未付款</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                   </tr> 
                                    <tr>
                                        <td>付款方式:<asp:DropDownList ID="paymode" runat="server" DataValueField="id" DataTextField ="name"></asp:DropDownList></td>
                                        <td>取貨方式:宅配到府</td>
                                        <td>收件時間:<asp:DropDownList ID="receivetime" runat="server" DataValueField="id" DataTextField ="name"></asp:DropDownList></td>
                                        <td>發票資訊:<asp:DropDownList ID="invoice" runat="server"  DataValueField="id" DataTextField ="name"></asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                備註說明：<asp:TextBox ID="contents" runat="server" TextMode="MultiLine"></asp:TextBox> 
                                            </td>
                                            <td><%= CardAUTHINFO %></td>
                                            <td>ATM未五碼:<asp:TextBox ID="atmCode" runat="server"></asp:TextBox></td>
                                            <td>統一編號:<asp:TextBox ID="companyno" runat="server"></asp:TextBox><br />
                                               發票抬頭:<asp:TextBox ID="title" runat="server"></asp:TextBox>
                                            </td>
                                    </tr>
                                    <tr>
                                    <td>訂購人:<%=ordname  %></td>
                                    <td>電話:<%=ordphone  %></td>
                                    <td colspan  ="2">地址<%=ordaddress  %></td>
                                    </tr> 
                                    <tr>
                                    <td >收件人:<asp:TextBox ID="shipname" runat="server"></asp:TextBox> </td>
                                    <td>收件人電話:<asp:TextBox ID="shipphone" runat="server"></asp:TextBox> </td>
                                    <td colspan="2">收件人地址:<asp:TextBox ID="shipaddress" runat="server" Width ="400"></asp:TextBox></td>
                                    </tr> 
                            
                                    <tr>
                                        <td colspan="4">訂購明細</td>                                         
                                           
                                    </tr>
                                    <tr>
                                      <td>品名</td>
                                        <td>單價</td>
                                        <td>數量</td>
                                        <td>小計</td>
                                    </tr>
                                    <asp:Repeater ID="Repeater1" runat="server">
                                        <ItemTemplate>
                                        <tr>
                                        
                                        <td><%#Eval("productname") %></td>
                                        <td><%#Eval("price") %></td>
                                        <td><%#Eval("num") %></td>
                                        <td><%#Eval("amount") %></td>
                                    </tr>

                                        </ItemTemplate>

                                    </asp:Repeater>
                                <tr> 
                                     <td style ="font-size:16px">
                                         商品小計$<%=SubPrice %><br />
                                         運費:$<%=DeliveryPrice %><br />
                                         折扣:$-<%=discount  %><br>
                                         代碼:<asp:TextBox ID="coupon_no" runat="server"></asp:TextBox><br />
                                        <b>訂單金額:$<%=totalprice%></b> 
                                     </td>
                                    <td></td>                                 
                                    <td></td>
                                    <td></td>
                                </tr>

                                </tbody>
                            </table>
                  
                  
                     


    <table border="0" align="center">
  
                            <tr>
                                <td colspan="2">      <input type="button" value=" 返 回 " onclick="history.back();">
                                    <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔"   OnClick="Btn_save_Click" />
                                    <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" OnClick="Btn_cancel_Click" />
                                </td>

                            </tr>
                        </table>









                    </asp:View>

                </asp:MultiView>

            </div>
 
</asp:Content>
