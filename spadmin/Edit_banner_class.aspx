<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="Edit_banner_class.aspx.cs" Inherits="spadmin_Edit_banner_class" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:MultiView ID="MultiView1" runat="server">

        <asp:View ID="View1" runat="server">
                    <div class="box-header well" data-original-title>
                        <h2>廣告版位管理</h2>
                        <asp:LinkButton ID="Btn_add" runat="server" Text="" class="btn btn-large" OnClick="Btn_add_Click"><i class="icon-plus"></i>新增資料</asp:LinkButton>

                    </div>
                    <div class="box-content">


                        <asp:ListView ID="ListView1" runat="server" DataKeyNames="classid"  OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging">


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
                                        <asp:LinkButton ID="LinkButton1" runat="server" Text="" OnClick="link_edit" CommandArgument='<%# Eval("classid")%>'
                                            class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" Text="" OnClick="link_delete" OnClientClick="return confirm('你確定要刪除嗎?')"
                                            CommandArgument='<%# Eval("classid").ToString()%>' class="btn btn-danger" Visible="False"><i class="icon-trash icon-white"></i>刪除</asp:LinkButton>

                                    </td>
                                    <td>
                                        <%#Eval("classid")%>
                                    </td>

                                    <td>
                                        <%#Eval("title")%>
                                    </td>
                                    <td>
                                        <%#Eval("ads")%>
                                    </td>
                                    <td>
                                        <%#Eval("fx")%>
                                    </td>
                                    <td>
                                        <%#Eval("speed")%>
                                    </td>
                                    <td>
                                        <%#Eval("rotator")%>
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
                                                        <th  runat="server">代號
                                                        </th>

                                                        <th runat="server">名稱
                                                        </th>
                                                        <th runat="server">輪撥方式
                                                        </th>
                                                        <th runat="server">特效
                                                        </th>
                                                        <th runat="server">輪撥速度(Sec)
                                                        </th>
                                                        <th runat="server">是否輪撥
                                                        </th>


                                                    </tr>
                                                </thead>
                                                <tr id="itemPlaceholder" runat="server">
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server" pagination pagination-centered>
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
                         <h2>廣告版位管理</h2>
                            <table  class="table table-striped table-bordered bootstrap-datatable datatable">
                                <tr>
                                    <td>
                                        名稱</td>
                                    <td>
                                        <asp:TextBox ID="class_title" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        輪撥方式</td>
                                    <td>
                                        <asp:DropDownList ID="class_ads" runat="server">

                                            <asp:ListItem Value="0">0</asp:ListItem>
                                            <asp:ListItem Value="1">1</asp:ListItem>
                                            <asp:ListItem Value="2">2</asp:ListItem>
                                            <asp:ListItem Value="3">3</asp:ListItem>
                                            <asp:ListItem Value="4">4</asp:ListItem>
                                            <asp:ListItem Value="5">5</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    <label class="control-label">
                                        特效</label>
                                     </td> 
                                    <td>
                                        <asp:DropDownList ID="class_fx" runat="server" >
                                            <asp:ListItem Value="none">none</asp:ListItem>
                                            <asp:ListItem Value="fade">fade</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    <label class="control-label">
                                        輪撥速度</label>
                                        </td> 
                                    <td>
                                        <asp:DropDownList ID="class_speed" runat="server">
                                            <asp:ListItem>0</asp:ListItem>
                                            <asp:ListItem>1</asp:ListItem>
                                            <asp:ListItem>2</asp:ListItem>
                                            <asp:ListItem>3</asp:ListItem>
                                            <asp:ListItem>4</asp:ListItem>
                                            <asp:ListItem>5</asp:ListItem>
                                            <asp:ListItem>6</asp:ListItem>
                                            <asp:ListItem>7</asp:ListItem>
                                            <asp:ListItem>8</asp:ListItem>
                                            <asp:ListItem>9</asp:ListItem>
                                            <asp:ListItem>10</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    <label class="control-label">
                                        是否輪撥</label>
                                        </td> 
                                    <td>
                                        <asp:DropDownList ID="class_rotator" runat="server" RepeatDirection="Horizontal">
                                              <asp:ListItem Value="N">N</asp:ListItem>
                                                <asp:ListItem Value="Y">Y</asp:ListItem>
                                          
                                        </asp:DropDownList>
                                    </td>


                                </tr>
                                <tr>
                                    <td>
                                    <label class="control-label">
                                        排序</label>
                                        </td> 
                                    <td>
                                        <asp:TextBox ID="class_priority" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td >
                                    <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔" OnClick="Btn_save_Click" />
                                    <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" OnClick="Btn_cancel_Click" />
                                    <asp:Button ID="btn_del" runat="server" class="btn btn-danger" OnClientClick="return confirm('你確定要刪除嗎?')" OnClick="btn_del_Click"
                                        Text="刪除" Visible="False" />
                                        </td> 
                                </tr>
                            </table>
                        
                    </div>
             
          
</asp:View> 
    </asp:MultiView>


</asp:Content>
