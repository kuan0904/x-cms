<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="authority.aspx.cs" Inherits="spadmin_authority" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">

        $(document).ready(function() {

            $("#checkall").click(function () {
               
                if ($(this).is(":checked")) {                   
                    $("#power_div").find("input:checkbox").prop("checked", true);
                    $("#power_div").find("span").prop("class", "checked");
                }
                else {
                    $("#power_div").find("input:checkbox").prop("checked", false);
                    $("#power_div").find("span").prop("class", "");
                }
               
            });

            $(".check_head").find("input:checkbox").click(function() {
                if ($(this).is(":checked")) {
                    $(this).parents("#power_s").find("input:checkbox").prop("checked", true);
                    $(this).parents("#power_s").find("span").prop("class", "checked");
                }
                else {
                    $(this).parents("#power_s").find("input:checkbox").prop("checked", false);
                    $(this).parents("#power_s").find("span").prop("class", "");
                }

            });
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server" >
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
          
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>">
            </asp:SqlDataSource>
         
                    <div class="box-header well" data-original-title>
                        <h2>  
                            權限管理<asp:LinkButton ID="Btn_add" runat="server" Text="" class="btn btn-large" OnClick ="Btn_add_Click"><i class="icon-plus"></i>新增管理員</asp:LinkButton></h2>
                    </div>
                    <div class="box-content">
                        <table class="table table-striped table-bordered bootstrap-datatable datatable">
                            <thead>
                                <tr>
                                    <th width="20%">
                                    </th>
                                  
                                    <th width="15%">
                                        姓名
                                    </th>
                                    <th width="15%">上次登入時間</th>
                                    <th  width="15%">上次登入IP</th>
                                    <th>
                                        備註
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" >
                                    <ItemTemplate>
                                        <tr>
                                            <td width="20%" style="text-align: center">
                                                <asp:LinkButton ID="LinkButton1" runat="server" Text="" OnClick="link_edit" CommandArgument='<%# Eval("user_id")%>'
                                                    class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                                            </td>
                                          
                                            <td>
                                                <%#Eval("name")%>
                                            </td>
                                                 <td><%#Eval("last_login_time") %></td>
                                                <td><%#Eval("last_login_time")%></td>
                                            <td>
                                                <%#Eval("memo")%>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
             
        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:HiddenField ID="Selected_id" runat="server" />
  
                    <div class="box-header well" data-original-title>
                        <h2>
                        </h2>
                    </div>
                    <div class="box-content">
                    
                            <table>
                                <tr>
                                    <td>
                                        管理員名稱

                                    </td>
                                    <td>
                                        <asp:TextBox ID="user_name" runat="server" required></asp:TextBox>
                                    </td>
                                </tr>
                            
                                <tr>
                                    <td>
                                        帳號
                                            </td>
                                    <td>
                                        <asp:TextBox ID="account_pid" runat="server" required> </asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        密碼
                                                  </td>
                                    <td>
                                        <asp:TextBox ID="account_pwd" runat="server" required TextMode="Password"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        備註
                                    </td>
                                    <td>
                                        <asp:TextBox ID="memo" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        後台使用權限
                                    </td>
                                    <td id="power_div">
                                        <label class="checkbox inline">
                                            <input type="checkbox" name="checkbox" value="checkbox" id="checkall">全選
                                        </label> <table>
                                            <asp:Repeater ID="Repeater_power1" runat="server" DataSourceID="SqlDataSource_power1" OnItemDataBound ="Repeater_power1_ItemDataBound" >
                                           
                                            <ItemTemplate>
                                                     <%# Container.ItemIndex % 5 == 0 ? "<tr>":""%>
                                                <td  valign="top">
                                                <div class="span3" id="power_s">
                                                    <table class="table table-bordered  table-striped ">
                                                        <tr>
                                                            <td class="check_head"  style="background-color: #E0E0E0">
                                                                <label class="checkbox inline" style="font-weight: bold;">
                                                                    <asp:CheckBox ID="chk" runat="server" />
                                                                    <%# Eval("unitname") %>
                                                                    <asp:HiddenField ID="Hidden_id" runat="server" Value='<%# Eval("unitid") %>' />
                                                                </label>
                                                            </td>
                                                        </tr>
                                                        <asp:Repeater ID="Repeater_power2" runat="server" DataSourceID="SqlDataSource_power2" >
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <label class="checkbox inline">
                                                                            <asp:CheckBox ID="chk" runat="server" />
                                                                            <%# Eval("unitname") %>
                                                                            <asp:HiddenField ID="Hidden_id" runat="server" Value='<%# Eval("unitid") %>' />
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                        <asp:SqlDataSource ID="SqlDataSource_power2" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>">
                                                        </asp:SqlDataSource>
                                                    </table>
                                                </div>
                                                    </td> 
                                                  <%# Container.ItemIndex % 5 == 4? "</tr>":""%>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        </table>
                                        <asp:SqlDataSource ID="SqlDataSource_power1" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>">
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                               
                                 
                            </table>
    <div class="clearfix form-actions">
                    <div class="col-md-offset-3 col-md-9">
                        <asp:Button ID="Btn_save" runat="server" class="btn btn-info" Text="存 檔" ValidationGroup="check1"  OnClick ="Btn_save_Click"/>
                                    <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" OnClick ="Btn_cancel_Click" />
                                    <asp:Button ID="btn_del" runat="server" class="btn btn-danger" OnClientClick="return confirm('你確定要刪除嗎?')" OnClick =" btn_del_Click"
                                        Text="刪除" ValidationGroup="check1" /></div> 


                              
                   
                    </div>
                </div>

                <div class="hr hr-24"></div> 
              
        </asp:View>
    </asp:MultiView>
    <asp:HiddenField ID="HiddenField1" runat="server" />
</asp:Content>
