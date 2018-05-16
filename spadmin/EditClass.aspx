<%@ Page Title="" Language="C#" MasterPageFile="admin.master" AutoEventWireup="true" CodeFile="EditClass.aspx.cs" Inherits="admin_EditClass" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
            <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
        <script >
     $(document).ready(function() {
            var url = "searchpd.ashx";
          //  $(".autofill").autocomplete({ source: url });
            $('.autofill').each(function(i) {              
                var ac_new_invoice = (function (i) {
                    return {
                        source: "searchpd.ashx",
                        minLength: 1,
                        select: function (event, ui) {
                            i = i + 1;
                            var str = '#ctl00$ContentPlaceHolder1$top' + i;
                            $(str).val(ui.item.id);
                            str = '#ContentPlaceHolder1_txt_fill' + i;
                            $(str).html(ui.item.title);
                           //多個

                        }
                    };
                })(i);
                $(this).autocomplete(ac_new_invoice);

            });
         //一個用
            var ac_config = {
                source: url,
                select: function(event, ui) {
                    //event.preventDefault(); 
                   
                    $("#txt_fill_sort").val(ui.item.value);
                    $("#txt_fill").html(ui.item.title);
                    $("#fill_id").val(ui.item.id);
                    //$("#zip").val(ui.item.zip);
                },
                minLength: 1
            };


            $("#txt_fill_sort").autocomplete(ac_config);


        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:MultiView ID="MultiView1" runat="server">

        <asp:View ID="View1" runat="server">

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>" SelectCommand="SELECT  * FROM tbl_category WHERE classId =@id AND parentid = 0 order by priority">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="id" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>" SelectCommand="select * ,  (SELECT  title   FROM tbl_category  WHERE (b.parentid = categoryid)) AS upname  from tbl_category as b  where  classid = @d1  order by priority ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="d1" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>


            <div class="box-header well" data-original-title>

                <asp:LinkButton ID="Btn_add" runat="server" class="btn btn-large" OnClick="Btn_add_Click" Text=""><i class="icon-plus"></i>新增資料</asp:LinkButton>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:HiddenField ID="parentid" runat="server" />
            </div>
            <div class="box-content">
                <asp:ListView ID="ListView1" runat="server" DataKeyNames="categoryid" DataSourceID="SqlDataSource2" OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging">
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
                                <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-info" CommandArgument='<%# Eval("categoryid")%>' OnClick="link_edit" Text=""><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-danger" CommandArgument='<%# Eval("categoryid").ToString()%>' OnClick="link_delete" OnClientClick="return confirm('你確定要刪除嗎?')" Text="" Visible="False"><i class="icon-trash icon-white"></i>刪除</asp:LinkButton>
                            </td>
                            <td><%#Eval("categoryid")%></td>
                            <td><%#Eval("upname")%></td>
                            <td><%#Eval("title")%></td>
                            <td><%#Eval("priority")%></td>
                            <td style="text-align: center"><%# statusTotxt(Eval("status").ToString())%></td>
                              <td style="text-align: center"><asp:Button ID="Button1" runat="server" Text="刪除"
                                   OnClick ="Button1_Click"    CommandName="delete" CommandArgument='<%# Eval("categoryid")%>'  
                                   OnClientClick="return  confirm('你確定嗎?')"  Visible= <%# Eval("status").ToString()=="0" ? true:false  %> /></td>
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
                                                <th runat="server">上層名稱</th>
                                                <th runat="server">名稱</th>
                                                <th runat="server">排序 </th>
                                                <th runat="server">狀態</th>
                                                  <th runat="server">刪除</th>
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
                        <h2>網站版位設定</h2>
                    </div>  

                    <div class="box-content"> <asp:HiddenField ID="classid" runat="server" />
                       
                            <table  class="table table-striped table-bordered bootstrap-datatable datatable">
                             
                                <tr>
                                    <td>
                                        上層選單
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="title" DataValueField="categoryid">
                                        </asp:DropDownList>

                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        名稱</td>
                                    <td>
                                        <asp:TextBox ID="class_name" runat="server"></asp:TextBox>
                                    </td>
                                </tr>


                                <tr>
                                    <td>
                                        優先順序</td>
                                    <td>
                                        <asp:TextBox ID="priority" runat="server" TextMode="Number"></asp:TextBox>
                                    </td>
                                </tr>

                           
                        
                                <tr>
                                    <td>
                                        狀態</td>
                                    <td>
                                        <asp:DropDownList ID="status" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="1">開啟</asp:ListItem>
                                            <asp:ListItem Value="0">關閉</asp:ListItem>
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
