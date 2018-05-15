<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="coupon_sn.aspx.cs" Inherits="spadmin_coupon_sn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <script>
        $(document).ready(function(){ 
          $("#<%=strdate.ClientID %>").datepicker();
          $("#<%=strdate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");
          $("#<%=enddate.ClientID %>").datepicker();
          $("#<%=enddate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");

      });
    </script>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>"></asp:SqlDataSource>
         <div class="box-header well" data-original-title>
             <h2> 折價券管理
                    <asp:LinkButton ID="Btn_add" runat="server" class="btn btn-large" OnClick="Btn_add_Click" Text=""><i class="icon-plus"></i>新增資料</asp:LinkButton>
            
                   
                    </h2>   
             </div> 
            <div class="box-content">
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                      <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging">
                            <EmptyDataTemplate>
                                <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                                    <tr>
                                        <td>未傳回資料。</td>
                                    </tr>
                                </table>
                            </EmptyDataTemplate>

                            <ItemTemplate>
                                <tr>
                                  
                                    <td style="text-align: center">
                                <asp:LinkButton ID="LinkButton1"   runat="server" class="btn btn-info" CommandArgument='<%# Eval("id")%>' OnClick="link_edit" Text=""><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                           </td><td><%# Eval("id")%></td>
                                    
                                      <td>
                                        <%# Eval("sn") %>
                                    </td>
                                         <td>
                                        <%# Eval("money") %>
                                    </td>
                                    <td>
                                        <%# Eval("status") %>
                                    </td>
                                         <td>
                                        <%# Eval("strdate") %>
                                    </td>
                                        <td>
                                        <%# Eval("enddate") %>
                                    </td>
                                    <td>
                                        <%# Eval("num") %>
                                    </td>
                                  
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
                                                        <th runat="server">流水號</th> 
                                                        <th runat="server"><asp:LinkButton ID="LinkButton2" runat="server" CommandArgument="desc" CommandName="sn" onclick ="sortdata">折價券編號</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton6" runat="server" CommandArgument="desc" CommandName="money" onclick ="sortdata">折價券金額</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton3" runat="server" CommandArgument="desc" CommandName="status" onclick ="sortdata">生效</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton4" runat="server" CommandArgument="desc">生效日</asp:LinkButton></th>                                                         
                                                        <th runat="server"><asp:LinkButton ID="LinkButton5" runat="server" CommandArgument="desc">失效日</asp:LinkButton></th>     
                                                           <th runat="server"><asp:LinkButton ID="LinkButton7" runat="server" CommandArgument="desc" >數量</asp:LinkButton></th>                    
                                                    </tr>
                                                </thead>
                                                <tr id="itemPlaceholder" runat="server">
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server">
                                            <div class="pagenavi">
                                                <asp:DataPager ID="DataPager1" runat="server">

                                                    <Fields>
                                                        <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                        <asp:NumericPagerField ButtonCount="10" NextPageText="下十頁" PreviousPageText="上十頁" NumericButtonCssClass="accordion" />
                                                        <asp:NextPreviousPagerField ButtonType="Link" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                    </Fields>
                                                </asp:DataPager>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </LayoutTemplate>

                        </asp:ListView>

                        <asp:HiddenField runat="server" ID="Selected_id"></asp:HiddenField>
                    </asp:View>
                    <asp:View ID="View2" runat="server">

                        <table>                            
                            <tr>
                                <td>折價券編號</td>
                                <td>                                     
                                    <asp:TextBox ID="sn" runat="server" Text=""  ></asp:TextBox>

                                </td>
                            </tr>
                             <tr>
                                <td>折價券金額</td>
                                <td>                                     
                                    <asp:TextBox ID="money" runat="server" Text=""  TextMode="Number"></asp:TextBox>

                                </td>
                            </tr>
                            <tr>
                                <td>生效日</td>
                                <td><asp:TextBox ID="strdate" runat="server" Width="100px"></asp:TextBox>                               </td>
                            </tr>
                                <tr>
                                <td>失效日</td>
                                <td><asp:TextBox ID="enddate" runat="server" Width="100px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>訂單最小金額</td>
                                <td>
                                    <asp:TextBox ID="useprice" runat="server"></asp:TextBox>(0表示不限制)</td>
                            </tr>
                               <tr>
                                <td>是否可疊加金額</td>
                                <td>
                                   <asp:RadioButtonList ID="addition" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem value="Y">可</asp:ListItem>
                                        <asp:ListItem  value="N">不可</asp:ListItem>
                                    </asp:RadioButtonList></td>
                            </tr>
                    <tr>
                            <tr>
                                <td>可否重復使用</td>
                                <td>
                                   <asp:RadioButtonList ID="usetimes" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem value="1">可</asp:ListItem>
                                        <asp:ListItem  value="0">不可</asp:ListItem>
                                    </asp:RadioButtonList></td>
                            </tr>
                    <tr>
                                <td>數量</td><td>
                                    <asp:TextBox ID="num" runat="server" TextMode="Number"></asp:TextBox></td>
                            </tr>        
                                  <tr>
                                <td>使用狀態</td>
                                <td>                                     
                                    <asp:RadioButtonList ID="status" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem value="Y">可使用</asp:ListItem>
                                        <asp:ListItem  value="N">不可使用</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        
                            <tr>
                                <td></td>
                                <td>
                                      <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔" OnClientClick="return checkinput();" OnClick="Btn_save_Click" />
                                       <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" OnClick="Btn_cancel_Click" />
                                <input id="Btn_back" type="button" value=" 返  回 " onclick="history.back();" class="btn btn-primary" />
                                </td>

                            </tr>
                        </table>
                    </asp:View>

                   
                </asp:MultiView>

            </div>
     
</asp:Content>




