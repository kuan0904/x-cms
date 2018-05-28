<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
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

                                    <div class="col-md-12">
                                        <div class="thumbnail">
                                            <div class="pic effect col-xs-4">
                                                <img src="https://images.unsplash.com/photo-1510231583251-74be0f578e59?ixlib=rb-0.3.5&s=791d99d14f9d4e17ce14aa35d413d9bf&auto=format&fit=crop&w=1350&q=80" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption col-xs-8">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                                <div class=meta-info>
                                                    <a href="list.html" class="post-category">人物/職場</a>
                                                    <div class=post-author>
                                                        <span>By</span>
                                                        <a href="#/author/admin/">ALPHA Camp</a>
                                                        <span> - </span>
                                                    </div>
                                                    <span class=post-date><time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time></span>
                                                    <div class=post-views>
                                                        <i class="fa fa-eye"></i>405</div>
                                                    <div class=post-comments>
                                                        <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                                    </div>
                                                    <div class="post-keywords">
                                                        <i class="fa fa-tags"></i>
                                                        <a href="#">搜尋引擎</a>
                                                        <a href="#">網站維護</a>
                                                        <a href="#">SEO</a>
                                                        <a href="#">CMS</a>
                                                    </div>
                                                </div><!-- meta-info END -->
                                                <p class="description">
                                                    「要選擇哪一種內容管理系統（CMS）？哪套CMS適合我？」這個問題一直是網頁設計師、中小企業主、一般公司所詢問的重要問題。網際網路誕生以來，從靜態HTML開始，至今已經演變為以內容管理系統（CMS）為主流。它被用來當做創建新網站的強大工具。
                                                </p>
                                                <a class="btn-read-more" href="detail.html">繼續閱讀</a>
                                            </div>
                                        </div>
                                    </div><!-- col-md-12 END -->

                                    <div class="col-md-12">
                                        <div class="thumbnail">
                                            <div class="pic effect col-xs-4">
                                                <img src="https://images.unsplash.com/photo-1514513452089-17f8a9771ee8?ixlib=rb-0.3.5&s=753dd7225833c178a810db296dfc54db&auto=format&fit=crop&w=1951&q=80" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption col-xs-8">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                                <div class=meta-info>
                                                    <a href="list.html" class="post-category">人物/職場</a>
                                                    <div class=post-author>
                                                        <span>By</span>
                                                        <a href="#/author/admin/">ALPHA Camp</a>
                                                        <span> - </span>
                                                    </div>
                                                    <span class=post-date><time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time></span>
                                                    <div class=post-views>
                                                        <i class="fa fa-eye"></i>405</div>
                                                    <div class=post-comments>
                                                        <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                                    </div>
                                                    <div class="post-keywords">
                                                        <i class="fa fa-tags"></i>
                                                        <a href="#">搜尋引擎</a>
                                                        <a href="#">網站維護</a>
                                                        <a href="#">SEO</a>
                                                        <a href="#">CMS</a>
                                                    </div>
                                                </div><!-- meta-info END -->
                                                <p class="description">
                                                    「要選擇哪一種內容管理系統（CMS）？哪套CMS適合我？」這個問題一直是網頁設計師、中小企業主、一般公司所詢問的重要問題。網際網路誕生以來，從靜態HTML開始，至今已經演變為以內容管理系統（CMS）為主流。它被用來當做創建新網站的強大工具。
                                                </p>
                                                <a class="btn-read-more" href="detail.html">繼續閱讀</a>
                                            </div>
                                        </div>
                                    </div><!-- col-md-12 END -->

                                    <div class="col-md-12">
                                        <div class="thumbnail">
                                            <div class="pic effect col-xs-4">
                                                <img src="https://images.unsplash.com/photo-1454328911520-ccf83f1ef41d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=c6a0585f1675df29ddc226cba1d7aba7&auto=format&fit=crop&w=1364&q=80" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption col-xs-8">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                                <div class=meta-info>
                                                    <a href="list.html" class="post-category">人物/職場</a>
                                                    <div class=post-author>
                                                        <span>By</span>
                                                        <a href="#/author/admin/">ALPHA Camp</a>
                                                        <span> - </span>
                                                    </div>
                                                    <span class=post-date><time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time></span>
                                                    <div class=post-views>
                                                        <i class="fa fa-eye"></i>405</div>
                                                    <div class=post-comments>
                                                        <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                                    </div>
                                                    <div class="post-keywords">
                                                        <i class="fa fa-tags"></i>
                                                        <a href="#">搜尋引擎</a>
                                                        <a href="#">網站維護</a>
                                                        <a href="#">SEO</a>
                                                        <a href="#">CMS</a>
                                                    </div>
                                                </div><!-- meta-info END -->
                                                <p class="description">
                                                    「要選擇哪一種內容管理系統（CMS）？哪套CMS適合我？」這個問題一直是網頁設計師、中小企業主、一般公司所詢問的重要問題。網際網路誕生以來，從靜態HTML開始，至今已經演變為以內容管理系統（CMS）為主流。它被用來當做創建新網站的強大工具。
                                                </p>
                                                <a class="btn-read-more" href="detail.html">繼續閱讀</a>
                                            </div>
                                        </div>
                                    </div><!-- col-md-12 END -->

                                    <div class="col-md-12">
                                        <div class="thumbnail">
                                            <div class="pic effect col-xs-4">
                                                <img src="https://dummyimage.com/280x210/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption col-xs-8">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                                <div class=meta-info>
                                                    <a href="list.html" class="post-category">人物/職場</a>
                                                    <div class=post-author>
                                                        <span>By</span>
                                                        <a href="#/author/admin/">ALPHA Camp</a>
                                                        <span> - </span>
                                                    </div>
                                                    <span class=post-date><time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time></span>
                                                    <div class=post-views>
                                                        <i class="fa fa-eye"></i>405</div>
                                                    <div class=post-comments>
                                                        <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                                    </div>
                                                    <div class="post-keywords">
                                                        <i class="fa fa-tags"></i>
                                                        <a href="#">搜尋引擎</a>
                                                        <a href="#">網站維護</a>
                                                        <a href="#">SEO</a>
                                                        <a href="#">CMS</a>
                                                    </div>
                                                </div><!-- meta-info END -->
                                                <p class="description">
                                                    「要選擇哪一種內容管理系統（CMS）？哪套CMS適合我？」這個問題一直是網頁設計師、中小企業主、一般公司所詢問的重要問題。網際網路誕生以來，從靜態HTML開始，至今已經演變為以內容管理系統（CMS）為主流。它被用來當做創建新網站的強大工具。
                                                </p>
                                                <a class="btn-read-more" href="detail.html">繼續閱讀</a>
                                            </div>
                                        </div>
                                    </div><!-- col-md-12 END -->

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
                                    
                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://images.unsplash.com/photo-1509291985095-788b32582a81?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=3df807fb97311a00d38399243f18a4ab&auto=format&fit=crop&w=634&q=80" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                            </div>
                                        </div>

                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://images.unsplash.com/photo-1509569785882-4c160654309e?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=50a017034806c9eaf81d0477181f7f4b&auto=format&fit=crop&w=1350&q=80" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                            </div>
                                        </div>

                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://images.unsplash.com/photo-1507587396692-5afe1f777676?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=f4896d6d5ff445224485ff22493e423c&auto=format&fit=crop&w=634&q=80" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                            </div>
                                        </div>

                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://images.unsplash.com/photo-1489809415321-e23671dcbc81?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=fa140a740b16c639cd62930f158469ea&auto=format&fit=crop&w=1350&q=80" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                            </div>
                                        </div>

                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://dummyimage.com/100x70/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                            </div>
                                        </div>

                                    </div><!-- news-list END -->
                                </div>

                            <!--</div> main-sidebar-inner END -->
                        </div><!-- col-md-4 END -->

                    </div><!-- row END -->

                </div><!-- container END -->
</asp:Content>

