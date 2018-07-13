<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="myphoto.aspx.cs" Inherits="spadmin_myphoto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
function selectpic(secno,image_alt) {  
    var i = secno.lastIndexOf("/")
    image_alt = secno.substring(i + 1,secno.length )
    opener.document.getElementById('txtUrl').value =   secno ;
    opener.document.getElementById('txtAlt').value =  image_alt ;
  window.close ()
  return false
}
function selectavi(secno,image_alt) {  
    var i = secno.lastIndexOf("/")
   
    opener.document.getElementById('txtUrl').value =   secno ;
    opener.document.getElementById('txtAlt').value = 'hidden'   ;
  window.close ()
  return false
}

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_title" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:Button ID="Btn_upload" runat="server" Text="上傳檔案"  OnClick ="Btn_upload_Click" /><asp:Button ID="Button3"
        runat="server" Text="回相簿列表" OnClick="Button3_Click"  />
    <asp:Button ID="Button6" runat="server" Text="回影片列表" /><br />
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <asp:DataList ID="DataList2" runat="server" RepeatColumns="5" RepeatLayout="Flow">
                <ItemStyle VerticalAlign="Top" />
                <ItemTemplate>
                    <table border="0" cellpadding="5" cellspacing="0">
                        <tr>
                            <td valign="top">
                                相簿名稱:<a href='myphoto.aspx?catalogue=<%# Eval("catalogue") %>'><%#Eval("catalogue")%></a>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
            <asp:DataList ID="DataList1" runat="server" RepeatColumns="5" RepeatDirection="Horizontal">
                <ItemStyle VerticalAlign="Top" />
                <ItemTemplate>
                    <table align="center" border="0" cellpadding="5" cellspacing="0">
                        <tr>
                            <td align="center" valign="top">
                                <img  Width="150" onclick="return selectpic(this.src,'')"
                                    src= '/upload/pic/<%# Eval("filename") %>'  />
                            </td>
                        </tr>
                        <tr>
                        </tr>
                        <td align="center" valign="top">
                            <a href='myphoto.aspx?uploadid=<%# Eval("uploadid") %>'>
                                <%# Eval("filename") %><asp:HiddenField ID="uploadid" runat="server" Value='<%# Eval("uploadid") %>' />
                            </a>
                        </td>
                    </table>
                </ItemTemplate>
            </asp:DataList>
         
        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:Button ID="Button4" runat="server" Text="回相簿列表"  OnClick="Button4_Click"/>
            關鍵字:
            <asp:TextBox ID="catalogue" runat="server"></asp:TextBox>
            <br />
            <input id="file_upload" name="file_upload" type="file" multiple="true">
            <asp:Button ID="Button1" runat="server" Text="上傳" OnClick ="Button1_Click" />
            &nbsp;<asp:Button ID="Button2" runat="server" Text="取消"  />
        </asp:View>
        <asp:View ID="View3" runat="server">
            <asp:ImageButton runat="server" ID="image1"></asp:ImageButton>
        </asp:View>
        <asp:View ID="View4" runat="server">
            <asp:DataList ID="DataList3" runat="server" RepeatColumns="5" RepeatDirection="Horizontal">
                <ItemStyle VerticalAlign="Top" />
                <ItemTemplate>
                    <table align="center" border="0" cellpadding="5" cellspacing="0">
                        <tr>
                            <td align="center" valign="top">
                                <asp:ImageButton ID="cover" runat="server" Width="150" ImageUrl="" /><br />
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="top">
                                <%#Eval("subject").ToString()%><asp:HiddenField ID="uploadid" runat="server" Value='<%# Eval("uploadid") %>' />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
       
        </asp:View>
    </asp:MultiView>
    <div align="center">
        <asp:HyperLink ID="dlnkPrev" runat="server">│ 上一頁│</asp:HyperLink>
        [<asp:Label ID="dpagelink" runat="server"></asp:Label>]
        <asp:HyperLink ID="dlnkNext" runat="server">│下一頁 │</asp:HyperLink>
        <asp:Label ID="dlblCurrentPage" runat="server"></asp:Label>
        <asp:Label ID="dlblTotalPage" runat="server"></asp:Label>
        <asp:Label ID="dtotalcount" runat="server"></asp:Label>
    </div>
  <input type="hidden" id="txtUrl" name="txtUrl" />
    <input type="hidden"  id="txtAlt"  name="txtAlt"/>
</asp:Content>

