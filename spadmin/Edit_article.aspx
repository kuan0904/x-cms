<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="Edit_article.aspx.cs" Inherits="spadmin_Edit_article" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_title" runat="Server">
   <script>
      $(function () {
          $("#postday").datepicker();
          $("#postday").datepicker("option", "dateFormat", "yy/mm/dd");

       });
       $(document).ready(function () {
           $(".iframe1").colorbox({
               iframe: true, width: "100%", height: "100%",
               onClosed: function () {
                  Page.Response.Redirect(Page.Request.Url.ToString(), true);

               }
           });
      });
</script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
         <div class="box-header well" data-original-title>   <span class="btn btn-large"><a href="article.aspx" class='iframe' ><i class="icon-plus"></i>新增資料</a></span>
                </div>          
    <div class="row-fluid">
        <div class="box span12">
          <div class="box-content">
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                                                                                           
                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="articleId" >
                        <EmptyDataTemplate>
                            <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                                <tr>
                                    <td>未傳回資料。</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                                <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table id="itemPlaceholderContainer" runat="server" class="table table-striped table-bordered bootstrap-datatable datatable">
                                            <thead>
                                                <tr runat="server">
                                                    <th runat="server"></th>
                                                    <th runat="server">id</th>
                                                    <th runat="server">標題</th>
                                                    <th runat="server">圖示</th>
                                                    <th runat="server">狀態</th>
                                                    <th runat="server">上稿日</th>
                                                       
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
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <a href="article.aspx?articleId=<%# Eval("articleId")%>" class='iframe1' ><button class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</button></a>

                                </td>
                                <td>
                                    <%# Eval("articleid") %>
                                </td>
                                <td>
                                    <%# Eval("subject") %>
                                </td>
                                <td>
                                   <img src="/webimages/article/<%# Eval("pic") %>" width ="300" />
                                </td>
                                <td>
                                    <%# Eval("status").ToString () =="Y" ? "上架":"下架" %>
                                </td>
                            
                                <td>
                                    <%# DateTime .Parse(Eval("postday").ToString()).ToString("yyyy/MM/dd") %>
                                </td>




                            </tr>
                        </ItemTemplate>
                     

                    </asp:ListView>
                    <asp:HiddenField runat="server" ID="Selected_id"></asp:HiddenField>
                    </asp:View>
                
                 
                </asp:MultiView>

            </div>
        </div>
    </div>
</asp:Content>

