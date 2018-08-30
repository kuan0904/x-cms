<%@ Page Language="C#" AutoEventWireup="true" CodeFile="shoppingcart.aspx.cs" Inherits="shoppingcart" MasterPageFile="~/MasterPage.master" %>

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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <div class="main-content">

            <div class="breadArea">
            </div>
            <!-- breadArea END -->

            <div class="container">
                <div class="col-md-10 col-sm-9 col-xs-12">
                    <article class="post-layout post">
                        <div class="post-header">
                            <div class="post-information">
                                <h1><%=productname%></h1>
                                <%=pic1%>
                            </div>
                            <!-- post-information END -->
                        </div>
                        <!-- post-header END -->
                    </article>




                    <div class="form-group">
                        <h5>品號:  <%=productcode %>  </h5>
                        <h5>【產品介紹】</h5>
                        <%=DESCRIPTION %>
                        <h5>【備註說明】</h5>
                        <%=MEMO %>
                    </div>

                    <div class="form-group">
                        <label for="">
                            數 量
						
							<select id="num" class="form-control">
                                <%
                                  for ( int i= 1; i <= stocknum ;i++) {  %>
                                <option><%=i %></option>
                                <%} %>
                            </select>
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="">
                            商品金額
						<small>$</small><span id="price"><%=price %></span>
                        </label>
                    </div>

                    <div class="form-group">
                        <asp:Repeater ID="Repeater1" runat="server">



                            <HeaderTemplate>
                                <table class="form-group">
                                    <thead>
                                        <tr>
                                            <th>產品名</th>
                                            <th>單價</th>
                                            <th>數量</th>
                                            <th>金額</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <FooterTemplate>
                                </tbody>
                </table>
                            </FooterTemplate>
                            <ItemTemplate>
                                <tr class="sel_ProNum">
                                    <td><%#Eval("productname") %></td>
                                    <td>$<span id="price"><%#Eval("price") %></span> </td>
                                    <td>
                                        <select id="p_num" name="p_num" onchange="num_change(this,'<%#Eval("p_id") %>')" class="form-control">
                                            <option>0</option>
                                            <%
                                                for (int i = 0; i <= stocknum; i++)
                                                {  %>
                                            <option><%=i %></option>
                                            <%} %>
                                        </select></td>
                                    <td>
                                        <input id="p_id" type="hidden" value="<%#Eval("p_id") %>" />
                                        金額:
                                    $ <span id="subtotal">0</span></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div class="form-group">
                        
                            送貨方式 
					  <input type="radio" name="ord_pay" value="cash" checked="checked" />
                            <%=shippingKind  %>
                       


                    </div>


                    <div class="form-group">
                        <p>商品總額 <small>$</small><span id="amount"> </span></p>
                        <p>運費 <small>$</small><span id="ship_price"><%= ship_price  %></span></p>
                        <p class="text-red border-top">應付金額 <small>$</small><span id="totalprice"> <%=amount %></span></p>
                    </div>
                    <h4>購買人資料</h4>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓 名</label>
                       
                            <input name="ord_name" type="text" id="ord_name" class="form-control" />
                    
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性　　別</label>
                      
                            <label class="radio-inline">
                                <input type="radio" name="ord_sex" value="男">男</label>
                            <label class="radio-inline">
                                <input type="radio" value="女" name="ord_sex">女</label>
                     
                    </div>
                    <div class="form-group">
                        手機號碼 
							<input name="ord_tel" type="text" id="ord_tel" value="" class="form-control" />
                       
                    </div>
                    <div class="form-group">
                         email   
                           
							<input name="email" type="text" id="email" value="" class="form-control" />
                       
                    </div>

                    <div class="form-group">
                        
                            地址
                          
                            郵遞區號
						 
							<input type="text" size="6" readonly id="p_ZIP" name="p_ZIP" />
                            <input name="ord_zip" type="hidden" id="ord_zip" value="" />
                      
							縣市 
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
                             地區 
                            <select id="p_CITYID" name="p_CITYID" class="form-control"></select>
                            <input id="p_ADDRESS" type="text" name="p_ADDRESS" class="form-control" />
                            <input name="ord_address" type="hidden" id="ord_address" value="" class="form-control" />
                       
                    </div>
               
                    <div class="form-group">
                        <h4 id="usd">使用者資料</h4>

                        <ul id="loc">
                        </ul>

                        <button type="button" onclick="return chkform();" class="btn btn-primary btn-block">確認下單</button>

                    </div>


                </div>
            </div>


            <span id="msg"></span>

        </div>



</asp:Content>
