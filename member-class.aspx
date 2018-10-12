<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="member-class.aspx.cs" Inherits="member_class" %>
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
                        <li class="active">會員中心</li>
                        <li class="active">變更密碼</li>
                    </ol>
                </div>
            </div>
            <!-- breadArea END -->

            <div class="container">

                <div class="row">
                    <div class="col-md-2 col-sm-3 col-xs-12 hidden-sm hidden-xs">
                        <div class="member-subnav">
                            <div class="subnav-title">我的藝時代</div>
                            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingOne">
                                        <h4 class="panel-title">
                                            <a href="/member-order" class="active">查詢訂單</a>
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
                                            <a href="/member-collection">我的收藏</a>
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
                    <div class="col-md-10 col-sm-9 col-xs-12">
                        <article class="post-layout post">
                            <div class="post-header">
                                <div class="post-information">
                                    <h1>查詢訂單</h1>
                                </div>
                                <!-- post-information END -->
                            </div>
                            <!-- post-header END -->
                        </article>
                        <div class="member-order">
                                         <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>
                            <div class="row">
                                <div class="col-md-10 col-sm-9 col-xs-12">
                                    <div class="member-course-info">
                                        <div class="member-order-title">
                                            <a href="/Article/<%#Eval("Articleid") %>" title="<%#Eval("ord_code") %>" target="_blank" ><%#Eval("subject") %></a>
                                            <span class="label label-no-payment">未繳費</span>
                                            <span class="label label-payment">已付款</span>
                                            <span class="label label-free">免繳費</span>
                                        </div>
                                        <div class="member-course-date">
                                            <i class="fa fa-clock-o margin-R-5" aria-hidden="true"></i>下單日期：<%# DateTime.Parse ( Eval("crtdat").ToString ()).ToString ("yyyy/MM/dd") %>
                                            <br/>
                                            <i class="fa fa-file-text-o margin-R-5" aria-hidden="true"></i>訂單編號：<%#Eval("ord_code") %>
                                        </div>
                                        <div class="member-order-amount">
                                            <span class="number">NT$<%#Eval("totalprice") %></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2 col-sm-3 col-xs-12">
                                    <div class="member-course-info btn-margin-15">
                                        <!-- Button trigger modal -->
                                        <button type="button" class="btn btn-green btn-block " data-toggle="modal" data-target="#myTicket">
                                            快速取票
                                        </button>

                                        <br/>
                                        <a class="btn btn-gray btn-block " href="member-class-detail?ord_code=<%#Eval("ord_code") %>" role="button">報名資料</a>
                                    </div>
                                </div>
                            </div>
                                    </ItemTemplate>
                                    </asp:Repeater>
                        </div>
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

