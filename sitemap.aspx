<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="sitemap.aspx.cs" Inherits="sitemap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        section {
  border-bottom: 1px solid #ccc;
  margin-top: 1em;
}

section .col-md-3 {
  border-left: 1px solid #ccc;
}

section .col-md-3:first-child {
  border: none;
}
    </style>
<script>
   $(document).ready(function () {
        $('.nav.nav-pills li').click(function(e) {
        //  e.preventDefault();
          $('.nav.nav-pills li').removeClass('active');
          $(this).addClass('active');
        });
       
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
          <div class="breadArea">
                    <div class="container">
                        <ol class="breadcrumb">
                            <li><a href="/">HOME</a></li>
                            <li class="active">網站導覽</li>
                        </ol>
                    </div>
                </div><!-- breadArea END -->

                <div class="container">
                    <h1 class="site-title"><%=Application["site_name"]%></h1>

                    <div class="titlePic">
                        <div class="jumbotron">
                            <div class="container">
                                <h2>網站導覽</h2>
                            </div>
                        </div>
                    </div><!-- titlePic END -->

                    <ul class="nav nav-pills">
                            <asp:Repeater ID="Repeater1" runat="server" >
                                <ItemTemplate>
                                    <li role="presentation">
                                        <a href="#sec<%#Eval("id") %>"><%#Eval("title") %></a>
                                            
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
     
                        </ul>


                             
                        <asp:Repeater ID="rptmenu" runat="server" OnItemDataBound="rptmenu_ItemDataBound">
                            <ItemTemplate>
                                <section id="sec<%#Eval("id") %>">
                                        <h2><a href="<%# Unitlib.GetLnk (Eval("kind").ToString (),Eval ("Id").ToString ()) %>"><%#Eval("title") %></a></h2>                                             
                                           
                                            <asp:Repeater ID="Repeater2" runat="server">
                                                <HeaderTemplate>   
                                                    <div class="row">
                                                        <div class="col-md-3">
                                                    <ul >
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <li><a href="<%# Unitlib.GetLnk (Eval("kind").ToString (),Eval ("Id").ToString ()) %>"><%#Eval("title") %></a></li>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </ul>
                                                    </div>
                                                    </div>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        
                                      
                                    </section>
                            </ItemTemplate>
                        </asp:Repeater>

                 </div><!-- main-content-inner END -->

   
           
                           
                                
                          

   

</asp:Content>

