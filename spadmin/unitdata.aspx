<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="unitdata.aspx.cs" Inherits="spadmin_unitdata" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .tree-view
        {
            font-size: 14px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_title" runat="Server">
    <span>
        <asp:Label ID="Labeltitle" runat="server" Text=""></asp:Label></span>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table cellpadding="20">
        <tr>
            <td valign="top">
                <asp:TreeView ID="TreeView1" runat="server"  OnSelectedNodeChanged ="TreeView1_SelectedNodeChanged">
                </asp:TreeView>
                <br />
            </td>
            <td valign="top">
                <asp:Label ID="Label_Title" runat="server" Text="新增分類" Font-Size="14pt" Font-Bold="True"
                    ForeColor="#003399"></asp:Label>
                <asp:HiddenField ID="Hidden_upper" runat="server" />
                <br />
                <br />
                單元名稱:
                <asp:TextBox ID="unitname" runat="server" Width="190px"></asp:TextBox> <asp:Literal
                    ID="unitid" runat="server"></asp:Literal>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="unitname"
                    ErrorMessage="必填" ValidationGroup="checknew"></asp:RequiredFieldValidator>
                <br />
                上層目錄:
                <asp:DropDownList ID="upperid" runat="server" OnDataBound="upperid_DataBound" >
                </asp:DropDownList>
                <br />
                前端頁面:
                <asp:DropDownList ID="linkpage" runat="server" Width="190px">
                    <asp:ListItem Value=""></asp:ListItem>
                    <asp:ListItem Value="#">#</asp:ListItem>
                    <asp:ListItem Value="about.aspx">單頁</asp:ListItem>
                    <asp:ListItem Value="info.aspx">條列</asp:ListItem>
                    <asp:ListItem Value="info.aspx?detail=n">條列(無內頁)</asp:ListItem>
                    <asp:ListItem Value="photo.aspx">相簿</asp:ListItem>
                    <asp:ListItem Value="photo.aspx?type=p">圖片</asp:ListItem>
                    <asp:ListItem Value="photo.aspx?type=v">影片</asp:ListItem>
                </asp:DropDownList>                        
               <br />
               管理程式:
                <asp:DropDownList ID="adminpage" runat="server" Width="190px">
                    <asp:ListItem Value=""></asp:ListItem>
                    <asp:ListItem Value="#">#</asp:ListItem>
                    <asp:ListItem Value="editContents.aspx">單頁</asp:ListItem>
                    <asp:ListItem Value="editBrick.aspx">條列</asp:ListItem>
                    <asp:ListItem Value="editScenic.aspx">條列(景點)</asp:ListItem>
                    <asp:ListItem Value="editBrick.aspx">相簿</asp:ListItem>
                     <asp:ListItem Value="editBrick.aspx?type=p">圖片</asp:ListItem>
                    <asp:ListItem Value="editBrick2.aspx?type=v">影片</asp:ListItem>
                    <asp:ListItem Value="editMenu.aspx">單元管理</asp:ListItem>
                    <asp:ListItem Value="editCategory.aspx">類別管理</asp:ListItem>
                    <asp:ListItem Value="unitdata.aspx">unitdata</asp:ListItem>
                    <asp:ListItem Value="editImages.aspx?brickid=0">首頁圖示</asp:ListItem>
                    <asp:ListItem Value="editseo.aspx">關鍵字設定</asp:ListItem>                         
                </asp:DropDownList>
                <br />
                排序:
                <asp:TextBox ID="sort" runat="server" Width="31px"></asp:TextBox>
                <br />
                <asp:Panel ID="Panel_add" runat="server">
                    <asp:Button ID="Btn_add" runat="server" Text="新增" Width="70px" ValidationGroup="checknew" />
                    &nbsp;<asp:Button ID="btn_clr" runat="server" Text="清除" Width="70px" />
                    &nbsp;
                </asp:Panel>
                <asp:Panel ID="Panel_update" runat="server" Visible="False">
                    <asp:Button ID="Btn_upd" runat="server" Text="更新" Width="70px" ValidationGroup="checknew" />
                    &nbsp;<asp:Button ID="Btn_del" runat="server" OnClientClick="return confirm('你確定要刪除嗎?')"
                        Text="刪除" Width="70px" />
                 
                    &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="Btn_clr0" runat="server" Text="&gt; 新增分類"
                        Width="97px" />
                </asp:Panel>
                <br />
            </td>
        </tr>
    </table>
</asp:Content>
