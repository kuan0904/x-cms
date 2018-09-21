<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="list-grid.aspx.cs" Inherits="list_grid" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
      $(document).ready(function () {     
          
              document.body.classList.add("list");
        });
    
  
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
            <div class="main-content">

                <div class="breadArea">
                    <div class="container">
                        <ol class="breadcrumb">
                            <li><a href="/">HOME</a></li>
                            <%=Breadcrumb  %>
                        </ol>
                    </div>
                </div><!-- breadArea END -->

                <div class="container">
                    <h1 class="site-title"><%=Application["site_name"]%></h1>

                    <div class="titlePic">
                        <div class="jumbotron">
                            <div class="container">
                                <h2><%=pagetitle  %></h2>
                            </div>
                        </div>
                    </div><!-- titlePic END -->

                    <div class="row">

                        <div class="col-sm-12 main-content">
                            <div class=main-content-inner>

                                <div id="Slider" class="swiper-container">
                                    <div class="swiper-wrapper">
                                    <asp:Repeater ID="Repeater1" runat="server" EnableViewState ="false">
                                    <ItemTemplate>
                                        <div class="swiper-slide item">
                                            <div class="image" style="background-image: url('<%#Eval("pic") %>');">
                                                <div class="carousel-caption center">
                                                    <div class="meta-info">
                                                        <span class="post-date"><time datetime="<%#  Eval("Strdat").ToString()  %>"><%# DateTime.Parse ( Eval("Strdat").ToString()).ToString ("yyyy/MM/dd")  %></time></span>
                                                        <span class="post-reciprocal"><%#Eval("subject") %></span>
                                                    </div><!-- meta-info END -->
                                                    <h3><a href="<%# Banner.Web.Get_url (Eval("url").ToString (),Eval("categoryid").ToString (),Eval("articleId").ToString ()) %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                                </div>
                                                <a href="<%# Banner.Web.Get_url (Eval("url").ToString (),Eval("categoryid").ToString (),Eval("articleId").ToString ()) %>" class="view-more" title="了解更多">我想了解</a>
                                            </div>
                                        </div>
                                          </ItemTemplate>
                                </asp:Repeater>
                        

                                    </div>
                                    <div class="swiper-pagination"></div>
                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>
                                </div><!-- Slider END -->

                                <div class="row news-grid">
                                    <asp:Repeater ID="list_detail" runat="server" EnableViewState ="false" >
                                        <ItemTemplate>
                                    <div class="col-md-4 col-sm-6 col-xs-6">
                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="<%#Eval("pic") %>" alt="" title="<%#Eval("subject") %>">
                                                <a class="view-more" href="/Article/<%#Eval("id") %>" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <div class="meta-info">
                                                    <%# article.Web.Get_category_link ((int) Eval("id"))%>
                                                    <span class="post-date"><time datetime="<%#Eval("PostDay") %>"><%# DateTime.Parse ( Eval("PostDay").ToString()).ToString ("yyyy/MM/dd")  %></time></span>
                                                </div><!-- meta-info END -->

                                                <h3 class="title">
                                                    <a href="/Article/<%#Eval("id") %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                            </div>
                                        </div>
                                    </div><!-- col-md-4 col-sm-6 col-xs-6 END -->
                                        </ItemTemplate>
                                    </asp:Repeater>

                                </div><!-- news-grid END -->

                                <ul class="pagination center">
                                    <%=PagePaging () %>    

                                </ul>


                                <div class=clearfix></div>

                            </div><!-- main-content-inner END -->

                        </div><!-- col-sm-12 -main-content END -->

                    </div><!-- row END -->

                </div><!-- container END -->
            </div><!-- main-content END -->

</asp:Content>

