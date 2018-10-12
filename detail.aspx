<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script>
     $(document).ready(function () {
      //    if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
          
              $('img').each(function () {
                $(this).removeAttr('style')
            });
             
     //   }

        
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
                                                <a href="#" class="share-fb" data-item="<%=Articleid%>"  title="facebook">
                                                    <i class="fa fa-2x fa-facebook-official" aria-hidden="true"></i>
                                                </a>
                                                <a href="#" class="share-google" data-item="<%=Articleid%>"  title="google">
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
                                                    <span> - </span>
                                                </div> 
                                                <span class="post-date">
                                                    <time datetime="<%=postday %>"><%=postday %></time>
                                                </span>  
                                                <div class=post-views>
                                                        <i class="fa fa-eye"></i><%=viewcount  %></div>
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
  
                                <asp:Repeater ID="Repeater_file" runat="server" >   
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
                                                    <td><a href="/webimages/files/<%#Eval("filename") %>" class ="download" target="_blank"><img src="/images/download-file.svg" alt="" width="50"></a></td>
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
                                        <%= keywords %>
                                    </div>
                                </div> 
                                <div class="divide20"></div>        
                                     <div class="post-information-RL-15">
                                        
<div id="fb-root"></div>
<script>(function(d, s, id) {
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
               

                          
            </div>
            <!-- container END -->
            </div> 

 
    <div class="main-content" style="background: rgb(245, 253, 168);">
                <div class="container-fluid">
                    <div class=main-content-inner>
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
       <a href="https://social-plugins.line.me/lineit/share?url=<%= Request.Url.AbsoluteUri %>&text=<%=subject  %>%0D%0A<%= Request.Url.AbsoluteUri %>&from=line_scheme"  target="_blank"><i class="ico-line-img"></i></a>

</asp:Content>

