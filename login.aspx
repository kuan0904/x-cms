<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>
<html lang="zh-Hant-TW">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1" />
    <meta name="theme-color" content="#b483a6">
    <meta name="msapplication-navbutton-color" content="#b483a6">
    <meta name="apple-mobile-web-app-status-bar-style" content="#b483a6">
    <meta name="author" content="Xnet 智媒科技" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta property="og:title" content="" />
    <meta property="og:description" content="" />
    <meta property="og:site_name" content="" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="" />
    <meta property="og:image" content="" />
    <meta property="fb:admins" content="" />
    <meta name="robots" content="index,follow" />
    <meta name="robots" content="noindex,follow" />
    <meta name="robots" content="index,nofollow" />
    <meta name="robots" content="noindex,nofollow" />
    <title>會員中心 │ 藝時代 Cultural Launch</title>

    <link rel="stylesheet" href='assets/font-awesome/css/font-awesome.min.css' />
    <link rel="stylesheet" href='assets/bootstrap/css/bootstrap.min.css' />
    <link rel="stylesheet" href='css/reset.css' type='text/css' />
    <link rel="stylesheet" href='css/theme.css' type='text/css' />
    <link rel="stylesheet" href='css/post-layout.css' type='text/css' />
    <link rel="stylesheet" href='css/style.css' type='text/css' />
    <link rel="shortcut icon" href="favicon.ico" />
    <!--[if lt IE 9]><script src="https://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    <style>
        .btn-facebook {
            color: #fff;
            background-color: #3a5795;
            border-color: #3a5795;
        }
    </style>

    <script>
        var fb_login_url = 'fb_login.ashx?login_type=cookie';
        function createCookie(name, value) {
            var date = new Date();
            date.setTime(date.getTime() + (60 * 1000));
            var expires = "; expires=" + date.toGMTString();
            document.cookie = name + "=" + value + expires + "; path=/";
        }

        window.fbAsyncInit = function () {
            FB.init({
                appId: '164103481107660',
                cookie: true,  // enable cookies to allow the server to access
                // the session
                xfbml: true,  // parse social plugins on this page
                version: 'v2.10' // use version 2.2
            });
        };
        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));

        function personalAPI() {
            FB.api(
                '/me',
                'GET',
                { "fields": "name,birthday,email,education" },
                function (response) {
                    console.log(response);
                    access_token = FB.getAuthResponse()['accessToken'];
                    createCookie('u_fb_id', response.id);
                    createCookie('u_fb_name', response.name);
                    createCookie('u_fb_email', response.email);
                    location.href = fb_login_url;
                    //document.getElementById('resultdata').innerHTML = "<pre> <b>Access Token<b/> : " + access_token + "</pre>";
                    //document.getElementById('resultdata1').innerHTML = "<pre> <b>User Name<b/> : " + response.name + "</pre>";
                    //document.getElementById('resultdata2').innerHTML = "<pre> <b>User Email<b/> : " + response.email + "</pre>";
                    //document.getElementById('resultdata3').innerHTML = "<pre> <b>User birthday<b/> : " + response.birthday + "</pre>";
                    //document.getElementById('resultdata4').innerHTML = "<pre> <b>User education<b/> : " + response.education + "</pre>";
                }
            );
        }
        function fbloginAPI() {
            FB.api('/me', function (response) {
                createCookie('u_fb_id', response.id);
                createCookie('u_fb_name', response.name);
                createCookie('u_fb_email', response.email);
                location.href = fb_login_url;
            });
        }
        function checkfblogin() {
            FB.login(function (response) {
                if (response.status === 'connected') {
                    // fbloginAPI();
                    personalAPI();
                } else if (response.status === 'not_authorized') {

                    // The person is logged into Facebook, but not your app.
                } else {

                    // The person is not logged into Facebook, so we're not sure if
                    // they are logged into this app or not.
                }
            }, { scope: 'public_profile,email' });
        }

    </script>
  </head>

<body class="login-bg">

    <div class="content">
        <div class="row">
            <div class="col-md-4 col-md-offset-4 col-sm-8 col-sm-offset-2 col-xs-12">
                <div class="login-box">
                    <div class="login-header text-center">
                        <div class="login-logo ">
                            <a href="hp.html" title="藝時代 Cultural Launch">藝時代</a>
                        </div>
                        <div class="login-box-title">登入</div>
                    </div>


                    <form class="form-member form-login">
                        <div class="form-group  text-center">
                           
                            <button type="button" class="btn btn-facebook btn-lg btn-block">
                                <i class="fa fa-facebook" aria-hidden="true"></i> <a href="<%=fblogin  %>">使用Facebook登入</a></button>
                            <button type="button" class="btn btn-google btn-lg btn-block" id="login-button">
                                <i class="fa fa-google" aria-hidden="true"></i>使用Google登入</button>
                            <div class="divide20"></div>
                            <label>或使用藝時代帳號登入</label>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fa fa-user fa-lg" aria-hidden="true"></i>
                                </span>
                                <input type="text" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fa fa-key" aria-hidden="true"></i>
                                </span>
                                <input type="text" class="form-control">
                            </div>
                        </div>
                        <div class="divide20"></div>
                        <button type="submit" class="btn btn-green btn-lg btn-block">
                            登入
                            <i class="fa fa-angle-right margin-L-5" aria-hidden="true"></i>
                        </button>
                    </form>
                    <div class="divide20"></div>
                    <div class="text-center login-text">
                        <p>
                            <a href="forget_password.html">忘記密碼</a>　|
                            <a href="resend.html">重寄認證信</a>
                        </p>
                        <p>
                            還不是會員嗎？
                            <span class="lead">
                                <a href="registered.html">立刻註冊新帳號</a>
                            </span>
                        </p>
                    </div>
                </div>
            </div>
            <!-- col-sm-12 -main-content END -->

            <!-- col-md-8 td-main-content END -->
        </div>
        <!-- row END -->
    </div>


    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>

    <script async defer src="https://apis.google.com/js/api.js" onload="this.onload=function(){};HandleGoogleApiLibrary()" onreadystatechange="if (this.readyState === 'complete') this.onload()"></script>

    <script>
         $(document).ready(function () {
            $("#btnLogin").click(function () {
                var objAccount = $("#login_email");
                var objPasswd = $("#login_pass");
                var objVerifyCode = $("#p_VERIFYCODE");
                var p_ACCOUNT = objAccount.val();
                var p_PASSWD = objPasswd.val();
                //var p_VERIFYCODE = objVerifyCode.val();
                if (p_ACCOUNT == "") {
                    alert("請輪入Email");
                    objAccount.focus();
                } else if (p_PASSWD == "") {
                    alert("請輸入密碼");
                    objPasswd.focus();
                }
                else if (!validEmail(p_ACCOUNT)) {
                    alert("帳號非EMail格式");
                    objAccount.focus()

                    //} else if (p_VERIFYCODE == "") {
                    //	setInputStyle("warning", objVerifyCode, "請輸入驗證碼");
                } else {

                    var data = { "p_ACCOUNT": p_ACCOUNT, "p_PASSWD": p_PASSWD, "p_ACTION": "Login", "_": new Date().getTime() };
                    $.post('/lib/member_handle.ashx', data, function (data) {

                        if (data == "Y") {
                            alert('登入成功');
                            $.magnificPopup.close();
                        } else if (data == "-1") {
                            alert("登入失敗");
                            //setInputStyle("error", objAccount, "帳號錯誤請重新輸入");
                            //setInputStyle("error", objPasswd, "密碼錯誤請重新輸入");
                        }
                    });
                }
            });
            $("#btnLogin-mob").click(function () {
                var objAccount = $("#login_email-mob");
                var objPasswd = $("#login_pass-mob");
                var objVerifyCode = $("#p_VERIFYCODE");
                var p_ACCOUNT = objAccount.val();
                var p_PASSWD = objPasswd.val();
                $('.alert-err').show();
                //var p_VERIFYCODE = objVerifyCode.val();
                if (p_ACCOUNT == "") {
                    $('.alert-err').html("請輪入Email");
                    objAccount.focus();
                } else if (p_PASSWD == "") {
                    $('.alert-err').html("請輸入密碼");
                    objPasswd.focus();
                }
                else if (!validEmail(p_ACCOUNT)) {
                    $('.alert-err').html("帳號非EMail格式");
                    objAccount.focus();
                    //} else if (p_VERIFYCODE == "") {
                    //	setInputStyle("warning", objVerifyCode, "請輸入驗證碼");
                } else {
                    $('.alert-err').html("");
                    $('.alert-err').hide();
                    var data = { "p_ACCOUNT": p_ACCOUNT, "p_PASSWD": p_PASSWD, "p_ACTION": "Login", "_": new Date().getTime() };
                    $.post('/lib/member_handle.ashx', data, function (data) {
                        if (data == "Y") {
                            alert('登入成功');
                            $.magnificPopup.close();
                            $(".icon-close-mob").trigger("click");
                        } else if (data == "-1") {
                            alert("登入失敗");
                            //setInputStyle("error", objAccount, "帳號錯誤請重新輸入");
                            //setInputStyle("error", objPasswd, "密碼錯誤請重新輸入");
                        }
                    });
                }
            });
            $("#btnRegister-mob").click(function () {
                //if ($("#rad2").prop("checked")) {
                var objNewAccount = $("#regist_email-mob");
                var objNewPasswd = $("#regist_pass-mob");
                var objChkPasswd = $("#regist_pass1-mob");
                //var objMobile = $("#p_MOBILE");
                var p_NEW_ACCOUNT = objNewAccount.val();
                var p_NEW_PASSWD = objNewPasswd.val();
                var p_CHK_PASSWD = objChkPasswd.val();

                if (p_NEW_ACCOUNT == "") {
                    setInputStyle("warning", objNewAccount, "請輪入Email");
                } else if (!validEmail(p_NEW_ACCOUNT)) {
                    alert("帳號非EMail格式");
                    setInputStyle("error", objNewAccount, "Email錯誤請重新輸入");
                } else if (p_NEW_PASSWD == "") {
                    setInputStyle("warning", objNewPasswd, "請輸入密碼");
                } else if ((p_NEW_PASSWD.length < 6) || (p_NEW_PASSWD.length > 15)) {
                    alert("密碼長度不對");
                    setInputStyle("error", objNewPasswd, "密碼錯誤請重新輸入");
                } else if (p_CHK_PASSWD == "") {
                    setInputStyle("warning", objChkPasswd, "請輸入確認密碼");
                } else if (p_CHK_PASSWD != p_NEW_PASSWD) {
                    alert("請確認兩次輸入的密碼是否相同");
                    setInputStyle("error", objNewPasswd, "密碼錯誤請重新輸入");
                    setInputStyle("error", objChkPasswd, "確認密碼錯誤請重新輸入");
                    //} else if (p_MOBILECODE.length < 4 || p_MOBILE < 6) {
                    //    alert("行動電話長度不對");
                    //    setInputStyle("error", objMobile, "行動電話錯誤請重新輸入");
                } else {
                    $.post('/lib/member_handle.ashx', {
                        "p_ACCOUNT": p_NEW_ACCOUNT, "p_PASSWD": p_NEW_PASSWD,
                        "p_ACTION": "Register", "_": new Date().getTime()
                    }, function (data) {
                        if (data == "0") {
                            alert("註冊失敗");
                        } else if (data == "-1") {
                            alert("帳號已經存在");
                            setInputStyle("error", objNewAccount, "帳號錯誤請重新輸入");
                        }
                        else {
                            alert('加入成功');
                            $.magnificPopup.close();
                        }
                    });
                }
                //} else {
                //    alert("尚未同意會員服務使用條款");
                //}
            });
            $("#btnRegister").click(function () {
                //if ($("#rad2").prop("checked")) {
                var objNewAccount = $("#regist_email");
                var objNewPasswd = $("#regist_pass");
                var objChkPasswd = $("#regist_pass1");
                //var objMobile = $("#p_MOBILE");
                var p_NEW_ACCOUNT = objNewAccount.val();
                var p_NEW_PASSWD = objNewPasswd.val();
                var p_CHK_PASSWD = objChkPasswd.val();

                if (p_NEW_ACCOUNT == "") {
                    setInputStyle("warning", objNewAccount, "請輪入Email");
                } else if (!validEmail(p_NEW_ACCOUNT)) {
                    alert("帳號非EMail格式");
                    setInputStyle("error", objNewAccount, "Email錯誤請重新輸入");
                } else if (p_NEW_PASSWD == "") {
                    setInputStyle("warning", objNewPasswd, "請輸入密碼");
                } else if ((p_NEW_PASSWD.length < 6) || (p_NEW_PASSWD.length > 15)) {
                    alert("密碼長度不對");
                    setInputStyle("error", objNewPasswd, "密碼錯誤請重新輸入");
                } else if (p_CHK_PASSWD == "") {
                    setInputStyle("warning", objChkPasswd, "請輸入確認密碼");
                } else if (p_CHK_PASSWD != p_NEW_PASSWD) {
                    alert("請確認兩次輸入的密碼是否相同");
                    setInputStyle("error", objNewPasswd, "密碼錯誤請重新輸入");
                    setInputStyle("error", objChkPasswd, "確認密碼錯誤請重新輸入");
                    //} else if (p_MOBILECODE.length < 4 || p_MOBILE < 6) {
                    //    alert("行動電話長度不對");
                    //    setInputStyle("error", objMobile, "行動電話錯誤請重新輸入");
                } else {
                    $.post('/lib/member_handle.ashx', {
                        "p_ACCOUNT": p_NEW_ACCOUNT, "p_PASSWD": p_NEW_PASSWD,
                        "p_ACTION": "Register", "_": new Date().getTime()
                    }, function (data) {
                        if (data == "0") {
                            alert("註冊失敗");
                        } else if (data == "-1") {
                            alert("帳號已經存在");
                            setInputStyle("error", objNewAccount, "帳號錯誤請重新輸入");
                        }
                        else {
                            alert('加入成功');
                            $.magnificPopup.close();
                        }
                    });
                }
                //} else {
                //    alert("尚未同意會員服務使用條款");
                //}
            });
            $("#p_NEW_ACCOUNT").blur(function () {
                if ($(this).val() != "") {
                    if (!validEmail($(this).val())) {
                        alert("帳號非EMail格式");
                        $(this).focus();
                    }
                }
            });

        $("#login-button").on('click', function() {
	        $("#login-button").attr('disabled', 'disabled');
			
	        // API call for Google login
	        gapi.auth2.getAuthInstance().signIn().then(
		    // On success
		            function(success) {
			            // API call to get user information
			            gapi.client.request({ path: 'https://www.googleapis.com/plus/v1/people/me' }).then(
				            // On success
				            function(success) {
					            console.log(success);
					            var user_info = JSON.parse(success.body);
					            console.log(user_info);
                                    var data = {"p_ACCOUNT": user_info.id, "p_PASSWD": user_info.emails[0].value, "p_PASSWD": user_info.emails[0].value, "p_username": user_info.displayName, "p_ACTION": "googleLogin", "_": new Date().getTime() };
                                   $.post('/lib/member_handle.ashx', data, function (data) {                           
                       
                                           if (data == "Y") {
                                                alert('登入成功');
                                 
                                           } else if (data == "-1") {
                                               alert("登入失敗");
                                               //setInputStyle("error", objAccount, "帳號錯誤請重新輸入");
                                               //setInputStyle("error", objPasswd, "密碼錯誤請重新輸入");
                                           } 
                                   });
        
					            //$("#user-information div").eq(0).find("span").text(user_info.displayName);
					            //$("#user-information div").eq(1).find("span").text(user_info.id);
					            //$("#user-information div").eq(2).find("span").text(user_info.gender);
					            //$("#user-information div").eq(3).find("span").html('<img src="' + user_info.image.url + '" />');
					            //$("#user-information div").eq(4).find("span").text(user_info.emails[0].value);

					            $("#user-information").show();
					            $("#login-button").hide();
				            },
				            // On error
				            function(error) {
					            $("#login-button").removeAttr('disabled');
					            alert('Error : Failed to get user user information');
				            }
			            );
		            },
		            // On error
		            function(error) {
			            $("#login-button").removeAttr('disabled');
			            alert('Error : Login Failed');
		            }
	            );
            });
        });

         function HandleGoogleApiLibrary() {
	// Load "client" & "auth2" libraries
	gapi.load('client:auth2', {
		callback: function() {
			// Initialize client library
			// clientId & scope is provided => automatically initializes auth2 library
			gapi.client.init({
		    	apiKey: 'AIzaSyBnDVUVUIroavX9FIyf7QbSEjNvQqvfx9g',
		    	clientId: '754193213942-a9fobo4p4djkdrgal6naqt0rue48qdvo.apps.googleusercontent.com',
		    	scope: 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/plus.me'
			}).then(
				// On success
				function(success) {
			  		// After library is successfully loaded then enable the login button
			  		$("#login-button").removeAttr('disabled');
				}, 
				// On error
				function(error) {
					alert('Error : Failed to Load Library');
			  	}
			);
		},
		onerror: function() {
			// Failed to load libraries
		}
	});
}
    </script>
</body>

</html>
