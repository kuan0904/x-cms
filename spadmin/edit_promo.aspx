<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="edit_promo.aspx.cs" Inherits="spadmin_edit_promo"  ValidateRequest ="false"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
         
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>" SelectCommand="select *  from promo_system  ">
            
            </asp:SqlDataSource>


            <div class="box-header well" data-original-title>
                <asp:LinkButton ID="Btn_add" runat="server" class="btn btn-large" OnClick="Btn_add_Click" Text=""><i class="icon-plus"></i>新增資料</asp:LinkButton>
          
            </div>
            <div class="box-content">
                <asp:ListView ID="ListView1" runat="server" DataKeyNames="ps_id" DataSourceID="SqlDataSource2" OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging">
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
                                <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-info" CommandArgument='<%# Eval("ps_id")%>' OnClick="link_edit" Text=""><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-danger" CommandArgument='<%# Eval("ps_id").ToString()%>' OnClick="link_delete" OnClientClick="return confirm('你確定要刪除嗎?')" Text=""  ><i class="icon-trash icon-white"></i>刪除</asp:LinkButton>
                            </td>
                            <td><%#Eval("ps_id")%></td>                            
                            <td><%#Eval("ps_name")%></td>
                            <td><%#Eval("ps_condition")%></td>
                            <td style="text-align: center"><%# statusTotxt(Eval("status").ToString())%></td>
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
                                                <th runat="server">代號</th>                                             
                                                <th runat="server">名稱</th>
                                                <th runat="server">條件 </th>
                                                <th runat="server">狀態</th>
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
            </div>



        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:HiddenField ID="Selected_id" runat="server" />
         
                    <div class="box-header well" data-original-title>
                        <h2>分類管理</h2>
                    </div>  

                    <div class="box-content"> <asp:HiddenField ID="classid" runat="server" />
                       
                            <table  class="table table-striped table-bordered bootstrap-datatable datatable">                         
                                 <tr>
                                    <td>
                                        名稱</td>
                                    <td>
                                        <asp:TextBox ID="ps_name" runat="server"></asp:TextBox>
                                    </td>
                                </tr>


                                <tr>
                                    <td>
                                        條件</td>
                                    <td>
                                        <asp:TextBox ID="ps_condition" runat="server" TextMode="Number"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                       說明</td>
                                    <td> <asp:TextBox ID="contents" runat="server" TextMode="MultiLine" Height="700px" Width="750px"></asp:TextBox>
                                        <script>
                                            CKEDITOR.replace('<%=contents.ClientID  %>');
                                        </script>  
                                  
                                    
                                    </td>
                                </tr>
                             
                                <tr>
                                    <td>
                                        狀態</td>
                                    <td>
                                        <asp:DropDownList ID="status" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Y">開啟</asp:ListItem>
                                            <asp:ListItem Value="N">關閉</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan ="2">
                                    <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔" OnClick="Btn_save_Click" />
                                    <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" OnClick="Btn_cancel_Click" />
                                  </td>
                                </tr>
                            </table>
                       
                    </div>
               
        </asp:View>

    </asp:MultiView>


</asp:Content>

