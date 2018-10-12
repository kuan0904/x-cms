<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script>
     $(document).ready(function () {
          if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
          
              $('img').each(function () {
                $(this).removeAttr('style')
            });
             
        }

        
     });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
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
                                                <a href="#" class="share-fb" data-item="<%=Articleid%>">
                                                    <i class="fa fa-2x fa-facebook-official" aria-hidden="true"></i>
                                                </a>
                                                <a href="#" class="share-google" data-item="<%=Articleid%>">
                                                    <i class="fa fa-2x fa-google-plus-square" aria-hidden="true"></i>
                                                </a>
                                                <a href="#" class="share-twitter" data-item="<%=Articleid%>">
                                                    <i class="fa fa-2x fa-twitter" aria-hidden="true"></i>
                                                </a>
                                                <a href="#" class="share-print" data-item="<%=Articleid%>">
                                                    <i class="fa fa-2x fa-print" aria-hidden="true"></i>
                                                </a>
                                                <a href="#" class="share-collection" title="加入收藏" data-item="<%=Articleid%>">
                                                    <i class="fa fa-2x fa-heart" aria-hidden="true"></i>
                                                </a>
                                            </div>
                                            <div class="pull-rigt text-right">
                                                <div class="post-author">
                                                    <span>By</span>
                                                   <%= author  %>
                                                    <span> - </span>
                                                </div>
                                                <span class="post-date">
                                                    <time datetime="<%=postday %>"><%=postday %></time>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="post-featured-image"><%=pic %> </div>



                                    <!-- meta-info END -->
                                </div>
                                <!-- post-header END -->

                                <div class="post-content">
                                  <%=contents %>        
                                </div><!-- post-content END -->
  
  
                                

                                <!-- post-content END -->
                                <div class="center-block text-center">
                                    <div class="post-tags">
                                        <%= keywords %>
                                    </div>
                                </div>
                                <div class="divide20"></div>
                                <div class="extended-reading">
                                    
                                        <div class="topic text-center" style="padding-top: 5px">
                                                <div class="topic-words">
                                                    <div class="underline"></div>
                                                    <h1>延伸閱讀</h1>
                                                </div>
                                        </div>

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
                                    <button   id="Emailregist"  class="btn btn-green btn-block">訂閱
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
                            <div class="fb-page" data-href="<%=Application["fb_url"] %>" data-tabs="timeline" data-width="400" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true"><blockquote cite="<%=Application["fb_url"] %>" class="fb-xfbml-parse-ignore"><a href="<%=Application["fb_url"] %>"><%=Application["site_name"] %></a></blockquote></div>
                        </div>
                        <div class="block-wrap" id="ad_banner2"></div>   
                        <!-- </div> -->
                        <!-- main-sidebar-inner END -->
                    </div>
                    <!-- col-md-4 END -->


                </div>
                <!-- row END -->
                   <a href="javascript: history.go(-1)" class="btn btn-back">
                        <span class="fa fa-angle-left"></span>BACK
                    </a>

                             <a href="https://social-plugins.line.me/lineit/share?url=<%= Request.Url.AbsoluteUri %>&text=<%=subject  %>%0D%0A<%= Request.Url.AbsoluteUri %>&from=line_scheme"  target="_blank"><i class="ico-line-img"></i></a>

            </div>
            <!-- container END -->
            </div> 
</asp:Content>

