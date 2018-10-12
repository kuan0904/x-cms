<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="market.aspx.cs" Inherits="market" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                alert('請選擇送貨方式方式');
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
                    $.post('/lib/orderdata.ashx', {
                        "ord_name": x1,
                        "ord_sex": ord_sex,
                        "ord_tel": x2,
                        "email": email,
                        "p_CITYID": x32,
                        "ord_zip": x3,
                        "p_COUNTYID": x31,
                        "ord_pay": ord_pay,
                        "p_ADDRESS": x33,
                        "p_id": p_id,
                        "price": price,
                        "num": num,
                        "ship_price": ship_price,
                        "pid": pid
                      
                    }, function (data) {

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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                                                        <img src="<%=pic1 %>" />
                                                    </td>
                                                    <td>
                                                        <p><%=productname %></p>
                                                        <small>119 x 101 x 120 mm</small>
                                                    </td>
                                                    <td class="price">NT$<%=price %>
                                                        <!--small>NT$<%=price %></small-->
                                                    </td>
                                                    <td class="text-center">
                                                        <!--清單最大值為剛票券數量上限-->
                                                        <select class="form-control" id="num">
                                                            <option>選擇數量</option>
                                                            <%for (int i = 1; i < 9; i++)
                                                                { %>
                                                            <option><%=i %></option>
                                                            <%} %>
                                                        </select>

                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>
                                            <div class="tickrt-list">
                                                  <div class="divide20"></div>
                                                 <section class="form-white-style">
                                                       <div class="page-header-blue">
                                                        <h3>訂單資料</h3>
                                                    </div>
                                                         <div class="row">
                                                               <div class="form-group">
                                                                  <h4>商品總額
                                                                   <small>$</small><span id="amount">0 </span></h4>
                                                                <h4>運費 <small>$</small><span id="ship_price"><%= ship_price  %></span></h4>
                                                                <h4>應付金額 <small>$</small><span id="totalprice"> <%=amount %></span></h4>
                                                            </div>
                                                           </div>
                                                 </section>
                                            </div> 
                                        <div class="tickrt-list">
                                                <div class="divide20"></div>
                                                <section class="form-white-style">
                                                    <div class="page-header-blue">
                                                        <h3>購買人資料</h3>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-12">
                                                          
                                                            <div class="form-group">
                                                                <label class="control-label title">性　　別</label>
                                                                <div class="radio ">
                                                                    <label>
                                                                        <input type="radio" name="ord_sex" value="男">
                                                                        <span class="cr">
                                                                            <i class="cr-icon fa fa-circle"></i>
                                                                        </span>
                                                                        男
                                                                    </label>
                                                                </div>
                                                                <div class="radio ">
                                                                    <label>
                                                                        <input type="radio" name="ord_sex" value="女">
                                                                        <span class="cr">
                                                                            <i class="cr-icon fa fa-circle"></i>
                                                                        </span>
                                                                        女
                                                                    </label>
                                                                </div>



                                                            </div>
                                                            <div class="form-group has-error">
                                                                <label class="control-label title">* 姓名</label>
                                                                <input name="ord_name" type="text" id="ord_name" class="form-control" />

                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label title">* e-mail</label>
                                                                <input name="email" type="text" id="email" value="" class="form-control" />
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label title">* 聯絡電話</label>
                                                                <input name="ord_tel" type="text" id="ord_tel" value="" class="form-control" />
                                                            </div>
                                                            <div class="form-group has-error">
                                                                <label class="control-label title">郵遞區號</label>


                                                                <input type="text" size="6" readonly id="p_ZIP" name="p_ZIP" />
                                                                <input name="ord_zip" type="hidden" id="ord_zip" value="" />
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label title">縣市</label>
                                                                <select id="p_COUNTYID" name="p_COUNTYID" class="form-control">
                                                                    <option value="">請選擇</option>
                                                                    <option value="1">台北市</option>
                                                                    <option value="2">新北市</option>
                                                                    <option value="3">基隆市</option>
                                                                    <option value="4">桃園市</option>
                                                                    <option value="5">苗栗縣</option>
                                                                    <option value="6">新竹縣</option>
                                                                    <option value="7">新竹市</option>
                                                                    <option value="8">台中市</option>
                                                                    <option value="10">彰化縣</option>
                                                                    <option value="11">嘉義市</option>
                                                                    <option value="12">嘉義縣</option>
                                                                    <option value="13">雲林縣</option>
                                                                    <option value="14">台南市</option>
                                                                    <option value="16">高雄市</option>
                                                                    <option value="18">屏東縣</option>
                                                                    <option value="19">台東縣</option>
                                                                    <option value="20">花蓮縣</option>
                                                                    <option value="21">宜蘭縣</option>
                                                                    <option value="22">南投縣</option>
                                                                    <option value="23">南海島</option>
                                                                    <option value="24">金門縣</option>
                                                                    <option value="25">連江縣</option>
                                                                    <option value="26">釣魚台</option>
                                                                    <option value="27">澎湖縣</option>
                                                                    <option value="28">其他</option>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label title">地區 </label>


                                                                <select id="p_CITYID" name="p_CITYID" class="form-control"></select>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label title">詳細地址</label>
                                                                <input id="p_ADDRESS" type="text" name="p_ADDRESS" class="form-control" />
                                                                <input name="ord_address" type="hidden" id="ord_address" value="" class="form-control" />
                                                            </div>
                                                        </div>

                                                    </div>
                                                </section>
                                        </div>
                                        <div class="form-group">
                                            送貨方式 
					  <input type="radio" name="ord_pay" value="<%=shippingKind  %>" checked  />
                                            <%=OrderLib.getdelivery_kind (shippingKind)  %>
                                        </div>



                                        <div class="divide10"></div>
                                        <div class="text-center">
                                            <!--a連結class新增disabled即可禁用，按鈕方式則為disabled="disabled"-->
                                            <a href="#" onclick ="chkform();" class="btn btn-pink btn-block btn-lg">
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
                                <i class="fa fa-shopping-basket" aria-hidden="true"></i>我要購買
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
                        <div class="block-title">注意事項</div>
                        <div class="block-body">
                            1.全商品採用宅配方式寄送，限台灣本島。
                                        <br />
                            2.即日起下單付款者，將於確認結帳後3～5個工作天內出貨，寄至所填寫的收件地址，如遇假日則順延出貨。
                        </div>
                    </div>

                    <!-- block-wrap END -->
                    <div class="block-wrap border">
                        <div class="block-title">退換貨規則</div>
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
        <script>  
           
         $(document).ready(function () {  
              //分享至臉書
	        $(".share-fb").click(function () {
	        window.open('https://www.facebook.com/share.php?u='.concat(encodeURIComponent(location.href)), "_blank", "toolbar=yes,location=yes, directories=no, status=no,menubar=yes,scrollbars=yes,esizable=no, copyhistory=yes, width=600,  height=400")
            })
            $(".share-twitter").click(function () {
                text=   $(document).find("title").text();
	            window.open('https://twitter.com/share?text='+ text +'&url='.concat(encodeURIComponent(location.href)), "_blank", "toolbar=yes,location=yes, directories=no, status=no,menubar=yes,scrollbars=yes,esizable=no, copyhistory=yes, width=600,  height=400")
            })
            $(".share-google").click(function () {
	            window.open('https://plus.google.com/share?url='.concat(encodeURIComponent(location.href)), "_blank", "toolbar=yes,location=yes, directories=no, status=no,menubar=yes,scrollbars=yes,esizable=no, copyhistory=yes, width=600,  height=400")
            })

            $(".share-print").click(function () {
                window.print();
            })
       
    });



    </script>
</asp:Content>

