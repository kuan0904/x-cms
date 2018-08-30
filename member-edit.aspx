<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="member-edit.aspx.cs" Inherits="member_edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <script>
      
        var result =<%=result%>;
        var countyid = "<%=countyid %>";
        var zip = "<%=zip%>";
        var cityid = "<%=cityid%>";
        var memberid = result.memberid;
        $(document).ready(function () {        
            getCounty();
            getCity(countyid);
            $("#btnUpdate").click(function () {
                var username = $("#username").val();                        
                countyid = $("#countyid").val();
                var phone = $("#phone").val();
                var mobile = $("#mobile").val();
                cityid = $("#cityid").val();
                var password = $("#password").val();
                var passconfirm = $("#passconfirm").val();
                var address = $("#address").val();
                var birthday = $("#birthday").val();
              
                if (cityid != "" && cityid != null) {
                    zip = cityid.split('-')[1];
                    cityid = cityid.split('-')[0];
                }                       
               if (username == "") {
                    alert("請輸入姓名");
                    $("#username").focus();
                } else if (password == "") {
                    alert("請輸入密碼");
                    $("#password").focus();
                } else if (password.length < 6 || password.length > 16) {
                    alert("請輸入英數6-16字元");
                    $("#password").focus();
                }
                else if (password != passconfirm) {
                    alert("密碼與確認密碼不同");
                    $("#passconfirm").focus();              
                } else if (phone == "") {
                    alert("請輸入行動電話");
                    $("#phone").focus();
                } else if (birthday == "") {
                    alert("請輸入生日");
                    $("#birthday").focus();
                } else if ((cityid == "") || (countyid == "") || (address == "")) {
                    alert("請輸入地址");
                    $("#address").focus();
                } else {
                
                    $.post('/lib/member_handle.ashx', {
                        "p_ACTION": "Update",
                        "username": username,
                        "mobile": mobile,                 
                        "phone": phone,
                        "cityid": cityid,
                        "countyid": countyid,
                        "zip": zip,
                        "address": address,
                        "password": password,
                        "birthday": birthday,
                        "_": new Date().getTime()
                    }, function (data) {
                        if (data == "0") {
                            alert("error");
                        } else if (data == "1") {
                            alert("您的資料已經完成修改，感謝您的使用!");
                            var page = GetURLParameter("page");
                            if (page !== undefined) {
                                var s = base64_decode(page);
                                if (s.indexOf('?') != -1) s += "&=_" + new Date().getTime().toString();
                                else s = page + "?=_" + new Date().getTime().toString();
                                location.href = s;
                            }
                            else
                                location.href = 'index.aspx';
                        }

                    }
                    );
                }
            });
            $("#countyid").change(function () {             
                if ($(this).val() != "") {
                    getCity($(this).val());
                    if (cityid != "") {
                        $("#cityid").find("option[value='" + cityid  + '-' + zip + "']").prop("selected", true);
                        $("#cityid").trigger("change");
                    }
                } else {
                    $("#cityid").find("option").remove();
                }
             
            });
            $("#cityid").change(function () {
                if (($(this).val() != "") && ($(this).val() != null)) {
                    var zip = $(this).val().split('-')[1];
                    $("#zip").val(zip);
                } else {
                    $("#zip").val('');
                }
            });             
        });

      

           function getCity(p_COUNTYID) {   
               
            if (p_COUNTYID != null && p_COUNTYID !="" ) {
                $.post('/lib/city.ashx', { "p_COUNTYID": p_COUNTYID, "_": new Date().getTime() }, function (data) {
                    if (data != "") {
                        $("#cityid").find("option").remove();
                        $("#cityid").html(data);
                        $('#cityid').find('option[value="' + cityid + "-" + zip + '"]').prop("selected", true);
                    }
                });
            }
           
        }
    
        function getCounty() {
            $.post('/lib/county.ashx', { "_": new Date().getTime() }, function (data) {
                if (data != "") {
                    $("#countyid").find("option").remove();
                    $("#countyid").html(data);
                    $('#countyid').find('option[value="' + countyid + '"]').prop("selected", true);
                }
            });
        }

 
        function init() {
          
                $('#countyid').find('option[value="' + countyid + '"]').prop("selected", true);
                $('#cityid').find('option[value="' + cityid + "-" + zip + '"]').prop("selected", true);
                $("#username").val('');
                $("#countyid").val('');
                $("#phone").val('');
                $("#mobile").val('');
                $("#zip").val('');
                $("#birthday").val('');
                $("#password").val('');
                $("#passconfirm").val('');
                $("#address").val('');
        
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="main-content">

            <div class="breadArea">
                <div class="container">
                    <ol class="breadcrumb">
                        <li>
                            <a href="hp.html">HOME</a>
                        </li>
                        <li class="active">會員中心</li>
                        <li class="active">個人資料修改</li>
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
                                            <a href="member-order.html">查詢訂單</a>
                                        </h4>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingTwo">
                                        <h4 class="panel-title">
                                            <a href="member-collection.html">我的收藏</a>
                                        </h4>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="headingThree">
                                        <h4 class="panel-title">
                                            <a class=" active" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="true"
                                                aria-controls="collapseThree">
                                                會員設定
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapseThree" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingThree">
                                        <ul class="list-group">
                                            <a href="/member-edit" class="list-group-item active">修改個人資料</a>
                                            <a href="member-password.html" class="list-group-item">變更密碼</a>
                                        </ul>
                                    </div>
                                </div>
                                <!--關閉狀態-aria-expanded="false"-class="panel-collapse collapse"-->
                            </div>
                        </div>
                    </div>
                    <div class="col-md-10 col-sm-9 col-xs-12">
                        <article class="post-layout post">
                            <div class="post-header">
                                <div class="post-information">
                                    <h1>修改個人資料</h1>
                                </div>
                                <!-- post-information END -->
                            </div>
                            <!-- post-header END -->
                        </article>
                        <form class="form-member">
                            <!--Default-->
                            <div class="form-group">
                                <label for="">姓名
                                    <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="username" value ="<%=username %>" placeholder="請輸入姓名">
                            </div>
                             <div class="form-group">
                                    <label for="">電子信箱</label>
                                    <br />  
                                    <label for=""> <%=email  %>  </label>
                                </div>        
                                           <div class="form-group">
                                    <label for="exampleInputPassword1">行動電話</label>                               
                                        <input name="mobile" type="text" id="mobile" placeholder="輸入行動電話"  value ="<%=mobile %>"  class="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">連絡電話</label>
                                      <input name="phone" type="text" id="phone" placeholder="輸入連絡電話"  value ="<%=phone %>"  class="form-control" />
                             
                                </div>    
                                      <div class="form-group">
                                    <label for="">生日</label>
                                      <input name="birthday" type="date"  id="birthday"  value ="<%=birthday %>"  class="form-control" />
                             
                                </div>                         
                                <div class="form-group">
                                    <label for="">收件地址</label>
                                   
                                           <input name="zip" type="text" id="zip" placeholder="郵遞區號"  size="6" readonly class="form-control"  value ="<%=zip %>"/>
                    <select   name="countyid" id="countyid" class="form-control">
                    
					</select>
                    <select class="form-control" id="cityid" name="cityid" >  
                    <option>鄉鎮市區</option>                 
					</select>
         <input type="text" class="form-control" id="address" placeholder="地址" value ="<%=address %>" />
                          
                                        
                                    </div>
                                 <div class="form-group">
                                    <label for="exampleInputPassword1">修改密碼</label>
                                       <input name="password" type="password" id="password"  class="form-control" placeholder="密碼"   value ="<%=password%>" />                                              
                                    <p>(英數字元，需6字以上)</p>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">確認密碼</label>
                                         <input name="passconfirm" type="password" id="passconfirm" class="form-control" placeholder="再次輸入密碼"   value ="<%=password%>" />               
                                </div> 
                            <!--error-->
                            <div class="form-group has-error">
                                <label for="">error示範
                                    <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="" placeholder="">
                                <span id="helpBlock" class="help-block">當資料輸入錯誤時樣式</span>
                            </div>
                            <div class="form-group">
                                <hr>
                            </div>
                            <!-- Default checkbox -->
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="">
                                    <span class="cr">
                                        <i class="cr-icon glyphicon glyphicon-ok"></i>
                                    </span>
                                    Option one
                                </label>
                            </div>

                            <!-- Checked checkbox -->
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="" checked>
                                    <span class="cr">
                                        <i class="cr-icon glyphicon glyphicon-ok"></i>
                                    </span>
                                    Option two is checked by default
                                </label>
                            </div>

                            <!-- Disabled checkbox -->
                            <div class="checkbox disabled">
                                <label>
                                    <input type="checkbox" value="" disabled>
                                    <span class="cr">
                                        <i class="cr-icon glyphicon glyphicon-ok"></i>
                                    </span>
                                    Option three is disabled
                                </label>
                            </div>
                            <div class="form-group">
                                <hr>
                            </div>
                            <!-- Default radio -->
                            <div class="radio ">
                                <label>
                                    <input type="radio" name="o3" value="">
                                    <span class="cr">
                                        <i class="cr-icon fa fa-circle"></i>
                                    </span>
                                    Option one
                                </label>
                            </div>

                            <!-- Checked radio -->
                            <div class="radio">
                                <label>
                                    <input type="radio" name="o3" value="" checked>
                                    <span class="cr">
                                        <i class="cr-icon fa fa-circle"></i>
                                    </span>
                                    Option two is checked by default
                                </label>
                            </div>

                            <!-- Disabled radio -->
                            <div class="radio disabled">
                                <label>
                                    <input type="radio" name="o3" value="" disabled>
                                    <span class="cr">
                                        <i class="cr-icon fa fa-circle"></i>
                                    </span>
                                    Option three is disabled
                                </label>
                            </div>
                            <div class="form-group">
                                <hr>
                            </div>
                     
                            <div class="form-group">
                                <textarea class="form-control" rows="3"></textarea>
                            </div>
                            <button type="button" id="btnUpdate" class="btn btn-green btn-lg btn-block">儲存個人資料</button>
                        </form>

                    </div>
                    <!-- col-sm-12 -main-content END -->

                    <!-- col-md-8 td-main-content END -->
                </div>
                <!-- row END -->
            </div>
            <!-- container END -->
        </div>
</asp:Content>

