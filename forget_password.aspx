﻿<%@ Page Language="C#" %>
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
        <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
    <META HTTP-EQUIV="EXPIRES" CONTENT="0">
    <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
    <META HTTP-EQUIV="EXPIRES" CONTENT="Mon, 22 Jul 2002 11:12:01 GMT">
    <title>會員中心 │ 藝時代 Cultural Launch</title>

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
                        <div class="login-logo ">
                            <a href="hp.html" title="藝時代 Cultural Launch">藝時代</a>
                        </div>
                        <div class="login-box-title"></div>
                    </div>
                    <form class="form-member form-login">
                        <div class="form-group  text-center">
                            <label>忘記密碼？</label>
                        </div>
                        <div class="form-group">
                            <div class="login-input-box">
                                <input class="login-input100 form-control" id="email" placeholder="請填入註冊時使用的Email信箱">
                                <span class="focus-input100"></span>
                                <span class="symbol-input100">
                                    <i class="fa fa-envelope" aria-hidden="true"></i>
                                </span>
                            </div>
                        </div>
                        <div class="divide20"></div>
                        <button type="button" class="btn btn-green btn-lg btn-block">
                            重設密碼
                            <i class="fa fa-key margin-L-5 " aria-hidden="true"></i>
                        </button>
                    </form>
                    <div class="divide20"></div>
                    <div class="text-center login-text">
                        <p>
                            <a href="#" id="back">回上一頁</a>
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
    <script src="/js/jquery-1.11.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/swipe/swiper.min.js"></script>
    <script src='js/device.js'></script>
  
    <script src='js/script.js'></script>

    <script>

        $(document).ready(function () {
           
            var dataValue = {};
            
            $('#back').click(function () {
                history.back();
            });
            $('button').click(function () {
                var text = $('#email').val();
                if (text == '') {
                    alert('請輸入請填入註冊時使用的Email信箱');
                }
                else {
                    $.post('/lib/member_handle.ashx', {
                        "p_ACTION": "forget_password"
                        , "p_ACCOUNT": text,
                        "_": new Date().getTime() 
                    }, function (result) {
                        if (result != "") {
                            if (result == 'Y') {
                                alert('請收取Email確認密碼');
                            }
                            else if (result == "-1") {

                                alert('帳號不存在,請重新輸入!');
                            }
                            else
                                alert(result);

                        }
                    });
                }
                return false;
            })



        });

    

    </script>
</body>

</html>