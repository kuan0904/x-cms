<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="Edit_diary.aspx.cs" Inherits="spadmin_Edit_diary" validateRequest="False" %>
<%@ Register Assembly="CKFinder" Namespace="CKFinder" TagPrefix="CKFinder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>"></asp:SqlDataSource>
         <div class="box-header well" data-original-title>
             <h2>日誌管理</h2>
                <asp:LinkButton ID="Btn_add" runat="server" Text="" class="btn btn-large" OnClick="Btn_add_Click"><i class="icon-plus"></i>新增資料</asp:LinkButton>
                        <asp:TextBox ID="keyword" runat="server" Width="300px"></asp:TextBox>
                        <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click1" class="btn btn-success" />
                       
             </div> 
            <div class="box-content">

                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                      <asp:ListView ID="ListView1" runat="server" DataKeyNames="d_id" DataSourceID="SqlDataSource1" OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging">


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
                                        <asp:LinkButton ID="EditButton" runat="server" Text="" OnClick="link_edit" CommandName="Edit" CommandArgument='<%# Eval("d_id")%>'
                                            class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                                           <asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-danger" CommandArgument='<%# Eval("d_id").ToString()%>' OnClick="link_delete" OnClientClick="return confirm('你確定要刪除嗎?')" Text=""  ><i class="icon-trash icon-white"></i>刪除</asp:LinkButton>
                                  
                                    </td>
                                    <td>
                                        <%# Eval("d_id") %>
                                    </td>
                                    <td>
                                        <%# Eval("subject") %>
                                    </td>
                                        <td>
                                     <img src="../upload/<%# Eval("pic") %>" width="100"/>
                                    </td>
                                    <td>
                                        <%# DateTime .Parse(Eval("post_day").ToString()).ToString("yyyy/MM/dd") %>
                                    </td>
                                    <td>
                                        <%# Eval("hot") %>
                                    </td>
                                     <td style="text-align: center">   <%# (Eval("status").ToString()  == "Y") ? "上架" : "下架"  %></td>
                                     <td><%#Eval("viewcount") %></td>

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
                                                        <th runat="server">活動標題</th>
                                                        <th runat="server">圖示</th>
                                                        <th runat="server">活動日期</th>
                                                        <th runat="server">置頂</th>
                                                        <th runat="server">狀態</th>
                                                          <th runat ="server" >瀏覽數</th>
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
                                <td>標題</td>
                                <td>
                                    <asp:TextBox ID="subject" runat="server" Text="" size="60"></asp:TextBox></td>

                            </tr>
                            <tr>
                                <td>圖片</td>
                                <td>
                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                    <asp:Image ID="Image1" runat="server" /><asp:HiddenField ID="HiddenField1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>內容</td>
                                <td>
                                       <asp:TextBox ID="contents" runat="server" TextMode="MultiLine" Height="700px" Width="750px"></asp:TextBox>
                                        <script>
                                            CKEDITOR.replace('<%=contents.ClientID  %>');
                                        </script>  
                                  
                                </td>

                            </tr>
                            <tr>
                                <td>日期</td>
                                <td>
                                    <script>
                                        $(function () {
                                            $("#<%=post_date.ClientID %>").datepicker();
                                          $("#<%=post_date.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");

                                      });
                                    </script>
                                    <asp:TextBox ID="post_date" runat="server" Text="" size="7"></asp:TextBox>

                                </td>

                            </tr>
                            <tr>
                                <td>置頂</td>
                                <td>

                                    <asp:DropDownList ID="hot" runat="server">
                                        <asp:ListItem Value ="">無</asp:ListItem>
                                           <asp:ListItem Value ="0">內頁置頂</asp:ListItem>
                                            <asp:ListItem Value ="1">置頂1</asp:ListItem>
                                            <asp:ListItem Value ="2">置頂2</asp:ListItem>
                                            <asp:ListItem Value ="3">置頂3</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>狀態</td>
                                <td>
                                    <asp:DropDownList ID="status" runat="server" CellPadding="5" CellSpacing="5">
                                        <asp:ListItem Value="Y">開啟</asp:ListItem>
                                        <asp:ListItem Value="N">關閉</asp:ListItem>
                                         <asp:ListItem Value="D">刪除</asp:ListItem>

                                    </asp:DropDownList>

                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔" OnClientClick="return checkinput();" OnClick="Btn_save_Click" />
                                    <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" OnClick="Btn_cancel_Click" />
                                </td>

                            </tr>
                        </table>

                        <script>
                            function checkinput() {

                                var obj = "ContentPlaceHolder1_";
                                if ($("#<% =subject.ClientID %>").val() == '') {
                                            alert('標題未輸入');
                                            return false;
                                        }
                                        if ($("#<% =post_date.ClientID %>").val() == '') {
                                              alert('日期未輸入');
                                              return false;
                                          }

                                      }

                        </script>







                    </asp:View>

                </asp:MultiView>

            </div>
     
</asp:Content>


