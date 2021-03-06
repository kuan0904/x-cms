﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script>
           
          $(document).ready(function () {     
          
            var dataValue = {"kind":"list"};             
            $.post('/hot_list', dataValue, function (result) { $("#hot_list").html(result); });
            dataValue = {"classid":"2"};             
            $.post('/AdBanner', dataValue, function (result) { $("#ad_banner").html(result); });
         
            document.body.classList.add("list");
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="main-content">

    <div class="breadArea">
        <div class="container">
            <ol class="breadcrumb">
                <li><a href="/index">HOME</a></li>
                <%=Breadcrumb  %>
            </ol>
        </div>
    </div>
    <!-- breadArea END -->

    <div class="container">
        <h1 class="site-title"><%=Application["site_name"]%></h1>

        <div class="titlePic">
            <div class="jumbotron">
                <div class="container">
                    <h2><%=pagetitle  %></h2>
                </div>
            </div>
        </div>
        <!-- titlePic END -->

        <div class="row">

            <div class="col-md-8 col-sm-8 main-content">
                <div class="main-content-inner">

                    <div id="Slider" class="swiper-container">
                                <div class="swiper-wrapper">
                             <asp:Repeater ID="Repeaterbanner" runat="server" EnableViewState ="false">
                                    <ItemTemplate>
                                    <div class="swiper-slide item">
                                    <div class="image" style="background-image: url('/webimages/article/<%#Eval("pic") %>');">
                                        <div class="carousel-caption">
                                            <div class="container">
                                                <h3><a href="/Article/<%#Eval("id") %>#<%#Eval("subject") %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                                <p><%#Eval("subject") %></p>
                                            </div>
                                        </div>
                                        <a href="/Article/<%#Eval("id") %>#<%#Eval("subject") %>" class="view-more" title="了解更多">我想了解</a>
                                    </div>
                                </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div> 
                        <div class="swiper-pagination"></div>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                    <!-- Slider END -->

                    <div class="news-wrap news-list">
                    <asp:Repeater ID="hot_list_detail" runat="server" EnableViewState ="false" >
                        <ItemTemplate>
                            <div class="col-xs-12">
                                <div class="thumbnail">
                                    <div class="pic effect col-md-4 col-sm-4 col-xs-12">
                                        <img src="<%#Eval("pic") %>" alt="" title="<%#Eval("subject") %>">
                                        <a class="view-more" href="/Article/<%#Eval("id") %>#<%#Eval("subject") %>" title="了解更多"><span>more</span></a>
                                    </div>
                                    <div class="caption col-md-8 col-sm-8 col-xs-12">
                                        <div class="category">
                                            <%# article.Web.Get_category_link ((int) Eval("id"))%>
                                        </div>
                                        <h3 class="new-index-list-title">
                                            <a href="/Article/<%#Eval("id") %>#<%#Eval("subject") %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a>
                                        </h3>
                                        <p class="description">
                                                <%# unity.classlib.SubString ( Eval("contents").ToString (),100,"notag") %>             </p>
                                        <div class="meta-info">
                                            <div class="new-list-date">
                                                <time datetime="<%#Eval("PostDay") %>"><%# DateTime.Parse ( Eval("PostDay").ToString()).ToString ("yyyy/MM/dd")  %></time>
                                            </div>   <div class=post-views>
                                                        <i class="fa fa-eye"></i><%#Eval("Viewcount") %></div>
                                            <div class="new-list-tags">
                                                <%#article.Web.Get_Keyword_link ( Eval("keywords").ToString ())%>
                                            </div>
                                        </div>
                                        <!-- meta-info END -->

                                    </div>
                                </div>                              
                            </div>
                           
                        <!-- col-md-12 END -->
                        </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <!-- news-list END -->
              
                    <ul class="pagination">
                        
                        <%=PagePaging () %>
                        </ul>


                    <div class="clearfix"></div>

                </div>
                <!-- main-content-inner END -->

            </div>
            <!-- col-md-8 td-main-content END -->

            <div class="col-md-4 col-sm-4 main-sidebar">    
                <div class="block-wrap" id="ad_banner"></div>   
                <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
                <!-- 藝時代全站廣告 -->
                <ins class="adsbygoogle"
                     style="display:block"
                     data-ad-client="ca-pub-1577795616373786"
                     data-ad-slot="3617043165"
                     data-ad-format="auto"
                     data-full-width-responsive="true"></ins>
                <script>
                (adsbygoogle = window.adsbygoogle || []).push({});
                </script>
                <div class="block-wrap">
                            <h2 class="new-index-main-title text-center">訂閱電子報</h2>
                            <div class="epaper-box">
                                <p>精選國內外設計與藝文大事、設計大師最新訪談，每週最新資訊定期遞送給您。</p>
                                <div class="form">
                                    <div class="form-group">
                                        <label class="sr-only" for="exampleInputEmail2">Email</label>
                                        <input type="email" class="form-control" id="exampleInputEmail2" placeholder="yourmail@example.com">
                                    </div>
                                    <button type="submit" class="btn btn-green btn-block">訂閱 <i class="fa fa-angle-right" aria-hidden="true"></i></button>
                                </div>
                            </div>
                        </div>
                <div class="block-wrap"  id="hot_list"></div>
           

                <div class="block-wrap">
                <iframe src="https://www.facebook.com/plugins/page.php?href=<%=Application["fb_url"] %>%2F&tabs=timeline&width=300&height=500&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=1355515061131043" width="300" height="500" scrolling="no" frameborder="0" allowTransparency="true" style="display: block; width: 300px; margin: auto;">
                                    </iframe>      </div>

                <!-- </div> -->
                <!-- main-sidebar-inner END -->
            </div>
            <!-- col-md-4 END -->

        </div>
        <!-- row END -->

    </div>
    <!-- container END -->
</div> 
</asp:Content>

