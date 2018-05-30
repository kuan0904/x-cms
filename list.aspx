<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script>
           
        $(document).ready(function () {     
            var dataValue = {"kind":"list"};             
            $.post('/hot_list', dataValue, function (result) { $("#hot_list").html(result); });
            dataValue = {"classid":"2"};             
            $.post('/AdBanner', dataValue, function (result) { $("#ad_banner").html(result); });
        });
    
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="breadArea">
        <div class="container">
            <ol class="breadcrumb">
                <li><a href="hp.html">HOME</a></li>
                <li class="active">最新消息</li>
            </ol>
        </div>
    </div>
    <!-- breadArea END -->

    <div class="container">
        <h1 class="site-title">藝時代 Cultural Launch</h1>

        <div class="titlePic">
            <div class="jumbotron">
                <div class="container">
                    <h2>最新消息</h2>
                </div>
            </div>
        </div>
        <!-- titlePic END -->

        <div class="row">

            <div class="col-md-8 col-sm-8 main-content">
                <div class="main-content-inner">

                    <div id="Slider" class="swiper-container">
                        <div class="swiper-wrapper">
                                <asp:Repeater ID="Repeater1" runat="server" EnableViewState ="false">
                                    <ItemTemplate>
                                    <div class="swiper-slide item">
                                    <div class="image" style="background-image: url('/webimages/banner/<%#Eval("pic") %>');">
                                        <div class="carousel-caption">
                                            <div class="container">
                                                <h3><a href="<%#Eval("url") %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                                <p><%#Eval("contents") %></p>
                                            </div>
                                        </div>
                                        <a href="<%#Eval("url") %>" class="view-more" title="了解更多">我想了解</a>
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

                        <div class="col-md-12">
                            <div class="thumbnail">
                                <div class="pic effect col-xs-4">
                                    <img src="https://dummyimage.com/280x210/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                    <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                </div>

                                <div class="caption col-md-8 col-sm-8 col-xs-12">
                                    <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                    <div class="meta-info">
                                        <a href="list.html" class="post-category">人物/職場</a>
                                        <div class="post-author">
                                            <span>By</span>
                                            <a href="#/author/admin/">ALPHA Camp</a>
                                            <span>- </span>
                                        </div>
                                        <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time></span>
                                        <div class="post-views">
                                            <i class="fa fa-eye"></i>405
                                        </div>
                                        <div class="post-comments">
                                            <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                        </div>
                                        <div class="post-keywords">
                                            <i class="fa fa-tags"></i>
                                            <a href="#">搜尋引擎</a>
                                            <a href="#">網站維護</a>
                                            <a href="#">SEO</a>
                                            <a href="#">CMS</a>
                                        </div>
                                    </div>
                                    <!-- meta-info END -->
                                    <p class="description">
                                        「要選擇哪一種內容管理系統（CMS）？哪套CMS適合我？」這個問題一直是網頁設計師、中小企業主、一般公司所詢問的重要問題。網際網路誕生以來，從靜態HTML開始，至今已經演變為以內容管理系統（CMS）為主流。它被用來當做創建新網站的強大工具。
                                    </p>
                                    <a class="btn-read-more" href="detail.html">繼續閱讀</a>
                                </div>
                            </div>
                        </div>
                        <!-- col-md-12 END -->

                        <div class="col-md-12">
                            <div class="thumbnail">
                                <div class="pic effect col-md-4 col-sm-4 col-xs-12">
                                    <img src="https://dummyimage.com/280x210/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                    <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                </div>

                                <div class="caption col-md-8 col-sm-8 col-xs-12">
                                    <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                    <div class="meta-info">
                                        <a href="list.html" class="post-category">人物/職場</a>
                                        <div class="post-author">
                                            <span>By</span>
                                            <a href="#/author/admin/">ALPHA Camp</a>
                                            <span>- </span>
                                        </div>
                                        <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time></span>
                                        <div class="post-views">
                                            <i class="fa fa-eye"></i>405
                                        </div>
                                        <div class="post-comments">
                                            <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                        </div>
                                        <div class="post-keywords">
                                            <i class="fa fa-tags"></i>
                                            <a href="#">搜尋引擎</a>
                                            <a href="#">網站維護</a>
                                            <a href="#">SEO</a>
                                            <a href="#">CMS</a>
                                        </div>
                                    </div>
                                    <!-- meta-info END -->
                                    <p class="description">
                                        「要選擇哪一種內容管理系統（CMS）？哪套CMS適合我？」這個問題一直是網頁設計師、中小企業主、一般公司所詢問的重要問題。網際網路誕生以來，從靜態HTML開始，至今已經演變為以內容管理系統（CMS）為主流。它被用來當做創建新網站的強大工具。
                                    </p>
                                    <a class="btn-read-more" href="detail.html">繼續閱讀</a>
                                </div>
                            </div>
                        </div>
                        <!-- col-md-12 END -->

                        <div class="col-md-12">
                            <div class="thumbnail">
                                <div class="pic effect col-md-4 col-sm-4 col-xs-12">
                                    <img src="https://dummyimage.com/280x210/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                    <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                </div>

                                <div class="caption col-md-8 col-sm-8 col-xs-12">
                                    <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                    <div class="meta-info">
                                        <a href="list.html" class="post-category">人物/職場</a>
                                        <div class="post-author">
                                            <span>By</span>
                                            <a href="#/author/admin/">ALPHA Camp</a>
                                            <span>- </span>
                                        </div>
                                        <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time></span>
                                        <div class="post-views">
                                            <i class="fa fa-eye"></i>405
                                        </div>
                                        <div class="post-comments">
                                            <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                        </div>
                                        <div class="post-keywords">
                                            <i class="fa fa-tags"></i>
                                            <a href="#">搜尋引擎</a>
                                            <a href="#">網站維護</a>
                                            <a href="#">SEO</a>
                                            <a href="#">CMS</a>
                                        </div>
                                    </div>
                                    <!-- meta-info END -->
                                    <p class="description">
                                        「要選擇哪一種內容管理系統（CMS）？哪套CMS適合我？」這個問題一直是網頁設計師、中小企業主、一般公司所詢問的重要問題。網際網路誕生以來，從靜態HTML開始，至今已經演變為以內容管理系統（CMS）為主流。它被用來當做創建新網站的強大工具。
                                    </p>
                                    <a class="btn-read-more" href="detail.html">繼續閱讀</a>
                                </div>
                            </div>
                        </div>
                        <!-- col-md-12 END -->

                        <div class="col-md-12">
                            <div class="thumbnail">
                                <div class="pic effect col-md-4 col-sm-4 col-xs-12">
                                    <img src="https://dummyimage.com/280x210/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                    <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                </div>

                                <div class="caption col-md-8 col-sm-8 col-xs-12">
                                    <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                    <div class="meta-info">
                                        <a href="list.html" class="post-category">人物/職場</a>
                                        <div class="post-author">
                                            <span>By</span>
                                            <a href="#/author/admin/">ALPHA Camp</a>
                                            <span>- </span>
                                        </div>
                                        <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time></span>
                                        <div class="post-views">
                                            <i class="fa fa-eye"></i>405
                                        </div>
                                        <div class="post-comments">
                                            <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                        </div>
                                        <div class="post-keywords">
                                            <i class="fa fa-tags"></i>
                                            <a href="#">搜尋引擎</a>
                                            <a href="#">網站維護</a>
                                            <a href="#">SEO</a>
                                            <a href="#">CMS</a>
                                        </div>
                                    </div>
                                    <!-- meta-info END -->
                                    <p class="description">
                                        「要選擇哪一種內容管理系統（CMS）？哪套CMS適合我？」這個問題一直是網頁設計師、中小企業主、一般公司所詢問的重要問題。網際網路誕生以來，從靜態HTML開始，至今已經演變為以內容管理系統（CMS）為主流。它被用來當做創建新網站的強大工具。
                                    </p>
                                    <a class="btn-read-more" href="detail.html">繼續閱讀</a>
                                </div>
                            </div>
                        </div>
                        <!-- col-md-12 END -->

                        <div class="col-md-12">
                            <div class="thumbnail">
                                <div class="pic effect col-md-4 col-sm-4 col-xs-12">
                                    <img src="https://dummyimage.com/280x210/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                    <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                </div>

                                <div class="caption col-md-8 col-sm-8 col-xs-12">
                                    <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                    <div class="meta-info">
                                        <a href="list.html" class="post-category">人物/職場</a>
                                        <div class="post-author">
                                            <span>By</span>
                                            <a href="#/author/admin/">ALPHA Camp</a>
                                            <span>- </span>
                                        </div>
                                        <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time></span>
                                        <div class="post-views">
                                            <i class="fa fa-eye"></i>405
                                        </div>
                                        <div class="post-comments">
                                            <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                        </div>
                                        <div class="post-keywords">
                                            <i class="fa fa-tags"></i>
                                            <a href="#">搜尋引擎</a>
                                            <a href="#">網站維護</a>
                                            <a href="#">SEO</a>
                                            <a href="#">CMS</a>
                                        </div>
                                    </div>
                                    <!-- meta-info END -->
                                    <p class="description">
                                        「要選擇哪一種內容管理系統（CMS）？哪套CMS適合我？」這個問題一直是網頁設計師、中小企業主、一般公司所詢問的重要問題。網際網路誕生以來，從靜態HTML開始，至今已經演變為以內容管理系統（CMS）為主流。它被用來當做創建新網站的強大工具。
                                    </p>
                                    <a class="btn-read-more" href="detail.html">繼續閱讀</a>
                                </div>
                            </div>
                        </div>
                        <!-- col-md-12 END -->

                        <div class="col-md-12">
                            <div class="thumbnail">
                                <div class="pic effect col-md-4 col-sm-4 col-xs-12">
                                    <img src="https://dummyimage.com/280x210/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                    <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                </div>

                                <div class="caption col-md-8 col-sm-8 col-xs-12">
                                    <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                    <div class="meta-info">
                                        <a href="list.html" class="post-category">人物/職場</a>
                                        <div class="post-author">
                                            <span>By</span>
                                            <a href="#/author/admin/">ALPHA Camp</a>
                                            <span>- </span>
                                        </div>
                                        <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time></span>
                                        <div class="post-views">
                                            <i class="fa fa-eye"></i>405
                                        </div>
                                        <div class="post-comments">
                                            <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                        </div>
                                        <div class="post-keywords">
                                            <i class="fa fa-tags"></i>
                                            <a href="#">搜尋引擎</a>
                                            <a href="#">網站維護</a>
                                            <a href="#">SEO</a>
                                            <a href="#">CMS</a>
                                        </div>
                                    </div>
                                    <!-- meta-info END -->
                                    <p class="description">
                                        「要選擇哪一種內容管理系統（CMS）？哪套CMS適合我？」這個問題一直是網頁設計師、中小企業主、一般公司所詢問的重要問題。網際網路誕生以來，從靜態HTML開始，至今已經演變為以內容管理系統（CMS）為主流。它被用來當做創建新網站的強大工具。
                                    </p>
                                    <a class="btn-read-more" href="detail.html">繼續閱讀</a>
                                </div>
                            </div>
                        </div>
                        <!-- col-md-12 END -->

                    </div>
                    <!-- news-list END -->

                    <ul class="pagination">
                        <li class="page-item"><a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">«</span><span class="sr-only">Previous</span></a></li>

                        <li class="page-item active"><a class="page-link" href="#">1</a></li>

                        <li class="page-item"><a class="page-link" href="#">2</a></li>

                        <li class="page-item"><a class="page-link" href="#" aria-label="Next"><span aria-hidden="true">»</span><span class="sr-only">Next</span></a></li>
                    </ul>


                    <div class="clearfix"></div>

                </div>
                <!-- main-content-inner END -->

            </div>
            <!-- col-md-8 td-main-content END -->

            <div class="col-md-4 col-sm-4 main-sidebar">
                <div class="block-wrap"  id="hot_list"></div>
                <div class="block-wrap" id="ad_banner"></div>   


                <div class="block-wrap">
                    <iframe src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2F%E6%99%BA%E5%AA%92%E6%99%82%E4%BB%A3-1880890488818139%2F&tabs=timeline&width=300&height=500&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=1355515061131043" width="300" height="500" scrolling="no" frameborder="0" allowtransparency="true" style="display: block; width: 300px; margin: auto;"></iframe>
                </div>

                <!-- </div> -->
                <!-- main-sidebar-inner END -->
            </div>
            <!-- col-md-4 END -->

        </div>
        <!-- row END -->

    </div>
    <!-- container END -->
</asp:Content>

