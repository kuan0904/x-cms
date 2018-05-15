<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="changePwd.aspx.cs" Inherits="spadmin_changePwd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
  
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
            <div class="box-header well" data-original-title>
                <h2>
                    修改個人碼
                </h2>
            </div>
            <div class="box-content">
             
                    <table>
                        <tr>
                            <td>
                                帳號
                            </td>
                            <td>
                                <asp:Label ID="account_pid" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                原密碼
                            </td>
                            <td>
                                <asp:TextBox ID="account_pwd0" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="account_pwd0"
                                    ErrorMessage="請輸入原密碼" SetFocusOnError="True" ValidationGroup="check1"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                新密碼:
                            </td>
                            <td>
                                <asp:TextBox ID="userpwd" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="userpwd"
                                    ErrorMessage="請輸入新密碼" SetFocusOnError="True" ValidationGroup="check1"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                再次輸入新密碼:
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox1" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                                    Display="Dynamic" ErrorMessage="請輸入新密碼" SetFocusOnError="True" ValidationGroup="check1"></asp:RequiredFieldValidator>
                                <br />
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="userpwd"
                                    ControlToValidate="TextBox1" ErrorMessage="新密碼再次輸入不一致" ValidationGroup="check1"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                       
                        <td>
                            <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔" ValidationGroup="check1" OnClick="Btn_save_Click" />
                            <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" OnClick="Btn_cancel_Click" />
                        </td> </tr>
                    </table>
             
            </div>
      
</asp:Content>

