<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="member-order.aspx.cs" Inherits="member_order" %>

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
                                   
                       <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <table class="table table-striped market-tab-2">
                                    <tbody>
                                        <tr>
                                            <th width="20%">訂購日期</th>
                                            <th width="20%">訂單編號</th>
                                            <th width="20%">訂單總額</th>
                                            <th width="20%">付款方式</th>
                                            <th width="20%">處理進度</th>
                                        </tr>
                                    <asp:Repeater ID="Repeater1" runat="server">
                                        <ItemTemplate>
                                        <tr class="underline">
                                            <td class="text-center"><%# DateTime.Parse ( Eval("ord_date").ToString ()).ToShortDateString () %></td>
                                            <td class="text-center"><a href="member-order-detail?ord_code=<%#Eval("ord_code") %>"><%#Eval("ord_code") %></a></td>
                                            <td class="text-center">NTD$<%#Eval("TotalPrice") %></td>
                                            <td class="text-center"><%# OrderLib.getPaymode (Eval("paymode").ToString ()) %></td>
                                            <td class="text-center"><%# OrderLib.get_ord_status (Eval("status").ToString ()) %></td>                                        
                                        </tr>
                                         </ItemTemplate>
                                    </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                                  
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

