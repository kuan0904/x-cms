<%@ Page Language="C#" AutoEventWireup="true" CodeFile="product.aspx.cs" Inherits="product" %>

<!DOCTYPE html>
<html lang="zh-Hant-TW">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta http-equiv="content-language" content="zh-tw">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1" />
    <meta name="theme-color" content="#b483a6">
    <meta name="msapplication-navbutton-color" content="#b483a6">
    <meta name="apple-mobile-web-app-status-bar-style" content="#b483a6">
    <meta name="author" content="Xnet 智媒科技" />
    <meta name="keywords" content="<%=Session ["keywords"] %>" />
    <meta name="description" content="<%=Session ["description"] %>" />
    <meta property="fb:app_id" content="<%=Application["FacebookAppId"]%>" />
    <meta property="og:title" content="<%=Session["title"] %>" />
    <meta property="og:description" content="<%=Session ["description"] %>" />
    <meta property="og:site_name" content="<%=Application["site_name"]%>" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="<%=Request.Url.AbsoluteUri %>" />
    <meta property="og:image" content="<%=Session ["image"] %>" />
    <meta property="fb:admins" content="633770299" />
    <meta name="robots" content="index,nofollow" />
    <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
    <META HTTP-EQUIV="EXPIRES" CONTENT="0">
    <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
    <META HTTP-EQUIV="EXPIRES" CONTENT="Mon, 22 Jul 2002 11:12:01 GMT">
    <title><%=Session["title"] %></title>
    <link rel="stylesheet" href='/assets/font-awesome/css/font-awesome.min.css' />
    <link rel="stylesheet" href='/assets/bootstrap/css/bootstrap.min.css' />
    <link rel="stylesheet" href='/css/reset.css' type='text/css' />
    <link rel="stylesheet" href='/css/theme.css?v=4' type='text/css' />
    <link rel="stylesheet" href='/css/post-layout.css?v=4' type='text/css' />
    <link rel="stylesheet" href='/css/style.css?v=6' type='text/css' />
    <link rel="shortcut icon" href="/favicon.ico" />

    <!--[if lt IE 9]><script src="https://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="/lib/common.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
       <script> 
       
        var freeship =<%=freeship%>;    
        var ship_price = <%=ship_price%>;
        var packageid = <%=packageid%>;
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


            $("select[name='num']").on("change", function () {
                console.log(this + "->change");               
                //num = this.value;
                //amount = price * num;
                recalculate();
                //var j = $('ul#loc li').size();

            });
        });
        function recalculate() {
            var ship_price = '<%= ship_price%>';
             amount = 0;              
             $(".sel_ProNum").each(function (index) {               
                var num = $(this).find('select[name="num"]').val();
                var price = $(this).find('.price').html();                
               // $(this).find('#subtotal').html(num * price);                 
                 amount += num * price;
                
            });
          
            if (amount >= <%= freeship%>) ship_price = 0;
            if (amount == 0) ship_price = 0;
            var totalprice = amount + parseInt(ship_price);
            $("#amount").html(amount);
            $("#ship_price").html(ship_price);
            $("#totalprice").html(totalprice);
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
            var delivery_kind = $('input[name=delivery_kind]:checked').val();
            var num ="";
            var price = "";
            var p_id = "";
            var paymod =  $('input[name="paymod"]:checked').val();
            if (typeof (delivery_kind) == "undefined") {
                alert('請選擇送貨方式');
                flag = false;
                return false;
            }
             if (typeof (paymod) == "undefined") {
                alert('請選擇付款方式');
                flag = false;
                return false;
            }
            if (typeof (ord_sex) == "undefined") {
                alert('請選擇性別');
                flag = false;
                return false;
            }

           
            var flag = true;
            if (x1 == "") { alert('請輸入訂購人姓名'); $("#ord_name").focus(); flag = false; return false; }
            if (x2 == "") { alert('請輸入訂購人電話'); $("#ord_tel").focus(); flag = false; return false; }
            if (x3 == "") { alert('請輸入訂購人地區'); $("#ord_zip").focus(); flag = false; return false; }
            if (x31 == "") { alert('請輸入訂購人城市'); $("#p_COUNTYID").focus(); flag = false; return false; }
            if (x32 == "") { alert('請輸入訂購人地區'); $("#p_CITYID").focus(); flag = false; return false; }
            if (x33 == "") { alert('請輸入訂購人地址'); $("#p_ADDRESS").focus(); flag = false; return false; }
            x33 = $("#ord_address").val() + x33;
            if (email == "") { alert('請輸入訂購人email'); $("#email").focus(); flag = false; return false; }
            var p_id = "";

            $(".sel_ProNum").each(function (index) {
                obj = $(this).find('select[name="num"]').val();                
                if (obj != '0' && obj != undefined) {
                    p_id += $(this).find('.p_id').val() + ";";
                    num += $(this).find('select[name="num"]').val() + ";";
                    price += $(this).find('.price').html(); + ";";
                }
            });

            if ($("#totalprice").html() == '0' || num == '') {
                alert('請選擇數量');
                flag = false;
                return false;
            }

            if (flag == true) {
                if (confirm('請先詳細檢查過訂單資訊是否完整而正確!\n確定要送出訂單?')) {
                    $.post('/lib/orderdata.ashx', {
                        "packageid":packageid,
                        "ord_name": x1,
                        "ord_sex": ord_sex,
                        "ord_tel": x2,
                        "email": email,
                        "p_CITYID": x32,
                        "ord_zip": x3,
                        "p_COUNTYID": x31,
                        "delivery_kind": delivery_kind,
                        "p_ADDRESS": x33,
                        "p_id": p_id,
                        "price": price,
                        "num": num,
                        "ship_price": ship_price,
                        "paymod": paymod
                       
                      
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
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 main-content">
                    <div class="main-content-inner">
                        <article class="post-layout post">
                 
                            <div >
                              
                                <%=description  %>
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
                       
                        </div>


                            <div class="extended-reading" id="produce-list">
                                <h3 class="new-index-main-title text-center">購買方案</h3>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="divide20"></div>
                            
                                        <table class="table market-tab">
                                            <tbody>
                                                <tr>
                                                    <th width="20%">品名</th>
                                                    <th width="47%">樣式</th>
                                                    <th width="15%">價格</th>
                                                    <th width="18%">數量</th>
                                                </tr>
                                                <asp:Repeater ID="Repeater1" runat="server">
                                                    <ItemTemplate>
                                                    <tr class="sel_ProNum has-error">
                                                        <td><input type="hidden" name="p_id" class="p_id" value ="<%#Eval("p_id") %>" />
                                                            <img src="<%#Eval("pic") %>" />
                                                        </td>
                                                        <td>
                                                            <p><%#Eval("productname")%></p>
                                                            <small><%#Eval("spec")%></small>
                                                        </td>
                                                        <td >NT$<span class="price"><%#Eval("price") %></span>
                                                            <!--small>NT$原價/small-->
                                                        </td>
                                                        <td class="text-center">                                                        
                                                            <select class="form-control" name="num" >
                                                                <option value ="0">選擇數量</option>
                                                                <%for (int i = 1; i < 9; i++)
                                                                    { %>
                                                                <option><%=i %></option>
                                                                <%} %>
                                                            </select>

                                                        </td>
                                                    </tr>
                                                        </ItemTemplate>
                                                </asp:Repeater>                                              

                                            </tbody>
                                        </table>
                                        <div class="tickrt-list">                                                
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
                                                                <input name="ord_name"  id="ord_name" class="form-control" />

                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label title">* e-mail</label>
                                                                <input name="email"  id="email" value="" class="form-control" />
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label title">* 聯絡電話</label>
                                                                <input name="ord_tel"  id="ord_tel" value="" class="form-control" />
                                                            </div>
                                                            <div class="form-group has-error">
                                                                <label class="control-label title">郵遞區號</label>


                                                                <input  size="6" readonly id="p_ZIP" name="p_ZIP" />
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
                                                                <input id="p_ADDRESS"  name="p_ADDRESS" class="form-control" />
                                                                <input name="ord_address" type="hidden" id="ord_address" value="" class="form-control" />
                                                            </div>
                                                        </div>

                                                    </div>
                                                </section>
                                        </div>
                                        
                                    </div>
                                </div>

                            </div>
            

                    </article>
                        
                    <!-- post-header END -->

                                        <div class="block-wrap border">
                                            <div class="block-title" style="width:90%">付款方式</div>
                                            <div class="block-body">
                                                 <div class="radio">
                                                     <!--
                                                    <label>
                                                    <input type="radio" name="paymod" value="1"  /> <span class="cr">
                                                    <i class="cr-icon fa fa-circle"></i>
                                                    </span>信用卡 VISA MasterCard
                                                    </label>
                                               -->
                                                    <label>
                                                    <input type="radio" name="paymod" value="2"  /> <span class="cr">
                                                     <i class="cr-icon fa fa-circle"></i>
                                                        </span>ATM 轉帳繳費
                                                    </label>
                                                    </div>



                                            </div>
                                               <div class="block-title" style="width:90%">送貨方式 </div>
                                              <div class="block-body">
                                                <div class="radio">
                                                    <label>
                                                  <input type="radio" name="delivery_kind" value="<%=shippingKind  %>" checked  />
                                                    <span class="cr">
                                                    <i class="cr-icon fa fa-circle"></i>
                                                    </span> <%=OrderLib.getdelivery_kind (shippingKind)  %>
                                                    </label>
                                                </div>
                                                </div>
                                            </div>
                                        </div>
                                    
                                        <div class="text-center">
                                            <!--a連結class新增disabled即可禁用，按鈕方式則為disabled="disabled"-->
                                            <a href="#" onclick ="chkform();" class="btn btn-pink btn-block btn-lg">
                                                <i class="fa fa-shopping-basket" aria-hidden="true"></i>
                                                我要購買
                                            </a>
                                        </div>

                    <!-- block-wrap END -->
                    <div class="block-wrap border">
                         <div class="block-title" style="width:90%">注意事項</div>
                        <div class="block-body">
                              <%= ReMark %>


                        </div>
                    </div>

                    <!-- block-wrap END -->
                    <div class="block-wrap border">
                         <div class="block-title" style="width:90%">退換貨規則</div>
                        <div class="block-body">
                           <%= Refunds %>
                        </div>
                    </div>
                    <!-- block-wrap END -->
                         <div class="row">
            
                            <p><span style="font-size:1.8em;"><span style="font-family:微軟正黑體;"><strong><span style="background-color:#ff8c00;">　　</span><span style="color:#ffffff;"><span style="background-color:#ff8c00;">客服資訊</span></span><span style="background-color:#ff8c00;">　　</span></strong></span></span></p>
                            <%=s.Contents  %>
    
                        </div>
                    </div>
                </div>  
        
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


        
 <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=<%=Application["gaid"] %>"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', '<%=Application["gaid"] %>');
</script>
        <script id='xn'    ci='culturelaunch'  src='http://xa.xnet.world/xn.js'></script>

    </form>
</body>
</html>
