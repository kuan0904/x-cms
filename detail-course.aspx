<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="detail-course.aspx.cs" Inherits="detail_course_" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script>
           
        $(document).ready(function () {     
         
            
              

        });
            function checkjoin(id) {
                   var islogin = "";
                  $.post('/lib/member_handle.ashx', {                                       
                            "p_ACTION": "CheckLogin", "_": new Date().getTime()
                        }, function (data) {
                            if (data == "-1") {
                                alert('請先登入');
                                $( ".login-modal-js" ).trigger( "click" );
                            }
                            else {
                                location.href = '/join.aspx?lessonid=' + id;
                            }
                        });
            }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="breadArea">
                    <div class="container">
                        <ol class="breadcrumb">
                            <li><a href="/">HOME</a></li>
                           <%=pageunit %>
                        </ol>
                    </div>
                </div><!-- breadArea END -->
          <div class="main-content">

    
                <div class="container">


                    <div class="row">

                        <div class="col-md-4 col-md-push-9 col-sm-4 main-sidebar">
                            <!-- <div class=main-sidebar-inner> -->

                                <div class="post-header">

                                    <div class="post-information">
                                        <ul class="category">
                                            <li class="entry-category"><%=tags%></li>
                                        </ul>
                                        <h1><%=subject  %></h1>
                                        <div class="post-description">
                                          <%=title  %>
                                        </div><!-- post-description END -->
                                    </div><!-- post-information END -->

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
                                                <a href="#" class="share-collection active" title="加入收藏" data-item="<%=Articleid%>">
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
                                </div><!-- post-header END -->

                                <div class="block-wrap border">
                                    <div class=block-title>課程時間</div>
                                    <div class="block-body">
                                        <%=startday  %> 至 <%=endday  %><br>
                                       <%=lessontime  %>
                                    </div>
                                </div><!-- block-wrap END -->

                                <div class="block-wrap border">
                                    <div class=block-title>上課地點</div>
                                    <div class="block-body">
                                        <a href="https://www.google.com.tw/maps?q=<%=address %>" class="link" target="_blank"><%=address %></a>
                                    </div>
                                </div><!-- block-wrap END -->

                            <asp:Repeater ID="Repeater1" runat="server" EnableViewState="False">
                                <ItemTemplate>
                                <div class="block-wrap border">
                                    <div class="block-header">
                                        <div class="media">
                                            <img src="/webimages/people/<%#Eval("pic") %>" alt="" title="<%#Eval("Subject") %>">
                                        </div>
                                        <div class="desc">
                                            <a data-toggle="collapse" href="#desc-01">
                                                <span class="label">講師</span><span class="name"><%#Eval("Subject") %></span>
                                                <span class="note"><%#Eval("title") %></span>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="block-body box collapse in" id="desc-01">
                                      <div class="well">
                                       <%#Eval("contents") %>     </div>
                                    </div>
                                </div><!-- block-wrap END -->

                                </ItemTemplate>
                            </asp:Repeater>

                            <asp:Repeater ID="Repeater2" runat="server">
                                <ItemTemplate>
                                <div class="block-wrap border">
                                    <div class=block-title><%#Eval("description") %></div>
                                    <div class="block-body">
                                        <span class="price">NT $<%#Eval("sellprice") %></span>
                                        <span class="cost">NT $<%#Eval("price") %></span>
                                        <a href="/process-step1?Articleid=<%=Articleid %>&lessonId=<%#Eval("lessonId") %>" class="btn btn-danger btn-block"  >立即報名</a>
                                    </div>
                                </div><!-- block-wrap END -->

                                </ItemTemplate>
                            </asp:Repeater>



                            <!-- </div> --><!-- main-sidebar-inner END -->
                        </div><!-- col-md-4 END -->

                        <div class="col-md-8 col-md-pull-4 col-sm-8 main-content">
                            <div class="main-content-inner">

                                <article class="post-layout post">

                                    <div class="post-header">

                                        <div class="post-featured-image">
                                           <%=pic %>
                                        </div>

                                    </div><!-- post-header END -->

                                    <div class="post-content">
                                          <%=contents %> 

                                    </div><!-- post-footer END -->

                                </article>

                            </div><!-- main-content-inner END -->

                        </div><!-- col-md-8 td-main-content END -->




                    </div><!-- row END -->
                          <a href="javascript: history.go(-1)" class="btn btn-back">
                        <span class="fa fa-angle-left"></span>BACK
                    </a>
                </div><!-- container END -->
              
              
              </div>
</asp:Content>

