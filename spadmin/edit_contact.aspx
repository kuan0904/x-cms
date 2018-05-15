<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="Edit_contact.aspx.cs" Inherits="spadmin_edit_contact" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
            <div class="row-fluid">
                <div class="box span12">
           <div class="box-content">     

               <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>" SelectCommand="SELECT     *
FROM         contact
ORDER BY c_id DESC"></asp:SqlDataSource>

               <asp:MultiView ID="MultiView1" runat="server">  <asp:View ID="View1" runat="server">
                   
                     <asp:ListView ID="ListView1" runat="server" DataKeyNames="c_id" DataSourceID="SqlDataSource3">
        
        
                        <EmptyDataTemplate>
                            <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                                <tr>
                                    <td>未傳回資料。</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
        
                        <ItemTemplate>
                            <tr >
                                <td>
                                      <asp:LinkButton ID="EditButton" runat="server" Text="" OnClick="link_edit"   CommandName="Edit" CommandArgument='<%# Eval("c_id")%>'
                                                                    class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                                     
                                </td>
                                <td>
                                    <%# Eval("c_id") %>
                                </td>
                                <td>
                                   <%# Eval("c_name") %>
                                </td>
                               <td>
                                   <%# Eval("c_tel") %>
                                </td>
                                  <td>
                                   <%# Eval("c_email") %>
                                </td>
                                  <td>
                                   <%# Eval("c_cont") %>
                                </td>
                                <td>
                                    <%# DateTime .Parse(Eval("c_datetime").ToString()).ToString("yyyy/MM/dd") %>
                                </td>
            
               
   
      
                            </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server" >
                                <tr runat="server">
                                    <td runat="server">
                                        <table id="itemPlaceholderContainer" runat="server" class="table table-striped table-bordered bootstrap-datatable datatable">
                                              <thead>
                                                <tr runat="server" >
                                                    <th runat="server"></th>
                                                    <th runat="server">id</th>
                                                    <th runat="server">姓名</th>
                                                    <th runat="server">電話</th>
                                                    <th runat="server">email</th>                               
                                                    <th runat="server">問題</th>    
                                                     <th runat="server">留言時間</th>                                                       
                                                </tr>
                                               </thead> 
                                            <tr id="itemPlaceholder" runat="server">
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" >
                                        <div class="pagenavi">
                                        <asp:DataPager ID="DataPager1" runat="server">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                <asp:NumericPagerField ButtonCount="10" NextPageText="下十頁" PreviousPageText="上十頁" />
                                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
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
                            <td>標題</td>
                            <td> <asp:TextBox ID="n_title" runat="server" Text="" ></asp:TextBox></td>

                        </tr>
                                <tr>
                            <td>老師姓名</td>
                            <td> <asp:TextBox ID="n_name" runat="server" Text=""> </asp:TextBox></td>

                        </tr>
                        <tr>
                            <td>內容</td>
                            <td>     </td>

                        </tr>
                                <tr>
                            <td>日期</td>
                            <td> <asp:TextBox ID="n_date" runat="server" Text="" ></asp:TextBox>
                                    
                                    </td>

                        </tr>
                            <tr>
                                <td>狀態</td>
                                <td>
                                        <asp:dropdownlist ID="status" runat="server" RepeatDirection="Horizontal"  CellPadding="5" CellSpacing="5" >
                                        <asp:ListItem Value="Y">開啟</asp:ListItem>
                                        <asp:ListItem Value="N">關閉</asp:ListItem>
                                     

                                    </asp:dropdownlist>

                                </td>
                            </tr>
                        <tr>
                            <td  colspan ="2"> 
                                    <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔"    />
                                <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" />
                            </td>

                        </tr>
                    </table>
                           
                           
                            
                             
                         
                         
                           


                </asp:View>

               </asp:MultiView>

               </div> 
                    </div> 
                </div> 
</asp:Content>



