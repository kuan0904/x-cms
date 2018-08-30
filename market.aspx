<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="market.aspx.cs" Inherits="market" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <script> 
        var pid ='<%=p_id%>';
        var p_id = '<%=p_id%>';
        var price = '<%=price%>';
        var ship_price = '<%=ship_price%>';
        var amount = 0;
        function validEmail(v) {
            if (v.indexOf(' ') != -1) {
                alert('email不可以有空白符號');
                return false;
            }
            if (v.indexOf(',') != -1) {
                alert('email不可以有","符號');
                return false;
            }
            var r = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
            return (v.match(r) == null) ? false : true;
        }

        $(document).ready(function () {
            $('img').each(function () {
                $(this).removeAttr('style')
            });
            getCounty();
            $("#p_COUNTYID").change(function () {
                if ($(this).val() != "") {
                    getCity($(this).val(), '#p_CITYID');
                    if (p_CITYID != "") {
                        $("#p_CITYID").find("option[value='" + p_CITYID + '-' + p_ZIP + "']").prop("selected", true);
                        $("#p_CITYID").trigger("change");
                    }
                } else {
                    $("#p_CITYID").find("option").remove();
                    $("#p_ZIP").val('');
                }
                $("#ord_address").val($("#p_COUNTYID option:selected").text() + $("#p_CITYID option:selected").text() + $("#p_ADDRESS").val());

            });
            $("#p_CITYID").change(function () {
                if (($(this).val() != "") && ($(this).val() != null)) {
                    var p_ZIP = $(this).val().split('-')[1];
                    $("#p_ZIP").val(p_ZIP);
                    $("#ord_zip").val(p_ZIP);

                } else {
                    $("#p_ZIP").val('');
                }
                $("#ord_address").val($("#p_COUNTYID option:selected").text() + $("#p_CITYID option:selected").text() + $("#p_ADDRESS").val());

            });

            $('.kindid input[type=checkbox]').click(function () {
                // code goes here 
                alert('123');
            });

            $("#num").change(function () {
                num = $("#num").val();
                amount = price * num;
                recalculate();
                var j = $('ul#loc li').size();

            });
            $("#num").trigger("change");
            $(".sel_ProNum").each(function (index) {
                $("#nogroup").hide();
                amount = 0;
                ship_price = 0;
                recalculate();
            });
        });
        function num_change(obj, p_id) {
            num = obj.value;
            amount = 0;
            $(".sel_ProNum").each(function (index) {
                var num = $(this).find('select[name="p_num"]').val();
                var price = $(this).find('#price').html();

                $(this).find('#subtotal').html(num * price);
                amount += num * price;
            });
            recalculate();
        }

        function recalculate() {
            var ship_price ='<%= ship_price%>';
            if (amount >= <%= freeship%>) ship_price = 0;
            if (amount == 0) ship_price = 0;
            var totalprice = amount + parseInt(ship_price);
            $("#amount").html(amount);
            $("#ship_price").html(ship_price);
            $("#totalprice").html(totalprice);
        }


        function getCity(COUNTYID, obj) {
            if (COUNTYID != null) {
                $.post('/lib/city.ashx', { "p_COUNTYID": COUNTYID, "_": new Date().getTime() }, function (data) {
                    if (data != "") {
                        $(obj).find("option").remove();
                        $(obj).html(data);
                    }
                });
            }
        }

        function getCounty() {
            $.post('/lib/county.ashx', { "_": new Date().getTime() }, function (data) {
                if (data != "") {
                    $("#p_COUNTYID").find("option").remove();
                    $("#p_COUNTYID").html(data);
                }
            });
        }




        function padLeft(str, lenght) {
            if (str.length >= lenght)
                return str;
            else
                return padLeft("0" + str, lenght);
        }


        function chkform() {
            var x1 = $("#ord_name").val();
            var x2 = $("#ord_tel").val();
            var x21 = $("#ord_mobile").val();
            var x3 = $("#ord_zip").val();
            var x31 = $("#p_COUNTYID").val();
            var x32 = $("#p_CITYID").val();
            var x33 = $("#p_ADDRESS").val();
            var x61 = x31;
            var email = $("#email").val();
            var ord_sex = $('input[name="ord_sex"]:checked').val();
            var ord_pay = $('input[name=ord_pay]:checked').val();
            var num = $("#num").val();

            if (typeof (ord_pay) == "undefined") {
                alert('請選擇付款方式');
                flag = false;
                return false;
            }
            if (typeof (ord_sex) == "undefined") {
                alert('請選擇性別');
                flag = false;
                return false;
            }

            var price = $("#price").html();
            var flag = true;
            if (x1 == "") { alert('請輸入訂購人姓名'); $("#ord_name").focus(); flag = false; return false; }
            if (x2 == "") { alert('請輸入訂購人電話'); $("#ord_tel").focus(); flag = false; return false; }
            if (x3 == "") { alert('請輸入訂購人地區'); $("#ord_zip").focus(); flag = false; return false; }
            if (x31 == "") { alert('請輸入訂購人城市'); $("#p_COUNTYID").focus(); flag = false; return false; }
            if (x32 == "") { alert('請輸入訂購人地區'); $("#p_CITYID").focus(); flag = false; return false; }
            if (x33 == "") { alert('請輸入訂購人地址'); $("#p_ADDRESS").focus(); flag = false; return false; }
            x33 = $("#ord_address").val() + x33;

            if (email == "") { alert('請輸入訂購人email'); $("#email").focus(); flag = false; return false; }

            if ($(".sel_ProNum").length != 0) {
                p_id = "";
                num = "";
                price = "";
            }

            $(".sel_ProNum").each(function (index) {
                if ($(this).find('select[name="p_num"]').val() != '0') {
                    p_id += $(this).find('#p_id').val() + ";";
                    num += $(this).find('select[name="p_num"]').val() + ";";
                    price += $(this).find('#price').html(); + ";";
                }
            });
            if ($("#totalprice").html() == '0' || $("#totalprice").html() == '') {
                alert('請選擇數量');
                flag = false;
                return false;
            }

            if (flag == true) {
                if (confirm('請先詳細檢查過訂單資訊是否完整而正確!\n確定要送出訂單?')) {
                    $.post('/lib/orderdata.ashx', { "ord_name": x1, "ord_sex": ord_sex, "ord_tel": x2, "email": email, "p_CITYID": x32, "ord_zip": x3, "p_COUNTYID": x31, "ord_pay": ord_pay, "p_ADDRESS": x33, "p_id": p_id, "price": price, "num": num, "ship_price": ship_price, "pid": pid }, function (data) {

                        if (data == '-1') {
                            alert('產品銷售完畢');
                        }
                        else if (data == '1') {
                            location.href = '/pay.aspx';
                        }
                    });
                }
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="main-content">

            <div class="breadArea">
                <div class="container">
                    <ol class="breadcrumb">
                        <li>
                            <a href="/index">HOME</a>
                        </li>
                        <li>商城</li>
                        <li class="active"><%=productname%></li>
                    </ol>
                </div>
            </div>
            <!-- breadArea END -->

            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-sm-12 col-xs-12 main-content">
                        <div class="main-content-inner">
                            <article class="post-layout post">
                                <div class="post-header">
                                    <div class="post-featured-image">
                                        <a href="market.html">
                                            <img class="image-full modal-image size-full" src="<%=pic1%>" width="1350" height="900" />
                                        </a>
                                    </div>



                                    <!-- meta-info END -->
                                </div>
                                <!-- post-header END -->

                                <div class="post-content">
                                    <h2 class="text-danger"><%=productname%></h2>
                                 <%=description  %>

                                </div>
                                <div class="divide40"></div>
                                <div class="extended-reading" id="produce-list">
                                    <h3 class="new-index-main-title text-center">購買方案</h3>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="divide20"></div>
                                            <!--票券詳細資訊-->
                                            <table class="table market-tab">
                                                <tbody>
                                                    <tr>
                                                        <th width="20%">品名</th>
                                                        <th width="47%">樣式</th>
                                                        <th width="15%">價格</th>
                                                        <th width="18%">數量</th>
                                                    </tr>
                                                    <tr class="has-error">
                                                        <td>
                                                            <img src="images/01.jpg" />
                                                        </td>
                                                        <td>
                                                            <p>【活動限定】便攜旋轉萃取咖啡機-礦石黑（贈：安內咖啡粉）</p>
                                                            <small>119 x 101 x 120 mm</small>
                                                        </td>
                                                        <td class="price">
                                                            NT$999
                                                            <small>NT$1,200</small>
                                                        </td>
                                                        <td class="text-center">
                                                            <!--清單最大值為剛票券數量上限-->
                                                            <select class="form-control">
                                                                <option>選擇數量</option>
                                                                <option>99</option>
                                                            </select>

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <img src="images/02.jpg" />
                                                        </td>
                                                        <td>
                                                            【活動限定】便攜旋轉萃取咖啡機-莧紅色（贈：安內咖啡粉）
                                                        </td>
                                                        <td class="price">
                                                            NT$999
                                                            <small>NT$1,200</small>
                                                        </td>
                                                        <td class="text-center">
                                                            <!--清單最大值為剛票券數量上限-->
                                                            <select class="form-control">
                                                                <option>選擇數量</option>
                                                                <option>99</option>
                                                            </select>

                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <div class="divide10"></div>
                                            <div class="text-center">
                                                <!--a連結class新增disabled即可禁用，按鈕方式則為disabled="disabled"-->
                                                <a href="process-step1.html" class="btn btn-pink btn-block btn-lg">
                                                    <i class="fa fa-shopping-basket" aria-hidden="true"></i>
                                                    我要購買
                                                </a>
                                            </div>

                                            <div class="divide10"></div>
                                        </div>
                                    </div>

                                    <!-- news-list END -->
                                </div>
                                <!-- post-footer END -->

                            </article>

                        </div>
                        <!-- main-content-inner END -->

                    </div>
                    <!-- col-md-8 td-main-content END -->

                    <div class="col-md-4 col-sm-12 col-xs-12 main-sidebar">
                        <article class="post-layout post">
                            <div class="post-header">
                                <div class="post-information">
                                    <h1 style="padding-bottom: 1rem;"><%=productname  %></h1>
                                    <div class="post-description">
                                     
                                        <%=MEMO %>
                                    </div>
                                    <div class="meta-info">
                                        <div class="social-media-share-btn">
                                            <a href="#" class="share-fb">
                                                <i class="fa fa-2x fa-facebook-official" aria-hidden="true"></i>
                                            </a>
                                            <a href="#" class="share-google">
                                                <i class="fa fa-2x fa-google-plus-square" aria-hidden="true"></i>
                                            </a>
                                            <a href="#" class="share-twitter">
                                                <i class="fa fa-2x fa-twitter" aria-hidden="true"></i>
                                            </a>
                                            <a href="#" class="share-print">
                                                <i class="fa fa-2x fa-print" aria-hidden="true"></i>
                                            </a>
                                        </div>
                                        <div class="divide20"></div>
                                        <a href="#produce-list" class="btn btn-pink btn-block">
                                            <i class="fa fa-shopping-basket" aria-hidden="true"></i> 我要購買
                                        </a>
                                    </div>
                                    <!-- post-description END -->
                                </div>
                                <!-- post-information END -->
                            </div>
                        </article>

                        <div class="row">
                            <div class="col-xs-12">
                                <!-- post-header END -->
                                <div class="block-wrap border">
                                    <div class="block-title">付款方式</div>
                                    <div class="block-body">
                                        信用卡 VISA MasterCard ATM 轉帳繳費
                                    </div>
                                </div>

                                <!-- block-wrap END -->
                                <div class="block-wrap border">
                                    <div class=block-title>注意事項</div>
                                    <div class="block-body">
                                        1.全商品採用宅配方式寄送，限台灣本島。
                                        <br/> 2.即日起下單付款者，將於確認結帳後3～5個工作天內出貨，寄至所填寫的收件地址，如遇假日則順延出貨。
                                    </div>
                                </div>

                                <!-- block-wrap END -->
                                <div class="block-wrap border">
                                    <div class=block-title>退換貨規則</div>
                                    <div class="block-body">
                                        商品提供七天的猶豫權益（非試用期），若要辦理退換貨，貨品須為全新未使用且包裝完整。
                                    </div>
                                </div>
                                <!-- block-wrap END -->
                            </div>
                        </div>



                        <!-- main-sidebar-inner END -->
                    </div>
                    <!-- col-md-4 END -->


                </div>
                <!-- row END -->

            </div>
            <!-- container END -->

        </div>

</asp:Content>

