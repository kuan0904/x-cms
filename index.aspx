<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server" EnableViewState ="false" >
    <script>
           
        $(document).ready(function () {     
            var dataValue = {"kind":"list"};             
             
            $.post('/AdBanner', dataValue, function (result) { $("#ad_banner").html(result); });
              dataValue = {"classid":"1"};             
    
        });
    
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" EnableViewState ="false" > 
          <h1 class="site-title"><%=Application["site_name"]%></h1>
                <div class="main-content">
                    <div class="main-content-inner">

                        <div id="Slider" class="swiper-container">
                            <h2 class="main-title"><span>Hot News</span></h2>
                          <div class="swiper-wrapper">
                             <asp:Repeater ID="Repeater1" runat="server" EnableViewState ="false">
                                    <ItemTemplate>
                                    <div class="swiper-slide item">
                                    <div class="image" style="background-image: url('<%#Eval("pic") %>');">
                                        <div class="carousel-caption">
                                            <div class="container">
                                                <h3><a href="<%# Banner.Web.Get_url (Eval("url").ToString (),Eval("categoryid").ToString (),Eval("articleId").ToString ()) %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                                <p><%#Eval("contents") %></p>
                                            </div>
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

                    </div>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-md-8 col-sm-8 main-content">
                            <div class=main-content-inner>

                                <h2 class="main-title">最新文章</h2>
                                <div class="news-wrap news-list">
                                    <asp:Repeater ID="hot_list_detail" runat="server" EnableViewState ="false" >
                                        <ItemTemplate>
                                        <div class="col-md-12">
                                        <div class="thumbnail">
                                            <div class="pic effect col-xs-4">
                                                <img src="<%#Eval("pic") %>" alt="" title="<%#Eval("subject") %>">
                                                <a class="view-more" href="/Article/<%#Eval("id") %>#<%#Eval("subject") %>" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption col-xs-8">
                                                <h3 class="title"><a href="/Article/<%#Eval("id") %>#<%#Eval("subject") %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                                <div class=meta-info>
                                                    <%# article.Web.Get_category_link  ((int) Eval("id"))%>
                                                    <div class=post-author>
                                                        <span>By</span>
                                                      <%# article.Web.Get_author_link ((string) Eval("author"))%>
                                                        <span> - </span>
                                                    </div>
                                                    <span class=post-date><time datetime="<%#Eval("PostDay") %>"><%# DateTime.Parse ( Eval("PostDay").ToString()).ToString ("MM/dd") %></time></span>
                                                    <div class=post-views>
                                                        <i class="fa fa-eye"></i><%#Eval("Viewcount") %></div>
                                                    <div class=post-comments>
                                                        <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                                    </div>
                                                    <div class="post-keywords">
                                                        <i class="fa fa-tags"></i>
                                                      <%#article.Web.Get_Keyword_link ( Eval("keywords").ToString ())%>
                                                       
                                                    </div>
                                                </div><!-- meta-info END -->
                                                 <a  href="/Article/<%#Eval("id") %>"> <p class="description">
                                                   <%# unity.classlib.SubString ( Eval("contents").ToString (),100,"notag") %>
                                                </p></a> 
                                                <a  href="/Article/<%#Eval("id") %>#<%#Eval("subject") %>" class="btn-read-more">繼續閱讀</a>
                                            </div>
                                        </div>
                                    </div><!-- col-md-12 END -->
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div><!-- news-list END -->
                                <div class=clearfix></div>
                            </div><!-- main-content-inner END -->
                        </div>
                        <div class="col-md-4 col-sm-4 main-sidebar">                         
                                 <div class="block-wrap" id="ad_banner1"></div>

                                 <div class="block-wrap">
                                <h2 class="new-index-main-title text-center">熱門文章</h2>
                                <div class="news-wrap news-list">                              
                                        <asp:Repeater ID="news_hotlist" runat="server" EnableViewState ="false" >
                                            <ItemTemplate>
                                             <div class="thumbnail">
                                                <div class="pic effect">
                                                    <img src="<%#Eval("pic") %>" alt="" title="<%#Eval("subject") %>">
                                                    <a class="view-more" href="/Article/<%#Eval("id") %>#<%#Eval("subject") %>" title="了解更多"><span>more</span></a>
                                                </div>

                                                <div class="caption">
                                                    <h3 class="new-index-list-title"><a href="/Article/<%#Eval("id") %>#<%#Eval("subject") %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                                </div>
                                            </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                  
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
                                 </div>

                            <div class="block-wrap" id="ad_banner"></div>   
                                     
                        </div><!-- col-md-4 END -->
                    </div><!-- row END -->
                  </div><!-- container END -->
</asp:Content>

