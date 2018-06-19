<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="list-search.aspx.cs" Inherits="list_search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script>
           
        $(document).ready(function () {     
            var dataValue = {"kind":"list"};             
            $.post('/hot_list', dataValue, function (result) { $("#hot_list").html(result); });
            dataValue = {"classid":"2"};             
            $.post('/AdBanner', dataValue, function (result) { $("#ad_banner").html(result); });
              dataValue = {"classid":"1"};             
           
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
                </div><!-- breadArea END -->

                <div class="container">
                    <h1 class="site-title">藝時代 Cultural Launch</h1>

                    <div class="titlePic">
                        <div class="jumbotron">
                            <div class="container">
                                <h2>最新消息</h2>
                            </div>
                        </div>
                    </div><!-- titlePic END -->

                    <div class="row">

                        <div class="col-md-8 col-sm-8 main-content">
                            <div class=main-content-inner>

                                <div class="page-header">
                                    <h2 class="search-title">
                                        <span class="search-query">新創團隊</span> - <span> 搜尋結果</span>
                                    </h2>

                                    <div class="search-wrap">
                                        <div class="form-group">
                                            <input class="form-control" type="text" value="新創團隊" name="s" id="s">
                                            <input class="btn btn-search" type="submit" id="" value="Search">
                                        </div>
                                        <p>若沒有找到您需要的文章或資訊，麻煩您再下一次關鍵字重新搜尋</p>
                                    </div><!-- search-wrap END -->

                                </div><!-- page-header END -->

                                <div class="row news-grid">


                                    <div class="col-xs-6">
                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://dummyimage.com/500x300/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <div class="meta-info">
                                                    <a href="list.html" class="post-category">產業經營</a>

                                                    <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/07/26</time></span>
                                                </div><!-- meta-info END -->

                                                <h3 class="title">
                                                    <a href="detail.html" title="新創團隊想成為搶手數位行銷人？學習寫程式讓你技能大加分！">新創團隊想成為搶手數位行銷人？學習寫程式讓你技能大加分！</a></h3>
                                            </div>
                                        </div>
                                    </div><!-- col-xs-6 END -->



                                    <div class="col-xs-6">
                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://dummyimage.com/500x300/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <div class="meta-info">
                                                    <a href="list.html" class="post-category">產業經營</a>

                                                    <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/07/26</time></span>
                                                </div><!-- meta-info END -->

                                                <h3 class="title">
                                                    <a href="detail.html" title="新創團隊想成為搶手數位行銷人？學習寫程式讓你技能大加分！">新創團隊想成為搶手數位行銷人？學習寫程式讓你技能大加分！</a></h3>
                                            </div>
                                        </div>
                                    </div><!-- col-xs-6 END -->


                                    <div class="col-xs-6">
                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://dummyimage.com/500x300/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <div class="meta-info">
                                                    <a href="list.html" class="post-category">產業經營</a>

                                                    <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/07/26</time></span>
                                                </div><!-- meta-info END -->

                                                <h3 class="title">
                                                    <a href="detail.html" title="新創團隊想成為搶手數位行銷人？學習寫程式讓你技能大加分！">新創團隊想成為搶手數位行銷人？學習寫程式讓你技能大加分！</a></h3>
                                            </div>
                                        </div>
                                    </div><!-- col-xs-6 END -->


                                    <div class="col-xs-6">
                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://dummyimage.com/500x300/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <div class="meta-info">
                                                    <a href="list.html" class="post-category">產業經營</a>

                                                    <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/07/26</time></span>
                                                </div><!-- meta-info END -->

                                                <h3 class="title">
                                                    <a href="detail.html" title="新創團隊想成為搶手數位行銷人？學習寫程式讓你技能大加分！">新創團隊想成為搶手數位行銷人？學習寫程式讓你技能大加分！</a></h3>
                                            </div>
                                        </div>
                                    </div><!-- col-xs-6 END -->

                                    <div class="col-xs-6">
                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://dummyimage.com/500x300/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <div class="meta-info">
                                                    <a href="list.html" class="post-category">產業經營</a>

                                                    <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/07/26</time></span>
                                                </div><!-- meta-info END -->

                                                <h3 class="title">
                                                    <a href="detail.html" title="新創團隊想成為搶手數位行銷人？學習寫程式讓你技能大加分！">新創團隊想成為搶手數位行銷人？學習寫程式讓你技能大加分！</a></h3>
                                            </div>
                                        </div>
                                    </div><!-- col-xs-6 END -->

                                </div><!-- news-grid END -->


                                <ul class="pagination">
                                    <li class="page-item"><a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">«</span><span class="sr-only">Previous</span></a></li>

                                    <li class="page-item active"><a class="page-link" href="#">1</a></li>

                                    <li class="page-item"><a class="page-link" href="#">2</a></li>

                                    <li class="page-item"><a class="page-link" href="#" aria-label="Next"><span aria-hidden="true">»</span><span class="sr-only">Next</span></a></li>
                                </ul>


                                <div class=clearfix></div>

                            </div><!-- main-content-inner END -->

                        </div><!-- col-md-8 td-main-content END -->

                        <div class="col-md-4 col-sm-4 main-sidebar">
                             <div class="block-wrap">
                                  
                                    <div class="news-wrap news-list">
                                    <div class="block-wrap"  id="hot_list"></div>

                                    </div>
                                </div>

                                <div class="block-wrap">
                                      <div class="block-wrap" id="ad_banner"></div>   
                                </div>

                                <div class="block-wrap">
                                    <iframe src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2F%E6%99%BA%E5%AA%92%E6%99%82%E4%BB%A3-1880890488818139%2F&tabs=timeline&width=300&height=500&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=1355515061131043" width="300" height="500" scrolling="no" frameborder="0" allowTransparency="true" style="display: block; width: 300px; margin: auto;"></iframe>
                                </div>

                            <!-- </div> --><!-- main-sidebar-inner END -->
                        </div><!-- col-md-4 END -->

                    </div><!-- row END -->

                </div><!-- container END -->
</asp:Content>

