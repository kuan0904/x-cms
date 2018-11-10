<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="member-edit.aspx.cs" Inherits="member_edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <script>
    var m = <%=result%>;
    var memberid = m.Memberid;
    var cityid = m.Cityid;       
    $(document).ready(function () {  

        $("#countyid").change(function() {            
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
    
        getCounty();  
        $("#countyid").find("option[value='" + m.Countyid + "']").prop("selected", true);
        $("#countyid").trigger("change"); //被trigger的function 一定要在指令之前
        $.date = function(dateObject) {
            var d = new Date(dateObject);
            var day = d.getDate();
            var month = d.getMonth() + 1;
            var year = d.getFullYear();
            if (day < 10) {
                day = "0" + day;
            }
            if (month < 10) {
                month = "0" + month;
            }
            var date =year + "-" + month + "-" + day ;
            return date;
        };
       
        var birthday = m.Birthday;
        if (birthday != null ) birthday = $.date(birthday )
        $("#username").val(m.Username);
        $("#email").val(m.Email);
         $("label[for='memberid']").text(m.Memberid);
        $("#phone").val(m.Phone);
        $("#mobile").val(m.Mobile);
        $("#address").val(m.Address);
        $("#birthday").val(birthday);
        $("#password").val(m.Password);
        $("#passconfirm").val(m.Password);
        $("#zip").val(m.Zip);
        if (m.Email != '' &&  m.Email != null ) { $('#email').attr("readonly", "readonly");}
        if (m.Cityid != "") {
         
            $("#cityid").find("option[value='" +  m.Cityid + '-' +m.Zip + "']").prop("selected", true);
            $("#cityid").trigger("change");
        }
   
        $("#btnUpdate").click(function () {
            var username = $("#username").val();                        
            countyid = $("#countyid").val();
            var phone = $("#phone").val();
            var mobile = $("#mobile").val();
            var email = $("#email").val();
            cityid = $("#cityid").val();
            var password = $("#password").val();
            var passconfirm = $("#passconfirm").val();
            var address = $("#address").val();
            var birthday = $("#birthday").val();              
            if (cityid != "" && cityid != null) {
                zip = cityid.split('-')[1];
                cityid = cityid.split('-')[0];
            }
            if (email == "") {
                alert("請輸入email");
                $("#email").focus();
            }                   
            if (username == "") {
                alert("請輸入姓名");
                $("#username").focus();
            } else if (password == "") {
                alert("請輸入密碼");
                $("#password").focus();
            } else if (password.length < 6 || password.length > 20) {
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
                    "email": email,
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
                       
                    if (data == "") {
                        alert("error");
                    } else {
                            var m = data;
                            alert("您的資料已經完成修改，感謝您的使用!");
                            var page = GetURLParameter("page");
                            if (page !== undefined) {
                                var s = base64_decode(page);
                                if (s.indexOf('?') != -1) s += "&=_" + new Date().getTime().toString();
                                else s = page + "?=_" + new Date().getTime().toString();
                                location.href = s;
                            }
                            else {
                                //      location.href = 'index.aspx';
                            }
                        }

                    }
                );
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
                            <a href="/">HOME</a>
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
                                 會員編號:
                                    <label for="memberid">  </label>
                            </div>
                            <div class="form-group">
                                <label for="">姓名
                                    <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="username" value ="" placeholder="請輸入姓名">
                            </div>
                             <div class="form-group">
                                    <label for="">電子信箱</label>
                                 
                                    <input name="email" type="text" id="email" placeholder="輸入email"  value =""  class="form-control"/> 
                                </div>        
                                           <div class="form-group">
                                    <label for="exampleInputPassword1">行動電話</label>                               
                                        <input name="mobile" type="text" id="mobile" placeholder="輸入行動電話"  value =""  class="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">連絡電話</label>
                                      <input name="phone" type="text" id="phone" placeholder="輸入連絡電話"  value =""  class="form-control" />
                             
                                </div>    
                                      <div class="form-group">
                                    <label for="">生日</label>
                                      <input name="birthday" type="date"  id="birthday"  value =""  class="form-control" />
                             
                                </div>                         
                                <div class="form-group">
                                    <label for="">收件地址</label>
                                   
                                           <input name="zip" type="text" id="zip" placeholder="郵遞區號"  size="6" readonly class="form-control"  value =""/>
                    <select   name="countyid" id="countyid" class="form-control">
                    
					</select>
                    <select class="form-control" id="cityid" name="cityid" >  
                    <option>鄉鎮市區</option>                 
					</select>
         <input type="text" class="form-control" id="address" placeholder="地址" value ="" />
                          
                                        
                                    </div>
                                 <div class="form-group">
                                    <label for="exampleInputPassword1">修改密碼</label>
                                       <input name="password" type="password" id="password"  class="form-control" placeholder="密碼"   value ="" />                                              
                                    <p>(英數字元，需6字以上)</p>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">確認密碼</label>
                                         <input name="passconfirm" type="password" id="passconfirm" class="form-control" placeholder="再次輸入密碼"   value ="" />               
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

