<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="completed.aspx.cs" Inherits="completed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main-content">

            <div class="breadArea">
                <div class="container">
                    <ol class="breadcrumb">
                        <li>
                            <a href="/">HOME</a>
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
                                        <h1>完成訂單</h1>
                                        <div class="meta-info">
                                            狀態:<%=ord_status %>
                                            <span class="post-date">

                                                <time datetime="2017-07-26T14:17:05+00:00"><%=DateTime.Now.ToString ("yyyy-MM-dd hh:mm:ss") %></time>
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
                                <li>訂單編號：<span id="ord_code"><%=o.Ord_code %></span></li>
                                <li>訂購日期：<span id="ord_date"> <%=o.Orddate.ToString ("yyy/MM/dd") %></span></li>
                                <li>付款方式：<span id="ord_pay"> <%= OrderLib.getPaymode ( o.Paymode)  %> </span></li>
                                <li>付款金額：<span id="ord_totalprice"><%=String.Format("{0:C0}",  o.TotalPrice) %></span> 元</li>

                            </ul>
                        </div>
                        <h4>訂單明細</h4>


                        <asp:Repeater ID="temp_product" runat="server">
                            <ItemTemplate>
                                <div class="form-group">
                                    <a href="#">
                                        <img src="upload/<%#Eval("pic") %>" class="img-responsive"></a>
                                </div>
                                <div class="form-group">
                                    <%#Eval("P_name")%>
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
                            <li>姓名：<span id="consignee_name"><%=o.Ordname %></span></li>
                            <li>手機號碼：<span id="consignee_cellphone"><%=o.Ordphone  %></span></li>
                            <li>email：<span id="consignee_zip"><%=o.Ordemail %></span></li>
                            <li>地址：<span id="consignee_address"><%=o.Ordaddress  %></span></li>
                        </ul>



                        訂單查詢專線: (02) 2322-2635
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

