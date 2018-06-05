<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script>
           
        $(document).ready(function () {     
            var dataValue = {"kind":"list"};             
            $.post('/hot_list', dataValue, function (result) { $("#hot_list").html(result); });
            dataValue = {"classid":"2"};             
            $.post('/AdBanner', dataValue, function (result) { $("#ad_banner1").html(result); });
            $.post('/AdBanner', dataValue, function (result) { $("#ad_banner2").html(result); });
              //分享至臉書
	        $("a.btn-share.facebook").click(function () {
	        window.open('https://www.facebook.com/share.php?u='.concat(encodeURIComponent(location.href)), "_blank", "toolbar=yes,location=yes, directories=no, status=no,menubar=yes,scrollbars=yes,esizable=no, copyhistory=yes, width=600,  height=400")
            })
            $("a.btn-share.twitter").click(function () {
                text=   $(document).find("title").text();
	            window.open('http://twitter.com/share?text='+ text +'&url='.concat(encodeURIComponent(location.href)), "_blank", "toolbar=yes,location=yes, directories=no, status=no,menubar=yes,scrollbars=yes,esizable=no, copyhistory=yes, width=600,  height=400")
            })
            $("a.btn-share.google").click(function () {
	            window.open('https://plus.google.com/share?url='.concat(encodeURIComponent(location.href)), "_blank", "toolbar=yes,location=yes, directories=no, status=no,menubar=yes,scrollbars=yes,esizable=no, copyhistory=yes, width=600,  height=400")
            })

            $("a.btn-share.pinterest").click(function () {
                text=   $(document).find("title").text();
	            window.open('http://pinterest.com/pin/create/button/?description='+ text + '&url='.concat(encodeURIComponent(location.href)), "_blank", "toolbar=yes,location=yes, directories=no, status=no,menubar=yes,scrollbars=yes,esizable=no, copyhistory=yes, width=600,  height=400")
            })

          


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

                    <a href="javascript: history.go(-1)" class="btn btn-back">
                        <span class="fa fa-angle-left"></span>BACK
                    </a>

                    <div class="row">

                        <div class="col-md-8 col-sm-8 main-content">
                            <div class="main-content-inner">

                                <article class="post-layout post">

                                    <div class="post-header">

                                        <div class="post-featured-image"><%=pic %> </div>
                                        <div class="post-information">
                                            <ul class="category">
                                                <li class="entry-category"><a href="#"><%=tags%></a></li>
                                            </ul>
                                            <h1><%=subject %></h1>
                                            <div class="meta-info">
                                                <div class="post-author">
                                                    <span>By</span>
                                                    <a href="#/author/admin/"> <%= author  %></a>
                                                    <span> - </span>
                                                </div>
                                                <span class="post-date"><time datetime="<%=postday %>"><%=postday %></time></span>
                                                <div class="post-views">
                                                    <i class="fa fa-eye"></i><%=viewcount  %></div>
                                                <div class="post-comments">
                                                    <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                                </div>
                                                <div class="post-keywords">
                                                    <i class="fa fa-tags"></i>
                                                     <%= keywords %>
                                                   
                                                </div>
                                            </div>
                                        </div><!-- meta-info END -->

                                        <div class="post-sharing">
                                            <span class="post-share-title">SHARE</span>
                                            <div class="sharing-group">
                                                <a class="btn-share facebook" href="#" >
                                                    <div class="icon-elements facebook"></div>
                                                    <div class="social-text">Facebook</div>
                                                </a>

                                                <a class="btn-share twitter" href="#"><div class="icon-elements twitter"></div><div class="social-text">Twitter</div></a>

                                                <a class="btn-share google" href="#" ><div class="icon-elements googleplus"></div></a>

                                                <a class="btn-share pinterest" href="#" ><div class="icon-elements pinterest"></div></a>

                                                <a class="btn-share whatsapp" href="#"><div class="icon-elements whatsapp"></div></a>

                                                <div class="clearfix"></div>
                                            </div><!-- sharing-group END -->
                                        </div><!-- post-sharing END -->
                                    </div><!-- post-header END -->

                                    <div class="post-content">
                                      <%=contents %>          </div><!-- post-content END -->

                                    <div class="post-footer">
                                        <div class="post-sharing">
                                            <span class="post-share-title">SHARE</span>
                                            <div class="sharing-group">
                                                <a class="btn-share facebook" href="#" >
                                                    <div class="icon-elements facebook"></div>
                                                    <div class="social-text">Facebook</div>
                                                </a>

                                                <a class="btn-share twitter" href="#"><div class="icon-elements twitter"></div><div class="social-text">Twitter</div></a>

                                                <a class="btn-share google" href="#" ><div class="icon-elements googleplus"></div></a>

                                                <a class="btn-share pinterest" href="#"><div class="icon-elements pinterest"></div></a>

                                                <a class="btn-share whatsapp" href="#"><div class="icon-elements whatsapp"></div></a>

                                                <div class="clearfix"></div>
                                            </div><!-- sharing-group END -->
                                        </div><!-- post-sharing END -->
                                    </div><!-- post-footer END -->

                                </article>

                            </div><!-- main-content-inner END -->

                        </div><!-- col-md-8 td-main-content END -->

                        <div class="col-md-4 col-sm-4 main-sidebar">
                            <!-- <div class=main-sidebar-inner> -->

                                <div class="block-wrap" id="ad_banner1"></div>   

                                <div class="block-wrap">
                                    <div class=block-title>訂閱電子報</div>
                                    <div class="epaper-box">
                                        <p>精選國內外設計與藝文大事、設計大師最新訪談，每週最新資訊定期遞送給您。</p>
                                        <div class="form-inline">
                                          <div class="form-group">
                                            <label class="sr-only" for="exampleInputEmail2">Email</label>
                                            <input type="email" class="form-control" id="exampleInputEmail2" placeholder="yourmail@example.com">
                                          </div>
                                          <button type="submit" class="btn btn-default">訂閱</button>
                                        </div>
                                    </div>
                                </div>
                              <div class="block-wrap"  id="hot_list"></div>
                                <div class="block-wrap">
                                    <iframe src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2F%E6%99%BA%E5%AA%92%E6%99%82%E4%BB%A3-1880890488818139%2F&tabs=timeline&width=300&height=500&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=1355515061131043" width="300" height="500" scrolling="no" frameborder="0" allowTransparency="true" style="display: block; width: 300px; margin: auto;">
                                    </iframe>
                                </div>
                                <div class="block-wrap" id="ad_banner2"></div>   
                            <!-- </div> --><!-- main-sidebar-inner END -->
                        </div><!-- col-md-4 END -->


                    </div><!-- row END -->

                </div><!-- container END -->

</asp:Content>

