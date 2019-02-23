<%@ Page Language="C#" %>

<!DOCTYPE html>
<html lang="zh-Hant-TW">

<head>
    <meta charset=UTF-8 />
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
    <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
    <META HTTP-EQUIV="EXPIRES" CONTENT="0">
    <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
    <META HTTP-EQUIV="EXPIRES" CONTENT="Mon, 22 Jul 2002 11:12:01 GMT">
    <link rel="stylesheet" href='assets/font-awesome/css/font-awesome.min.css' />
    <link rel="stylesheet" href='assets/bootstrap/css/bootstrap.min.css' />
    <link rel="stylesheet" href='css/reset.css' type='text/css' />
    <link rel="stylesheet" href='css/theme.css' type='text/css' />
    <link rel="stylesheet" href='css/post-layout.css' type='text/css' />
    <link rel="stylesheet" href='css/style.css' type='text/css' />
    <link rel="shortcut icon" href="favicon.ico" />
    <!--[if lt IE 9]><script src="https://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->

</head>

<body class="login-bg">

    <div class="content">
        <div class="row">
            <div class="col-md-4 col-md-offset-4 col-sm-8 col-sm-offset-2 col-xs-12">
                <div class="login-box">
                    <div class="login-header text-center">
                        <div class="login-logo">
                            <a href="hp.html" title="藝時代 Cultural Launch">藝時代</a>
                        </div>
                        <div class="login-box-title"></div>
                    </div>
                    <form class="form-member form-login">
                        <div class="form-group  text-center">
                            <label>註冊個人帳號</label>
                        </div>
                        <div class="form-group">
                            <div class="login-input-box">
                                <input class="login-input100 form-control" id="email" placeholder="帳號(email)">
                                <span class="focus-input100"></span>
                                <span class="symbol-input100">
                                    <i class="fa fa-user fa-lg" aria-hidden="true"></i>
                                </span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="login-input-box">
                                <input class="login-input100 form-control" id="pwd" type="password" placeholder="密碼">
                                <span class="focus-input100"></span>
                                <span class="symbol-input100">
                                    <i class="fa fa-key" aria-hidden="true"></i>
                                </span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="login-input-box">
                                <input class="login-input100 form-control" id="pwd1" type="password"  placeholder="確認密碼">
                                <span class="focus-input100"></span>
                                <span class="symbol-input100">
                                    <i class="fa fa-envelope" aria-hidden="true"></i>
                                </span>
                            </div>
                        </div>
                        <div class="divide20"></div>
                        <button type="button" id="regist" class="btn btn-green btn-lg btn-block">註冊會員</button>
                    </form>
                    <div class="divide20"></div>
                    <div class="text-center login-text">
                        <p>
                            按下註冊鈕的同時，表示您已詳閱我們的
                            <a href="#">資料使用政策與使用條款</a>，同意使用藝時代所提供的服務並訂閱電子報。
                        </p>
                        <p>
                            已經有帳號了？
                            <span class="lead">
                                <a href="/login">馬上登入</a>
                            </span>
                        </p>
                    </div>
                </div>
                <div class="divide40"></div>
            </div>
            <!-- col-sm-12 -main-content END -->
            <!-- col-md-8 td-main-content END -->
        </div>
        <!-- row END -->
    </div>
    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/swipe/swiper.min.js"></script>
    <script src='js/device.js'></script>

    <script src='js/script.js'></script>
    <script src='lib/common.js'></script>
    <script>
        $(document).ready(function () {

            var dataValue = {};
            $('#regist').click(function () {
                var email = $('#email').val();
                var pwd = $('#pwd').val();
                var pwd1 = $('#pwd1').val();

                if (email == "") {
                    alert("請輸入帳號");
                    $("#email").focus();
                } else if (!validEmail(email)) {
                    alert("帳號非EMail格式");
                } else if (pwd == "") {
                    alert("請輸入密碼");
                    $("#pwd").focus();
                } else if ((pwd.length < 6) || (pwd.length > 15)) {
                    alert("密碼長度不對");
                    $("#pwd").focus();
                } else if (pwd1 == "") {
                    alert("請輸入確認密碼");
                    $("#pwd1").focus();
                } else if (pwd != pwd1) {
                    alert("請確認兩次輸入的密碼是否相同");
                } else {

                    $.post('/lib/member_handle.ashx', {
                        "p_ACTION": "Register",
                        "p_ACCOUNT": email,
                        "p_PASSWD": pwd,
                        "_": new Date().getTime() 
                    }, function (result) {
                        if (result == "-1") {

                            alert("此帳號已經加入!");

                        }
                        else if (result == "Y") {

                            alert('加入會員成功,\r並請收取Email按下認証,\r以確認會員資格!');
                            location.href = "/index";
                        }
                    });
                   

                }
                return false
            });
        });
    </script>
</body>

</html>