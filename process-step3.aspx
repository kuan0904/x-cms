<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="process-step3.aspx.cs" Inherits="process_step3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
                <div class="row">
                    <div class="col-xs-12">
                        <article class="post-layout post">
                            <div class="post-header">
                                <div class="post-information">
                                    <h1>Step3.選擇付款方式</h1>
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
                                    <tbody>
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
                                            <td colspan="3">
                                                <form class="form-fill form-horizontal">
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup1" id="optionsRadios1" value="1" class="chk">
                                                            <span class="cr">
                                                                <i class="cr-icon fa fa-circle"></i>
                                                            </span>
                                                            電子票券
                                                        </label>
                                                    </div>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup1" id="optionsRadios2" value="2" class="chk">
                                                            <span class="cr">
                                                                <i class="cr-icon fa fa-circle"></i>
                                                            </span>
                                                            郵寄取票
                                                        </label>
                                                    </div>
                                                    <!--點選郵寄取票，才會顯示-->
                                                    <div class="panel panel-default" id="form2" style="display: none;">
                                                        <div class="panel-body">
                                                            <div class="row">
                                                                <div class="col-xs-12">
                                                                    <form class="form-ticket form-horizontal form-fill">
                                                                        <div class="form-group">
                                                                            <label class="control-label title">郵寄用費為NT$XX，僅限台灣地址,約5~7個工作天寄出。</label>
                                                                        </div>
                                                                        <div class="form-group has-error">
                                                                            <label class="control-label title">姓名</label>
                                                                            <input class="form-control">
                                                                            <label class="control-label">*錯誤訊息</label>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="control-label title">手機</label>
                                                                            <input class="form-control">
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label class="control-label title">地址</label>
                                                                            <input class="form-control">
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup1" id="optionsRadios3" value="3" class="chk"> 
                                                            <span class="cr">
                                                                <i class="cr-icon fa fa-circle"></i>
                                                            </span>
                                                            現場取票
                                                        </label>
                                                    </div>

                                                    <!--點選現場取票，才會顯示-->
                                                    <div class="panel panel-default" id="form3" style="display: none;">
                                                        <div class="panel-body">
                                                            <div class="row">
                                                                <div class="col-xs-12">
                                                                    <form class="form-ticket form-horizontal form-fill">
                                                                        <div class="form-group">
                                                                            <label class="control-label title">現場取票需出示訂單編號與身分證。</label>
                                                                        </div>
                                                                        <div class="form-group has-error">
                                                                            <label class="control-label title">身分證字號</label>
                                                                            <input class="form-control">
                                                                            <label class="control-label">*錯誤訊息</label>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </td>
                                        </tr>
                                        <tr class="underline">
                                            <td>付款方式</td>
                                            <td colspan="3">
                                                <form class="form-fill form-horizontal">
                                                    <!--此為禁用狀態範例-->
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup2" id="optionsRadios1" value="1">
                                                            <span class="cr">
                                                                    <i class="cr-icon fa fa-circle"></i>
                                                                </span>
                                                                ATM轉帳
                                                        </label>
                                                    </div>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup2" id="optionsRadios2" value="2">
                                                            <span class="cr">
                                                                    <i class="cr-icon fa fa-circle"></i>
                                                                </span>
                                                                銀行匯款
                                                        </label>
                                                    </div>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup2" id="optionsRadios3" value="3"> 
                                                            <span class="cr">
                                                                    <i class="cr-icon fa fa-circle"></i>
                                                                </span>
                                                                現場付款
                                                        </label>
                                                    </div>
                                                </form>
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
                                    </tbody>
                                </table>
                                <div class="divide10"></div>
                                <div class="text-center">
                                        <a href="process-step2.html" class="btn btn-gray margin-R-5">重填資訊
                                            </a>
                                    <a href="process-step4.html" class="btn btn-green ">確認報名
                                            <i class="fa fa-angle-right" aria-hidden="true"></i>
                                        </a>
                                </div>
                                <div class="divide20"></div>

                            </div>
                        </div>

                        <!-- col-md-4 col-sm-6 col-xs-6 END -->
                    </div>
                    <!-- col-md-4 END -->


                </div>
                <!-- row END -->

            </div>
</asp:Content>

