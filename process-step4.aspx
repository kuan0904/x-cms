<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="process-step4.aspx.cs" Inherits="process_step4" %>

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
                         <%=pageunit %>
                    </ol>
                </div>
            </div>
            <!-- breadArea END -->

            <div class="container">
                <div class="row">
                    <div class="col-xs-12">
                        <article class="post-layout post">
                            <div class="post-header">
                                <div class="post-information">
                                    <h1>訂單編號：A123456</h1>
                                </div>
                                <!-- post-information END -->
                            </div>
                            <!-- post-header END -->
                        </article>
                        <div class="row">
                            <div class="col-md-6 col-sm-12 col-xs-12">
                                <img src="https://i.ytimg.com/vi/RGLaVd9dbgk/maxresdefault.jpg" alt="" title="【台北場】 筆尖溫度｜一起來學手寫 「義大利體藝術字」">
                            </div>
                            <div class="col-md-6 col-sm-12 col-xs-12">
                                <div class="member-course-info">
                                    <div class="member-order-detail-title">
                                        【台北場】 筆尖溫度｜一起來學手寫 「義大利體藝術字」
                                    </div>
                                    <div class="member-course-date">
                                        <p>
                                            <i class="fa fa-calendar margin-R-5"></i>2018/07/27（五）至2018/07/27（五）
                                        </p>
                                        <p>
                                            <a href="https://goo.gl/maps/PDy6Mi5xbtB2" target="_blank">
                                                <i class="fa fa-map-marker margin-R-5"></i>110 台北市信義區菸廠路88號</a>
                                        </p>
                                    </div>
                                    <div class="notice">
                                        <h4>注意事項</h4>
                                        退票須知：委託藝時代退款
                                        <br/> 票券有效日期開始8天前可申請退票，酌收10%手續費，請詳閱
                                        <a href="cp.html" target="_blank">退款操作說明</a>
                                    </div>
                                    <!-- meta-info END -->
                                </div>
                            </div>
                            <div class="col-xs-12">
                                <hr>
                                <!--票券詳細資訊-->
                                <table class="table process-tab">
                                    <tr>
                                        <td width="20%" rowspan="2">票券</td>
                                        <td width="40%">早鳥票</td>
                                        <td width="20%">NT$500 x 2</td>
                                        <td width="20%" class="text-right">NT$1,000</td>
                                    </tr>
                                    <tr>
                                        <td>VIP套票</td>
                                        <td>NT$1,000 x 1</td>
                                        <td class="text-right">NT$2,000</td>
                                    </tr>
                                    <tr class="underline">
                                        <td>取票方式</td>
                                        <td colspan="3">郵寄取票</td>
                                    </tr>
                                    <tr class="underline">
                                        <td>付款方式</td>
                                        <td colspan="3"> ATM
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <p>銀行代碼：000（XX銀行）</p>
                                                    <p>帳號：1234-XXXXX-XXXXX</p>
                                                </div>
                                            </div>
                                            銀行匯款
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <p>ＸＸ銀行ＸＸ分行</p>
                                                    <p>戶名：XX公司</p>
                                                    <p>帳號：1234-XXXXX-XXXXX</p>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="underline">
                                        <td colspan="3">取票手續費</td>
                                        <td class="text-right">NT$60</td>
                                    </tr>
                                    <tr class="total underline">
                                        <td colspan="3">總計</td>
                                        <td class="text-right">NT$2,060</td>
                                    </tr>
                                </table>

                            </div>
                        </div>

                        <!-- col-md-4 col-sm-6 col-xs-6 END -->
                    </div>
                    <!-- col-md-4 END -->


                </div>
                <!-- row END -->

            </div>
            <!-- container END -->
            <div class="tickrt-list">
                <div class="container">
                    <div class="row">
                        <div class="col-md-10 col-md-offset-1 col-sm-9 col-xs-12">
                            <div class="divide20"></div>
                            <section class="form-white-style">
                                <div class="page-header-blue">
                                    <h3>聯絡人資訊</h3>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <form class="form-horizontal form-fill">
                                            <div class="form-group">
                                                <label class="col-xs-12 control-label title">姓名</label>
                                                <label class="col-xs-12 control-label text">XXX</label>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-12 control-label title">e-mail</label>
                                                <label class="col-xs-12 control-label text">123@abc.com</label>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-12 control-label title">聯絡電話</label>
                                                <label class="col-xs-12 control-label text">0900000000</label>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </section>
                            <section class="form-white-style">
                                <div class="page-header-blue">
                                    <h3>早鳥票</h3>
                                </div>
                                <div class="row">
                                    <div class="col-md-10 col-sm-9 col-xs-8">
                                        <form class="form-horizontal form-fill text-left">
                                            <div class="form-group">
                                                <label class="col-xs-12 control-label title">報名序號</label>
                                                <label class="col-xs-12 control-label text">01</label>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-12 control-label title">票號</label>
                                                <label class="col-xs-12 control-label text">123456-01</label>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-12 control-label title">姓名</label>
                                                <label class="col-xs-12 control-label text">XXX</label>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-12 control-label title">e-mail</label>
                                                <label class="col-xs-12 control-label text">123@abc.com</label>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-12 control-label title">聯絡電話</label>
                                                <label class="col-xs-12 control-label text">0900000000</label>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="col-md-2 col-sm-3 col-xs-4">
                                        <div>
                                            <img src="images/qrcode.jpg" class="img-responsive">
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <div class="divide20"></div>
                            <!-- col-md-4 col-sm-6 col-xs-6 END -->
                        </div>
                        <!-- col-sm-12 -main-content END -->

                        <!-- col-md-8 td-main-content END -->
                    </div>
                    <!-- row END -->
                </div>
            </div>


        </div>
</asp:Content>

