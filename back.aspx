<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="back.aspx.cs" Inherits="back" %>

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
                                        <h1>完成訂單</h1>
                                        <div class="meta-info">
                                            <h3 style="color: rgb(34, 34, 34); font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: -webkit-left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;">購買資訊</h3>
                                            <table class="m_630512742987122030table m_630512742987122030process-tab" style="border-spacing: 0px; color: rgb(34, 34, 34); font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;">
                                                <tr>
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;" width="40%">品名</td>
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;" width="20%">單價</td>
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;" width="20%">數量</td>
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;" width="20%">小計</td>
                                                </tr>
                                                <tr>
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">【日本HONEY COFFEE】濃縮咖啡球-無糖(10入/袋)</td>
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">320</td>
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">2</td>
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">640</td>
                                                </tr>
                                                <tr class="m_630512742987122030underline">
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">取貨方式</td>
                                                    <td colspan="3" style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">郵寄</td>
                                                </tr>
                                                <tr class="m_630512742987122030underline">
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">運費</td>
                                                    <td colspan="3" style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">0</td>
                                                </tr>
                                                <tr class="m_630512742987122030underline">
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">付款方式</td>
                                                    <td colspan="3" style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">ATM轉帳匯款</td>
                                                </tr>
                                                <tr class="m_630512742987122030underline">
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">銀行代碼</td>
                                                    <td colspan="3" style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">812</td>
                                                </tr>
                                                <tr class="m_630512742987122030underline">
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">帳號</td>
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;"></td>
                                                    <td colspan="3" style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">TestAccount12345</td>
                                                </tr>
                                                <tr class="m_630512742987122030underline">
                                                    <td style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">有效期限</td>
                                                    <td colspan="3" style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">2019-01-05 23:59:59</td>
                                                </tr>
                                                <tr class="m_630512742987122030total m_630512742987122030underline">
                                                    <td colspan="3" style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">總計</td>
                                                    <td class="m_630512742987122030text-right" style="font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; margin: 0px; border-collapse: collapse;">NT$:640</td>
                                                </tr>
                                            </table>
                                            <div class="m_630512742987122030member-course-info" style="color: rgb(34, 34, 34); font-family: Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: -webkit-left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;">
                                                <div class="m_630512742987122030notice">
                                                    <h4>注意事項</h4>
                                                </div>
                                            </div>
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
                                    <small>$</small><%#Eval ("price") %></div>


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
