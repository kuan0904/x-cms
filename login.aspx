﻿<%@ Page Language="C#" %>
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

    <meta name="robots" content="index,nofollow" />

    <title>會員中心 │ 創藝時代 Cultural Launch</title>
    <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
    <META HTTP-EQUIV="EXPIRES" CONTENT="0">
    <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
    <META HTTP-EQUIV="EXPIRES" CONTENT="Mon, 22 Jul 2002 11:12:01 GMT">
    <link rel="stylesheet" href='assets/font-awesome/css/font-awesome.min.css' />
    <link rel="stylesheet" href='assets/bootstrap/css/bootstrap.min.css' />
    <link rel="stylesheet" href='css/reset.css' type='text/css' />
    <link rel="stylesheet" href='css/theme.css?v=1' type='text/css' />
    <link rel="stylesheet" href='css/post-layout.css' type='text/css' />
    <link rel="stylesheet" href='css/style.css?v=1' type='text/css' />
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
        function initFooter() {
            $(".footer").load("footer.html")
        }
    </script>
    <script>
        function Auth() {
            var URL = 'https://access.line.me/oauth2/v2.1/authorize?';
            URL += 'response_type=code';
            URL += '&client_id=1620848228';
            URL += '&redirect_uri=http://' + location.host + '/lib/linelogin.ashx';
            URL += '&state=login&scope=openid%20profile&nonce=abc';
            window.location.href = URL;
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
                            <a href="/index" title="創藝時代 Cultural Launch">創藝時代</a>
                        </div>
                        <div class="login-box-title">登入</div>
                    </div>


                    <form class="form-member form-login">
                        <div class="form-group  text-center">

                            <button type="button" class="btn btn-facebook btn-lg btn-block">
                                <i class="fa fa-facebook" aria-hidden="true"></i>使用Facebook登入
                            </button>
                            <!--
    <button type="button" class="btn btn-green  btn-block" id="lineLogin" onclick="Auth();">
        <img src="/images/line.png" />
    </button>-->
                            <div class="divide20"></div>
                            <label>或使用創藝時代帳號登入</label>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fa fa-user fa-lg" aria-hidden="true"></i>
                                </span>
                                <input type="text" id="login_email" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="fa fa-key" aria-hidden="true"></i>
                                </span>
                                <input type="password" id="loginpass" class="form-control">
                            </div>
                        </div>
                        <div class="divide20"></div>

                        <button type="button" class="btn btn-green btn-lg btn-block" id="btnLogin">
                            登入
                            <i class="fa fa-angle-right margin-L-5" aria-hidden="true"></i>
                        </button>
                    </form>
                    <div class="divide20"></div>
                    <div class="text-center login-text">
                        <p>
                            <a href="/forget_password">忘記密碼</a>　|
                            <a href="/resend">重寄認證信</a>
                        </p>
                        <p>
                            還不是會員嗎？
                            <span class="lead">
                                <a href="#" id="register">立刻註冊新帳號</a>
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

     <script src="/lib/common.js?v=5"></script>

    <script>
        $(document).ready(function () {
            var url =getParameterByName("returnurl");
            if (url == null || url == '') url = base64_encode('/index');
            var returnurl = url;
            $("#register").click(function () {

                location.href = '/registered?returnurl='+ returnurl;
                return false;
            });
            url = base64_decode(url);
            $(".btn-facebook").click(function () {

                location.href = 'https://www.facebook.com/v3.2/dialog/oauth/?client_id=164103481107660&redirect_uri=https://www.culturelaunch.net/fb_login.ashx&response_type=code&auth_type=rerequest&scope=email';
                return false;
            });
            $("#btnLogin").click(function () {
                var objAccount = $("#login_email");
                var objPasswd = $("#loginpass");
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
                //}
                //else if (!validEmail(p_ACCOUNT)) {
                //    alert("帳號非EMail格式");
                //    objAccount.focus()

                   
                } else {
                 
                    var data = { "p_ACCOUNT": p_ACCOUNT, "p_PASSWD": p_PASSWD, "p_ACTION": "Login", "_": new Date().getTime() };
                    $.post('/lib/member_handle.ashx', data, function (data) {

                        if (data == "Y") {
                            alert('登入成功');
                            //$.magnificPopup.close();
                            location.href = url;
                        } else if (data == "-1") {
                            alert("登入失敗");
                            //setInputStyle("error", objAccount, "帳號錯誤請重新輸入");
                            //setInputStyle("error", objPasswd, "密碼錯誤請重新輸入");
                        }
                        return false;
                    });
                }
            });
            
        });

      
    </script>
</body>

</html>
