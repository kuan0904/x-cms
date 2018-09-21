<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="main-content">

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

            <!--熱門文章區塊-->
            <div class="container">

                <div class="row">
                    <!--熱門文章區塊-->
                    <div class="main-content">
                        <div class=main-content-inner>
                            <div class="topic text-center">
                                <div class="topic-words">
                                    <div class="underline"></div>
                                    <h1>熱門文章</h1>
                                </div>
                            </div>

                            <div class="news-wrap">
                                <div class="divide20"></div>
                                     <asp:Repeater ID="hot_list_detail" runat="server" EnableViewState ="false" >
                                        <ItemTemplate>
                                <div class="col-md-4 col-sm-6 col-xs-12">
                                    <div class="thumbnail">
                                        <div class="pic">
                                            <img src="<%#Eval("pic") %>"
                                                alt="" title="<%#Eval("subject") %>">
                                            <a class="view-more" href="/Article/<%#Eval("id") %>" title="了解更多">
                                                <span>more</span>
                                            </a>
                                        </div>

                                        <div class="caption">
                                            <div class="category">
                                                  <%# article.Web.Get_category_link  ((int) Eval("id"))%>
                                            </div>
                                            <h3 class="list-title">
                                                <a href="/Article/<%#Eval("id") %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a>
                                            </h3>
                                            <!-- meta-info END -->
                                        </div>
                                    </div>
                                </div>
                                <!-- col-md-12 END -->
                        </ItemTemplate>
                                         </asp:Repeater>
                                <div class="center-block text-center">
                                    <a class="btn btn-more" href="#">更多熱門文章
                                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                                    </a>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 熱門文章區塊 END -->
        <!--特殊廣告-->
        <div class="main-content" style="background: #0ba29a;">
            <div class="container-fluid">
                <div class=main-content-inner>
                    <div class="news-wrap">
                        <asp:Repeater ID="banner_list" runat="server">
                            <ItemTemplate>
                                <div class="col-md-4 col-sm-4 col-xs-12 big-banner-box">
                                    <div class="thumbnail">
                                        <div class="pic effect">
                                            <img src="<%#Eval("pic") %>" alt="" title="<%#Eval("subject") %>">
                                            <a class="view-more" href="/Article/<%#Eval("id") %>" title="了解更多">
                                                <span><%#Eval("subject") %></span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <!-- col-md-12 END -->
                            </ItemTemplate>
                        </asp:Repeater>
            

             
           
                    </div>
                    <!-- news-list END -->

                </div>
                <!-- main-content-inner END -->
            </div>
        </div>
        <!--特殊廣告-->
        <!--課程區塊-->
    <!--
        <div class="container">
            <div class="row">
              
                <div class="main-content">
                    <div class=main-content-inner>
                        <div class="topic text-center">
                            <div class="topic-words">
                                <div class="underline"></div>
                                <h1>課程專區</h1>
                            </div>
                        </div>
                        <div class="news-wrap">
                            <div class="divide20"></div>
                            <div class="col-md-4 col-sm-6 col-xs-12">
                                <div class="thumbnail course">
                                    <div class="pic">
                                        <img src="images/001.png" alt="" title="課程名稱">
                                        <a class="view-more" href="detail-course.html" title="了解更多">
                                            <a href="list.html" class="course-tag">體驗</a>
                                        </a>
                                    </div>
                                    <div class="caption">

                                        <h3 class="new-index-list-title">
                                            <a href="detail-course.html" title="課程名稱">【台北場】 筆尖溫度｜一起來學手寫 「義大利體藝術字」</a>
                                        </h3>
                                        <table class="course-table" valign="top">
                                            <tr>
                                                <td>時間</td>
                                                <td>2017/10/11 至 2017/10/30
                                                    <br> 一三五晚上 14:00 至 16:00</td>
                                            </tr>
                                            <tr>
                                                <td>地點</td>
                                                <td>CLBC 八德大船艦
                                                    <br> 台北市松山區八德四路123號3樓</td>
                                            </tr>
                                            <tr>
                                                <td>講師</td>
                                                <td>鍾佳伶 Charling</td>
                                            </tr>
                                            <tr>
                                                <td>費用</td>
                                                <td>NT $999</td>
                                            </tr>
                                        </table>
                                        <button class="btn btn-warning btn-register">立即報名</button>
                                    </div>
                                </div>
                            </div>
                         
                            
                                 

                            <div class="center-block text-center">
                                <a class="btn btn-more" href="#">更多精選活動
                                    <i class="fa fa-angle-right" aria-hidden="true"></i>
                                </a>
                            </div>

                       
                        </div>
                      

                    </div>
                                   </div>
            </div>
           
        </div>
        -->
</asp:Content>

