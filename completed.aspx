<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="completed.aspx.cs" Inherits="completed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main-content">

            <div class="breadArea">
                <div class="container">
                    <ol class="breadcrumb">
                        <li>
                            <a href="hp.html">HOME</a>
                        </li>
                        <li class="active">完成訂單</li>
                    </ol>
                </div>
            </div>
            <!-- breadArea END -->

            <div class="container">

                <div class="row">

                    <div class="col-md-8 main-content">
                        <div class="main-content-inner">

                            <article class="post-layout post">

                                <div class="post-header">

                                    <div class="post-information">
                                        <h1>版權聲明</h1>
                                        <div class="meta-info">
                                            <span class="post-date">
                                                <time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time>
                                            </span>
                                        </div>
                                        <!-- meta-info END -->
                                    </div>
                                    <!-- post-information END -->

                                </div>
                                <!-- post-header END -->

                    <div class="post-content">
                        <div class="text-block">
                            <div class="title title-g-yellow text-bk">
                                <i class="glyphicon glyphicon-shopping-cart text-bk"></i>完成訂購
                            </div>

                            <ul>
                                <li>訂單編號：<span id="ord_code"><%=ord_code%></span></li>
                                <li>訂購日期：<span id="ord_date"> <%=ord_date%></span></li>
                                <li>付款方式：<span id="ord_pay"> <%=ord_pay%>   </span></li>
                                <li>付款金額：<span id="ord_totalprice"><%=ord_totalprice%></span> 元</li>

                            </ul>
                        </div>
                        <h4>訂單明細</h4>


                        <asp:Repeater ID="temp_product" runat="server">
                            <ItemTemplate>
                                <div class="form-group">
                                    <a href="product-page.aspx?p_ID=<%# Eval("p_id") %>">
                                        <img src="upload/<%#Eval("pic1") %>" class="img-responsive"></a>
                                </div>
                                <div class="form-group">
                                    <%#Eval("productname")%>
                                </div>

                                <div class="form-group">
                                    <label for="inputNumber" class="col-sm-2 control-label">數 量</label>
                                    <%#Eval("num") %>
                                </div>
                                <div class="form-group">
                                    <label for="inputNumber" class="col-sm-2 control-label">金 額</label>
                                    <small>$</small><%#Eval ("price") %>
                                </div>


                            </ItemTemplate>
                        </asp:Repeater>





                        <h4 class="panel-title title title-g-yellow text-bk m-top-1">購買人資料 <i class="glyphicon glyphicon-menu-up text-bk pull-right"></i>
                        </h4>

                        <ul>
                            <li>姓名：<span id="consignee_name"><%=ord_name%></span></li>
                            <li>手機號碼：<span id="consignee_cellphone"><%=ord_tel %></span></li>
                            <li>email：<span id="consignee_zip"><%=email%></span></li>
                            <li>地址：<span id="consignee_address"><%=ord_address  %></span></li>
                        </ul>



                        訂單查詢專線: 
                        </div>
  <!-- post-content END -->

                            </article>

                        </div>
                        <!-- main-content-inner END -->

                    </div>
                    <!-- col-md-8 td-main-content END -->


                </div>
                <!-- row END -->

            </div>
            <!-- container END -->

        </div>
        <!-- main-content END -->
</asp:Content>

