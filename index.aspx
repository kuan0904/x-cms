<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server" EnableViewState ="false" >
    <script>
           var maindata; 
        var flag;
        $(document).ready(function () {           
           
            //var dataValue = {"kind":"list","id":1,"tbl":"banner"};             
            //$.post('/lib/Get_data.ashx', dataValue,  function (result) {
            //    var tx = '<div class="swiper-slide item">';
            //    tx += '<div class="image" style="background-image: url(@pic@);">';
            //    tx += '<div class="carousel-caption">'
            //    tx += ' <div class="container">';
            //    tx += '<h3><a href="detail.html" title="@title@">@title@</a></h3>';
            //    tx += '<p>@contents@</p>';
            //    tx += ' </div>';
            //    tx += ' </div>';
            //    tx += ' <a href="detail?id=@id@" class="view-more" title="了解更多">我想了解</a>';
            //    tx += ' </div>';
            //    tx += ' </div>';
                
            //            if (result != '') {
            //                result = JSON.parse(result);
            //                var html = "";
            //                $.each(result, function (key, val) {
            //                    html += tx;
            //                    html = html.replace(/@title@/, val.Subject)
            //                    html = html.replace(/@Id@/, val.Id)
            //                    html = html.replace(/@contents@/, val.Contents)
            //                    html = html.replace(/@pic@/, "/webimages/banner/" + val.Pic)
            //                    html = html.replace(/@Url@/, val.Url)
                              
            //                });   
                        
            //           //     $( ".swiper-wrapper" ).append( html );
            //            }

                  
            //    });

         

     
   
        });
    
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" EnableViewState ="false" > 
          <h1 class="site-title">藝時代 Cultural Launch</h1>

                <div class="main-content">
                    <div class="main-content-inner">

                        <div id="Slider" class="swiper-container">
                            <h2 class="main-title"><span>Hot News</span></h2>
                            <div class="swiper-wrapper">
                                <asp:Repeater ID="Repeater1" runat="server" EnableViewState ="false">
                                    <ItemTemplate>
                                    <div class="swiper-slide item">
                                    <div class="image" style="background-image: url('/webimages/banner/<%#Eval("pic") %>');">
                                        <div class="carousel-caption">
                                            <div class="container">
                                                <h3><a href="detail.html" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                                <p><%#Eval("contents") %></p>
                                            </div>
                                        </div>
                                        <a href="detail.html" class="view-more" title="了解更多">我想了解</a>
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

                                <h2 class="main-title">熱門文章</h2>

                                <div class="news-wrap news-list">
                                    <asp:Repeater ID="hot_list_detail" runat="server" EnableViewState ="false" >
                                        <ItemTemplate>
                                        <div class="col-md-12">
                                        <div class="thumbnail">
                                            <div class="pic effect col-xs-4">
                                                <img src="/webimages/article/<%#Eval("pic") %>" alt="" title="<%#Eval("subject") %>">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption col-xs-8">
                                                <h3 class="title"><a href="detail.html" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                                <div class=meta-info>
                                                    <a href="list.html" class="post-category"> <%# article.Web. Get_tag_link ((string[]) Eval("Tags"))%></a>
                                                    <div class=post-author>
                                                        <span>By</span>
                                                        <a href="#/author/admin/"> <%# article.Web. Get_writer_link((string[]) Eval("Writer"))%></a>
                                                        <span> - </span>
                                                    </div>
                                                    <span class=post-date><time datetime="<%#Eval("PostDay") %>"><%# DateTime.Parse ( Eval("PostDay").ToString()).ToString ("yyyy/MM/dd")  %></time></span>
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
                                                <p class="description">
                                                    <%# unity.classlib.SubString ( Eval("contents").ToString (),100,"notag") %><
                                                </p>
                                                <a class="btn-read-more" href="detail.html">繼續閱讀</a>
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
                            <!-- <div class=main-sidebar-inner> -->
                                <div class="block-wrap">
                                <!-- <div class=block-title>AD</div> -->
                                    <ul class="banner-group">
                                        <li class="col-md-12 col-sm-4 col-xs-4 thumbnail">
                                            <a href="#" title="img-banner-300x200" target="_blank">
                                                <img src="images/img-banner-300x200.jpg" alt="" title="">
                                            </a>
                                        </li>
                                        <li class="col-md-12 col-sm-4 col-xs-4 thumbnail">
                                            <a href="#" title="img-banner-300x200" target="_blank">
                                                <img src="images/img-banner-300x200.jpg" alt="" title="">
                                            </a>
                                        </li>
                                    </ul>
                                </div><!-- block-wrap END -->

                                <div class="block-wrap">
                                    <div class=block-title>熱門排行榜</div>

                                    <div class="news-wrap news-list">
                                        <asp:Repeater ID="news_hotlist" runat="server" EnableViewState ="false" >
                                            <ItemTemplate>
                                            <div class="thumbnail">
                                                <div class="pic effect">
                                                    <img src="/webimages/article/<%#Eval("pic") %>" alt="" title="<%#Eval("subject") %>">
                                                    <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                                </div>

                                                <div class="caption">
                                                    <h3 class="title"><a href="detail.html" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                                </div>
                                            </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        


                                        

                                    </div><!-- news-list END -->
                                </div>

                            <!--</div> main-sidebar-inner END -->
                        </div><!-- col-md-4 END -->

                    </div><!-- row END -->

                </div><!-- container END -->
</asp:Content>

