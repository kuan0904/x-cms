<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="member-collection.aspx.cs" Inherits="member_collection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="main-content">

            <div class="breadArea">
                <div class="container">
                    <ol class="breadcrumb">
                        <li>
                            <a href="/">HOME</a>
                        </li>
                        <li>會員中心</li>
                        <li class="active">我的收藏</li>
                    </ol>
                </div>
            </div>
            <!-- breadArea END -->

            <div class="container">

                <div class="row">
                    <div class="col-md-2 hidden-sm hidden-xs">
                        <div class="member-subnav">
                            <div class="subnav-title">我的藝時代</div>
                            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingOne">
                                        <h4 class="panel-title">
                                            <a href="/member-order">查詢訂單</a>
                                        </h4>
                                    </div>
                                </div>
                                    <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingTwo">
                                        <h4 class="panel-title">
                                            <a href="/member-class">查詢活動</a>
                                        </h4>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingThree">
                                        <h4 class="panel-title">
                                            <a href="/member-collection" class="active">我的收藏</a>
                                        </h4>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingFour">
                                        <h4 class="panel-title">
                                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false"
                                                aria-controls="collapseFour">
                                                會員設定
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                                        <ul class="list-group">
                                            <a href="/member-edit" class="list-group-item">修改個人資料</a>
                                            <a href="/member-password" class="list-group-item">變更密碼</a>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-10 col-sm-12 col-xs-12">
                        <article class="post-layout post">
                            <div class="post-header">
                                <div class="post-information">
                                    <h1>我的收藏</h1>
                                </div>
                                <!-- post-information END -->
                            </div>
                            <!-- post-header END -->
                        </article>
                        <div class="row news-grid">
                            <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>
                                <div class="col-md-4 col-sm-4 col-xs-6">
                                    <div class="member-course">
                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="/webimages/article/<%#Eval("pic") %>" alt="" title="<%#Eval("subject") %>">
                                                <a class="view-more" href="/Article/<%#Eval("articleId") %>" title="了解更多">
                                                    <span>more</span>
                                                </a>
                                            </div>

                                            <div class="member-course-info" style="padding:15px;">
                                                <div class="member-course-title ">
                                                    <a href="/Article/<%#Eval("articleId") %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a>
                                                </div>
                                                <!--
                                                <div class="member-course-date">2018/07/27（五）至2018/07/27（五）
                                                </div>
                                                -->
                                                <!-- meta-info END -->
                                                <div class="member-cours-description">
                                                     <%# unity.classlib.SubString ( Eval("contents").ToString (),100,"notag") %>
                                                </div>
                                                <div class="clearfix">
                                                    <div class="member-cours-heart pull-left active">
                                                        <i class="fa fa-heart fa-lg" aria-hidden="true"></i>
                                                    </div>
                                                    <div class="member-cours-more pull-right">
                                                        <a class="btn btn-green btn-block " href="/Article/<%#Eval("articleId") %>" role="button">看全文</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <!-- col-md-4 col-sm-6 col-xs-6 END -->

                                </ItemTemplate>

                            </asp:Repeater>
                            <!---->
                        
   

                        </div>
                        <!-- news-grid END -->
                        <div class="center-block text-center">
                                <ul class="pagination">
                                   <%=PagePaging (Request.Url.AbsolutePath) %>
                                </ul>
                            </div>
                    </div>
                    <!-- col-sm-12 -main-content END -->

                    <!-- col-md-8 td-main-content END -->
                </div>
                <!-- row END -->
            </div>
            <!-- container END -->
        </div>
</asp:Content>

