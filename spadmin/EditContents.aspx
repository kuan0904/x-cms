<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="EditContents.aspx.cs" Inherits="spadmin_EditContents" %>
<%@ Register Assembly="CKFinder" Namespace="CKFinder" TagPrefix="CKFinder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
                <div class="box span12">
                    <div class="box-header well" data-original-title>   
                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                       
                    </div>
                    <div class="box-content"> 
                          <asp:TextBox ID="contents" runat="server" TextMode="MultiLine" Height="600px" Width="750px"></asp:TextBox>
                       <script>
                            CKEDITOR.replace('<%=contents.ClientID  %>');
                        </script>                   
                       
                 
                     <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔"   OnClick ="Btn_save_Click" />
                          </div>          
                </div>
            </div>
    

    		<p><a class='iframe' href="/hp.html">Outside Webpage (Iframe)</a></p>
	
</asp:Content>


