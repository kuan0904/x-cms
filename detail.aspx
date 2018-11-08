<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- ScrollToFixed v1.0.8 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollToFixed/1.0.8/jquery-scrolltofixed-min.js"></script>
    <script>
        $(document).ready(function () {
            $("#right").scrollToFixed({
                // 參數設定[註1]
                marginTop: $(".header").outerHeight(), // 與上面的間距
                //limit: $( "#container2" ).offset().top, // 超過此高度，取消釘住
                zIndex: 999, // 圖層深度
                //spacerClass: "spacer", // 間隔的類別名稱
                //minWidth: false, // 當視窗寬度小於此時，關閉釘住功能
                //maxWidth: false, // 當視窗寬度大於此時，關閉釘住功能
                //dontCheckForPositionFixedSupport: false, // 關閉確認瀏覽器是否支援fixed功能
                //dontSetWidth: false, // 當物件是absolute或fixed時，不設定寬度
                //removeOffsets: false, // 當物件是absolute時，移除向左偏移
                //offsets: false, // 設定向左偏移
                //preAbsolute: function() { console.log( "preAbsolute" ) }, // 物件變成absolute後，會呼叫此函式
                //postAbsolute: function() { console.log( "postAbsolute" ) }, // 物件離開absolute後，會呼叫此函式
                //preFixed: function() { console.log( "preFixed" ) }, // 物件變成fixed後，會呼叫此函式
                //postFixed: function() { console.log( "postFixed" ) }, // 物件離開fixed後，會呼叫此函式
                //fixed: function() { console.log( "fixed" ) }, // 物件是fixed時，會呼叫此函式
                //unfixed: function() { console.log( "unfixed" ) }, // 物件不是fixed時，會呼叫此函式
            });

              $(window).on('resize', function () {
              });
            var searchtext = "";
            $(".post-tags a").each(function () {
                if (searchtext != "") searchtext += ","
                searchtext += $(this).html();
            });

            $.post("http://210.61.119.142:2322/tagrec", { "search_string": searchtext, "fullmatch": "1", "search_type": "tag", "limit": "10" },
                function (data) {
                    var html = "";
                    data = JSON.parse(data);
                    $.each(data, function (key, val) {

                        html += "<li> <i class=\"fa-li fa fa-angle-right\"></i><a href=\"http://www.businesstoday.com.tw/" + val["transaction"] + "\" target=_blank>" + val["title"] + "</a></li>";

                    });
                    $("#pushread").html(html);

                }, "json");

        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main-content">

        <div class="breadArea">
            <div class="container">
                <ol class="breadcrumb">
                    <li><a href="/">HOME</a></li>
                    <%=pageunit %>
                </ol>
            </div>
        </div>
        <!-- breadArea END -->

        <div class="container">
            <div class="row">
                <div class="col-md-8 col-sm-12 col-xs-12 main-content">
                    <div class="main-content-inner">
                        <article class="post-layout post">
                            <div class="post-header">
                                <div class="divide20"></div>
                                <div class="post-information-RL-15">
                                    <ul class="category">
                                        <li class="entry-category"><%=tags%></li>
                                    </ul>
                                    <h1><%=subject %></h1>
                                    <div class="meta-info clearfix">
                                        <div class="pull-left social-media-share-btn">
                                            <a href="#" class="share-fb" data-item="<%=Articleid%>" title="facebook">
                                                <i class="fa fa-2x fa-facebook-official" aria-hidden="true"></i>
                                            </a>
                                            <a href="#" class="share-google" data-item="<%=Articleid%>" title="google">
                                                <i class="fa fa-2x fa-google-plus-square" aria-hidden="true"></i>
                                            </a>
                                            <a href="#" class="share-twitter" data-item="<%=Articleid%>" title="twitter">
                                                <i class="fa fa-2x fa-twitter" aria-hidden="true"></i>
                                            </a>
                                            <a href="#" class="share-pinterest" data-item="<%=Articleid%>" title="pinterest">
                                                <i class="fa fa-2x fa-pinterest" aria-hidden="true"></i>
                                            </a>
                                            <a href="#" class="share-collection<%=iscollection%>" title="加入收藏" data-item="<%=Articleid%>">
                                                <i class="fa fa-2x fa-heart" aria-hidden="true"></i>
                                            </a>
                                        </div>
                                        <div class="pull-rigt text-right">
                                            <div class="post-author">
                                                <span>By</span>
                                                <%= author  %>
                                                <span>- </span>
                                            </div>
                                            <span class="post-date">
                                                <time datetime="<%=postday %>"><%=postday %></time>
                                            </span>
                                            <div class="post-views">
                                                <i class="fa fa-eye"></i><%=viewcount  %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="post-featured-image"><%=pic %> </div>

                                <!-- meta-info END -->
                            </div>
                            <!-- post-header END -->

                            <div class="post-content">
                                <%=subtitle %>
                                <%=contents %>
                            </div>
                            <!-- post-content END -->

                            <asp:Repeater ID="Repeater_file" runat="server">
                                <HeaderTemplate>
                                    <h2>相關檔案</h2>
                                    <section class="section-top-0 section-sm-top-0">
                                        <div class="shell">
                                            <div class="range">
                                                <div class="cell-md-10 cell-lg-8">
                                                    <div class="table-mobile">
                                                        <table class="table table-striped">
                                                            <thead>
                                                                <tr>
                                                                    <th>#</th>
                                                                    <th>下載報名表</th>
                                                                    <th>檔案名稱</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Container.ItemIndex + 1 %></td>
                                        <td><a href="/webimages/files/<%#Eval("filename") %>" class="download" target="_blank">
                                            <img src="/images/download-file.svg" alt="" width="50"></a></td>
                                        <td><%#Eval("filename") %></td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </tbody>
                                                    </table>
                                                    </div>
                                                </div>
                                                </div>
                                            </div>
                                            </section>
                                </FooterTemplate>
                            </asp:Repeater>


                            <!-- post-content END -->
                            <div class="center-block text-center">
                                <div class="post-tags">
                                    <%=  keywords %>
                                </div>
                            </div>
                            <div class="divide20"></div>
                            <div class="post-information-RL-15">

                                <div id="fb-root"></div>
                                <script>(function (d, s, id) {
                                        var js, fjs = d.getElementsByTagName(s)[0];
                                        if (d.getElementById(id)) return;
                                        js = d.createElement(s); js.id = id;
                                        js.src = 'https://connect.facebook.net/zh_TW/sdk.js#xfbml=1&version=v3.1&appId=164103481107660&autoLogAppEvents=1';
                                        fjs.parentNode.insertBefore(js, fjs);
                                    }(document, 'script', 'facebook-jssdk'));</script>
                                <div class="fb-comments" data-href="https://developers.facebook.com/docs/plugins/comments#Article<%=Articleid %>" data-numposts="5"></div>

                            </div>
                            <div class="divide20"></div>
                            <div class="extended-reading">
                                <h3 class="new-index-main-title text-center">延伸閱讀</h3>
                                <div class="extended-list">
                                    <ul class="fa-ul">
                                        <asp:Repeater ID="extended_list" runat="server">
                                            <ItemTemplate>
                                                <li>
                                                    <i class="fa-li fa fa-angle-right"></i><a href="/Article/<%#Eval("id") %>"><%#Eval("subject") %></a></li>

                                            </ItemTemplate>
                                        </asp:Repeater>

                                    </ul>
                                </div>

                                <!-- news-list END -->
                            </div>
                            <!-- post-footer END -->

                        </article>

                    </div>
                    <!-- main-content-inner END -->

                </div>
                <!-- col-md-8 td-main-content END -->

                <div class="col-md-4 col-sm-12 col-xs-12 main-sidebar">
                    <!-- <div class=main-sidebar-inner> -->
                    <div class="block-wrap" id="ad_banner1"></div>

                    <div class="block-wrap">

                        <div class="topic text-center">
                            <div class="topic-words">
                                <div class="underline"></div>
                                <h1>訂閱電子報</h1>
                            </div>
                        </div>

                        <div class="epaper-box">
                            <p>精選國內外設計與藝文大事、設計大師最新訪談，每週最新資訊定期遞送給您。</p>
                            <div class="form">
                                <div class="form-group">
                                    <label class="sr-only" for="exampleInputEmail2">Email</label>
                                    <input type="email" class="form-control" id="InputEmail" placeholder="yourmail@example.com">
                                </div>
                                <button id="Emailregist" class="btn btn-green btn-block">
                                    訂閱
                                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="block-wrap" id="hot_list">
                        <!-- news-list END -->
                    </div>

                    <div class="block-wrap">

                        <div class="topic text-center">
                            <div class="topic-words">
                                <div class="underline"></div>
                                <h1>追蹤我們</h1>
                            </div>
                        </div>

                        <!-- <div class="divide20"></div> -->
                        <div class="fb-page" data-href="<%=Application["fb_url"] %>" data-tabs="timeline" data-width="400" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true">
                            <blockquote cite="<%=Application["fb_url"] %>" class="fb-xfbml-parse-ignore"><a href="<%=Application["fb_url"] %>"><%=Application["site_name"] %></a></blockquote>
                        </div>
                    </div>
                    <div class="block-wrap" id="ad_banner2"></div>
                    <div class="divide20"></div>
                    <div class="extended-reading" id="right">
                        <h3 class="new-index-main-title text-center">站外推薦</h3>
                        <div class="extended-list">
                            <ul class="fa-ul" id="pushread">
                            </ul>
                        </div>

                        <!-- news-list END -->
                    </div>
                    <!-- main-sidebar-inner END -->
                </div>
                <!-- col-md-4 END -->


            </div>
            <!-- row END -->



        </div>
        <!-- container END -->
    </div>


    <div class="main-content" style="background: rgb(245, 253, 168);">
        <div class="container-fluid">
            <div class="main-content-inner">
                <div class="container">
                    <div class="news-wrap">
                        <asp:Repeater ID="Repeater2" runat="server">
                            <ItemTemplate>
                                <div class="col-md-4 col-sm-4 col-xs-12 big-banner-box">
                                    <div class="thumbnail">
                                        <div class="pic effect">
                                            <img src="<%#Eval("pic") %>" alt="" title="<%#Eval("subject") %>">
                                            <a class="view-more" href="/Article/<%#Eval("id") %>" title="了解更多">
                                                <span><%#Eval("subject") %></span>
                                            </a>
                                            <div class="category">
                                                <%# article.Web.Get_category_link  ((int) Eval("id"))%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- col-md-12 END -->
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <!-- news-list END -->
            </div>
        </div>
        <!-- main-content-inner END -->
    </div>
    <a href="javascript: history.go(-1)" class="btn btn-back">
        <span class="fa fa-angle-left"></span>BACK
    </a>
    <a href="https://social-plugins.line.me/lineit/share?url=<%= Request.Url.AbsoluteUri %>&text=<%=subject  %>%0D%0A<%= Request.Url.AbsoluteUri %>&from=line_scheme" target="_blank"><i class="ico-line-img"></i></a>

</asp:Content>

