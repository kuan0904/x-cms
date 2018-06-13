<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="Edit_lesson.aspx.cs" Inherits="spadmin_Edit_lesson" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_title" runat="Server">
    
<script>
      $(function () {
          $("#<%=sdate.ClientID %>").datepicker();
          $("#<%=sdate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");
          $("#<%=edate.ClientID %>").datepicker();
          $("#<%=edate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");
      });
    </script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <div class="box-header well" data-original-title>
                            <asp:LinkButton ID="Btn_add" runat="server" Text="" class="btn btn-large" OnClick ="Btn_add_Click" ><i class="icon-plus"></i>新增資料</asp:LinkButton>                                                                                                 
                       
                    </div>
                         
    <div class="row-fluid">
        <div class="box span12">
          <div class="box-content">
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                                                                                           
                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="lessonId" >
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
                                                    <th runat="server">名稱</th>
                                                    <th runat="server">開始日</th>
                                                    <th runat="server">結束日</th>
                                                    <th runat="server">時間</th>
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
                                  <td  style="text-align: center">
                <asp:LinkButton ID="LinkButton1" runat="server" Text="" OnClick="link_edit" CommandArgument='<%# Eval("lessonId")%>'
                    class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                <asp:LinkButton ID="LinkButton2" runat="server" Text="" OnClick="link_delete" OnClientClick="return confirm('你確定要刪除嗎?')"
                    CommandArgument='<%# Eval("lessonId").ToString()%>' class="btn btn-danger"><i class="icon-trash icon-white"></i>刪除</asp:LinkButton>                                                    
            </td>
                                <td>
                                    <%# Eval("lessonid") %>
                                </td>
                                <td>
                                    <%# Eval("subject") %>
                                </td>
                                 <td>
                                    <%# DateTime .Parse(Eval("startday").ToString()).ToString("yyyy/MM/dd") %>
                                </td>
                                  <td>
                                    <%# DateTime .Parse(Eval("endday").ToString()).ToString("yyyy/MM/dd") %>
                                </td>  <td>
                                    <%# Eval("lessontime") %>
                                </td>
                                <td>
                                    <%# Eval("status").ToString () =="Y" ? "上架":"下架" %>
                                </td>
                            
                            </tr>
                        </ItemTemplate>
                     

                    </asp:ListView>
                    <asp:HiddenField runat="server" ID="Selected_id"></asp:HiddenField>
                    </asp:View>
                
                   <asp:View ID="View2" runat="server">
            <asp:HiddenField ID="HiddenField1" runat="server" />
       
                    <div class="box-header well" data-original-title>
                        <h2>課程管理</h2>
                    </div>
                    <div class="box-content">
                  
                            <table class="table table-striped table-bordered bootstrap-datatable datatable">
                          
                             <tr>
                                    <td>
                                        課程名稱</td>
                                    <td> <asp:TextBox  runat="server" ID="subject"  required Width="500px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        說明</td>
                                    <td> <asp:TextBox  runat="server" ID="contents"  Width="700px" TextMode="MultiLine" Height ="150px"></asp:TextBox>
                                    </td>
                                </tr>    
                          
                                <tr>
                                    <td>
                                        開始時間</td>
                                    <td>
                                        <asp:TextBox ID="sdate" runat="server" size="10"  required></asp:TextBox>                                  
                                       
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        結束時間</td>
                                    <td>
                                          <asp:TextBox ID="edate" runat="server"  size="10" required ></asp:TextBox>                                        
                                      
                                    </td>
                                </tr>
                                <tr>
                                    <td>上課時間說明</td>
                                    <td>
                                          <asp:TextBox ID="lessontime" runat="server"  size="60" required ></asp:TextBox>                                        
                                      
                                    </td>
                                </tr>
                                     <tr>
                                   <td>地址</td>
                                   <td> <asp:TextBox ID="address" runat="server"  size="100" required ></asp:TextBox>   </td>
                               </tr>   
                               <tr>
                                   <td>課程費用(原價)</td>
                                   <td>    <asp:TextBox ID="price" runat="server"  size="10" required TextMode="Number"></asp:TextBox>   </td>
                               </tr>
                                <tr>
                                   <td>課程費用(特價)</td>
                                   <td> <asp:TextBox ID="sellprice" runat="server"  size="10" required TextMode="Number"></asp:TextBox>   </td>
                               </tr>   
                                <tr>
                                    <td>講師管理</td>
                                    <td>
                                        <asp:CheckBoxList ID="tags" runat="server" DataTextField="tagname" DataValueField ="tagid" RepeatDirection="Horizontal" RepeatColumns="8"></asp:CheckBoxList></td>
                                </tr>
                               
                                 <tr>
                                    <td>
                                        狀態</td>
                                    <td>
                                        <asp:dropdownlist ID="t_status" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Y">Y</asp:ListItem>
                                            <asp:ListItem Value="N">N</asp:ListItem>
                                        </asp:dropdownlist>
                                    </td>
                                      </tr> 
                                   <tr>
                                  <td></td>
                                       <td>
                                    <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔"   OnClick ="Btn_save_Click" />
                                    <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" OnClick ="Btn_cancel_Click" />
                                    <asp:Button ID="btn_del" runat="server" class="btn btn-danger" OnClientClick="return confirm('你確定要刪除嗎?')" OnClick ="btn_del_Click" 

                                        Text="刪除"  /></td>
                                </tr>
                            </table>
                        </div>
                   
              
                    </asp:View>
                </asp:MultiView>

            </div>
        </div>
    </div>
</asp:Content>

