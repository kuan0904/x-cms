<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="member_login.aspx.cs" Inherits="member_login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="js/jquery.ui.datepicker-zh-TW.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script>
        var fb_login_url = 'fb_login.ashx?login_type=cookie';
        function createCookie(name, value) {
            var date = new Date();
            date.setTime(date.getTime() + (60 * 1000));
            var expires = "; expires=" + date.toGMTString();
            document.cookie = name + "=" + value + expires + "; path=/";
        }   
        //365173480244176命運好好玩ID
        //測試平台ID1155212207854130
              window.fbAsyncInit = function() {
              FB.init({
                  appId: '105448990000048',
                cookie     : true,  // enable cookies to allow the server to access
                                    // the session
                xfbml      : true,  // parse social plugins on this page
                version    : 'v2.10' // use version 2.2
              });
  };
  (function(d, s, id) {
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
      FB.api('/me', function(response) {     
        createCookie('u_fb_id', response.id);
        createCookie('u_fb_name', response.name);
        createCookie('u_fb_email', response.email);      
        location.href = fb_login_url;
    });
  }
  function checkfblogin(){
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
      }, {scope: 'public_profile,email'});
  }

    </script>
    <script>


        $(document).ready(function () {
            if (GetURLParameter("page") != undefined)   fb_login_url  += '&page=' + GetURLParameter("page");
            $("#imgverifycode").click(function () {
                $("#imgverifycode").attr("src", "Captcha.ashx" + "?=_" + new Date().getTime().toString());
            });

            $("#btnLogin").click(function () {
                var p_ACCOUNT = $("#p_ACCOUNT").val();
                var p_PASSWD = $("#p_PASSWD").val();
                var p_VERIFYCODE = $("#p_VERIFYCODE").val();

                if (p_ACCOUNT == "") {
                    alert("請輸入帳號");
                    $("#p_ACCOUNT").focus();
                } else if (p_PASSWD == "") {
                    alert("請輸入密碼");
                    $("#p_PASSWD").focus();
                } else if (p_VERIFYCODE == "") {
                    alert("請輸入驗證碼");
                    $("#p_VERIFYCODE").focus();
                } else {
            
                    var data = { "item": "member",  "p_VERIFYCODE": p_VERIFYCODE, "p_ACCOUNT": p_ACCOUNT, "p_PASSWD": p_PASSWD, "p_ACTION": "Login", "_": new Date().getTime() };
                    $.post('libs/member_handle.ashx', data, function (data) {
                      
                        if (data == "-1") {
                            alert("驗證碼輸入錯誤");
                        } else if (data == "0") {
                            alert("登入失敗");
                        } else if (data == "1" || data == "2") {
                            if (data == "2") alert('恭喜您獲得購物金！');
                            showPopup();
                        }
                    });
                }
            });



            $("#rad1").click(function () {
                $("#rad2").prop("checked", false);
            });

            $("#rad2").click(function () {
                $("#rad1").prop("checked", false);
            });

            $("#p_NEW_ACCOUNT").blur(function () {
                if ($(this).val() != "") {
                    if (!validEmail($(this).val())) {
                        alert("帳號非EMail格式");
                    }
                }
            });

            $("#btnRegister").click(function () {
                if ($("#rad2").prop("checked")) {
                    var p_NEW_ACCOUNT = $("#p_NEW_ACCOUNT").val();
                    var p_NEW_PASSWD = $("#p_NEW_PASSWD").val();
                    var p_CHK_PASSWD = $("#p_CHK_PASSWD").val();
                    var p_CALENDAR = $("#p_CALENDAR").prop("checked") ? "農曆" : "國曆";
                    var p_MONTHPLUS = $("#p_MONTHPLUS").prop("checked") ? "Y" : "N";
                    var p_YEAR = $("#p_YEAR").val();
                    var p_MONTH = $("#p_MONTH").val();
                    var p_DAY = $("#p_DAY").val();
                    var p_HOUR = $("#p_HOUR").val();
               
                    if (p_NEW_ACCOUNT == "") {
                        alert("請輸入帳號");
                        $("#p_NEW_ACCOUNT").focus();
                    } else if (!validEmail(p_NEW_ACCOUNT)) {
                        alert("帳號非EMail格式");
                    } else if (p_NEW_PASSWD == "") {
                        alert("請輸入密碼");
                        $("#p_NEW_PASSWD").focus();
                    } else if ((p_NEW_PASSWD.length < 6) || (p_NEW_PASSWD.length > 15)) {
                        alert("密碼長度不對");
                        $("#p_NEW_PASSWD").focus();
                    } else if (p_CHK_PASSWD == "") {
                        alert("請輸入確認密碼");
                        $("#p_CHK_PASSWD").focus();
                    } else if (p_CHK_PASSWD != p_NEW_PASSWD) {
                        alert("請確認兩次輸入的密碼是否相同");
                    } else {
                        var data = { "item": "member",   "p_ACCOUNT": p_NEW_ACCOUNT, "p_PASSWD": p_NEW_PASSWD,
                            "p_CALENDAR": p_CALENDAR, "p_MONTHPLUS": p_MONTHPLUS,
                            "p_YEAR": p_YEAR, "p_MONTH": p_MONTH,
                            "p_DAY": p_DAY, "p_HOUR": p_HOUR,
                            "p_ACTION": "Register", "_": new Date().getTime() };                      
                        $.post('libs/member_handle.ashx',data, function (data) {
                          
                            if (data == "0") {
                                alert("註冊失敗");
                            } else if (data == "-1") {
                                alert("帳號已經存在");
                            } else if (data == "1" || data == "2") {
                                if (data == "1") alert("註冊完成");
                                if (data == "2") alert('恭喜您獲得購物金100元！');
                                var page = GetURLParameter("page");
                                if (page === undefined) {
                                    location.href = "memberData.aspx?=_" + new Date().getTime().toString();
                                } else {
                                    
                                    var s = base64_decode(page);
                                    if (s.indexOf('?') != -1) s += "&=_" + new Date().getTime().toString();
                                    else s = page + "?=_" + new Date().getTime().toString();
                                    location.href = s;
                                }
                            }
                        });
                    }
                } else {
                    alert("尚未同意會員服務使用條款");
                }
            });

            var endYEAR = $.datepicker.formatDate('yy', new Date());
            var starYEAR = endYEAR - 120;
            for (var i = starYEAR; i <= endYEAR; i++) {
                $("#p_YEAR").append($("<option></option>").attr("value", $.LeftPad(i, 4)).text($.LeftPad(i, 4)));
            }
            for (var i = 1; i <= 12; i++) {
                $("#p_MONTH").append($("<option></option>").attr("value", $.LeftPad(i, 2)).text($.LeftPad(i, 2)));
            }
            for (var i = 1; i <= 31; i++) {
                $("#p_DAY").append($("<option></option>").attr("value", $.LeftPad(i, 2)).text($.LeftPad(i, 2)));
            }

            $("#p_HOUR").append($("<option></option>").attr("value", "子時(23-01)").text("子時(23-01)"));
            $("#p_HOUR").append($("<option></option>").attr("value", "丑時(01-03)").text("丑時(01-03)"));
            $("#p_HOUR").append($("<option></option>").attr("value", "寅時(03-05)").text("寅時(03-05)"));
            $("#p_HOUR").append($("<option></option>").attr("value", "卯時(05-07)").text("卯時(05-07)"));
            $("#p_HOUR").append($("<option></option>").attr("value", "辰時(07-09)").text("辰時(07-09)"));
            $("#p_HOUR").append($("<option></option>").attr("value", "巳時(09-11)").text("巳時(09-11)"));
            $("#p_HOUR").append($("<option></option>").attr("value", "午時(11-13)").text("午時(11-13)"));
            $("#p_HOUR").append($("<option></option>").attr("value", "未時(13-15)").text("未時(13-15)"));
            $("#p_HOUR").append($("<option></option>").attr("value", "申時(15-17)").text("申時(15-17)"));
            $("#p_HOUR").append($("<option></option>").attr("value", "酉時(17-19)").text("酉時(17-19)"));
            $("#p_HOUR").append($("<option></option>").attr("value", "戌時(19-21)").text("戌時(19-21)"));
            $("#p_HOUR").append($("<option></option>").attr("value", "亥時(21-23)").text("亥時(21-23)"));

            $("#p_MONTH").change(function () {
                switch ($(this).val()) {
                    case "01":
                    case "03":
                    case "05":
                    case "07":
                    case "08":
                    case "10":
                    case "12":
                        for (var i = 1; i <= 31; i++) {
                            $("#p_DAY").append($("<option></option>").attr("value", i).text(i));
                        }
                        break;
                    case "02":
                        for (var i = 1; i <= 29; i++) {
                            $("#p_DAY").append($("<option></option>").attr("value", i).text(i));
                        }
                        break;
                    case "04":
                    case "06":
                    case "09":
                    case "11":
                        for (var i = 1; i <= 30; i++) {
                            $("#p_DAY").append($("<option></option>").attr("value", i).text(i));
                        }
                        break;
                }
            });

        });

    </script>
    <style type="text/css">
        <!--
        .style3 {
            color: #990000;
        }

        .style7 {
            font-size: 16px;
        }

        .link {
            color: #0080FF;
            font-size: 16px;
        }

        .popup_container {
            position: fixed;
            width: 770px;
            z-index: 999;
        }

            .popup_container:before {
                content: "";
                background-color: rgba(0, 0, 0, 0.6);
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
            }

        .popupContainer {
            position: relative;
            width: 80%;
            max-width: 30em;
            margin: 8em auto 0;
        }

        .link_popupclose {
            display: block;
            width: 30px;
            height: 30px;
            position: absolute;
            top: -15px;
            right: -15px;
            background-color: #000000;
            color: #FFFFFF;
            font-size: 32px;
            padding: 10px;
            text-align: center;
            vertical-align: middle;
            border-radius: 30px;
        }
        -->
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="CONTENT-one" style="height: 1078px;">
        <!-- 主內容 -->
        <div id="content">
            <!-- 現在位置 -->
            <div id="location"><span>會員中心 &gt;會員登入</span></div>
            <!-- 會員登入 -->
            <table width="770" border="0" align="center" bgcolor="#F4EBE8">
                <tbody>
                    <tr>
                        <td width="88%" colspan="7">&nbsp;</td>
                    </tr>
                    <tr id="trLoginGiftEDM" style="display: none;">
                        <td colspan="7">
                            <div align="center">
                                活動期間2014/12/17- 2015/01/06首次登入<br>
                                即可獲得$100購物金<br>
                                單筆消費滿$1000，即可折抵$100(金飾、法會、親算除外)<br>
                                <a href="/events.php?n_id=139" class="link">立即購物</a><br>
                                <a href="/member/member15.html" class="link">查看我的購物金</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <div align="center">
                                <img src="../images/Login.gif" width="500" height="46"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <table border="0" align="center" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td width="401">
                                            <div align="left">
                                                <table width="400" border="0" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td width="400" height="55" align="right" valign="middle" background="../images/Login-2.gif">
                                                                <div align="center">
                                                                    <input type="text" style="font-size: 16px; width: 390px; height: 43px;" value="" id="p_ACCOUNT" placeholder="請輸入您的帳號、E-mail或身份證字號">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <table width="400" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td width="400" height="55" align="right" valign="middle" background="../images/Login-2.gif">
                                            <div align="center">
                                                <input type="password" style="font-size: 16px; width: 390px; height: 43px;" value="" id="p_PASSWD" placeholder="請輸入您的密碼">
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <div align="left">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td width="217">&nbsp;</td>
                                            <td width="343">
                                                <div align="center">(輸入時請注意英文字母大小寫)</div>
                                            </td>
                                            <td width="206"><a href="member_getpwd.aspx" class="style3">忘記密碼</a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <div align="left"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <div align="left">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td width="538">
                                                <div align="left">
                                                    <table width="562" border="0" cellspacing="0" cellpadding="0">
                                                        <tbody>
                                                            <tr>
                                                                <td width="284" height="55" align="right" valign="middle">
                                                                    <div align="right">
                                                                        <img id="imgverifycode" style="vertical-align: bottom; cursor: pointer;" src="Captcha.ashx" alt="驗證碼" title="">
                                                                    </div>
                                                                </td>
                                                                <td width="278" align="right" valign="middle">
                                                                    <table width="180" border="0" align="center" cellpadding="0" cellspacing="0">
                                                                        <tbody>
                                                                            <tr>
                                                                                <td width="500" height="40" bgcolor="#FFCCCC">
                                                                                    <div align="center">
                                                                                        <input id="p_VERIFYCODE" style="font-size: 16px; width: 170px; height: 35px;" maxlength="5" size="8" placeholder="請輸入左邊驗證碼數字">
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td width="340">
                                            <div align="right">
                                                <img src="../images/Login-go.gif" width="180" height="42" id="btnLogin" style="cursor: pointer;"></div>
                                        </td>
                                        <td width="105" align="left" valign="middle">
                                            <div align="center"><a href="#">以其他方式登入</a></div>
                                        </td>
                                        <td width="321" align="left" valign="middle">
                                            <img id="btnFbLogin1" src="../images/fb-go.gif" width="150" height="35" style="cursor:pointer;"  onclick ="checkfblogin();">
                                      
                                              <asp:HyperLink ID="fb_login" runat="server" Visible="False"> <img id="btnFbLogin" src="../images/fb-go.gif" width="150" height="35" style="cursor: pointer;"></asp:HyperLink>
                                           </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="7">&nbsp;</td>
                    </tr>
                </tbody>
            </table>
            <div class="line3"></div>
            <table width="770" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#F7EBD2">
                <tbody>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <div align="center">
                                <img src="../images/Login-registration.gif" width="500" height="46"></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div align="center">
                                <table width="500" align="center" cellpadding="0" cellspacing="0" bgcolor="#EACD9D">
                                    <tbody>
                                        <tr>
                                            <td width="100">
                                                <div align="left">
                                                    <table width="100" border="0" cellpadding="0" cellspacing="0" bgcolor="#EACD9D">
                                                        <tbody>
                                                            <tr>
                                                                <td width="100" height="55">
                                                                    <div align="center">
                                                                        <n>帳 號</n>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </td>
                                            <td width="338">
                                                <table width="380" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                                                    <tbody>
                                                        <tr valign="middle">
                                                            <td height="48" align="center">
                                                                <input type="text" style="font-size: 16px; width: 390px; height: 43px;" value="" id="p_NEW_ACCOUNT" placeholder="請輸入常使用之E-mail帳號">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td width="40">&nbsp;</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <table width="500" align="center" cellpadding="0" cellspacing="0" bgcolor="#EACD9D">
                                <tbody>
                                    <tr>
                                        <td width="100">
                                            <div align="left">
                                                <table width="100" border="0" cellpadding="0" cellspacing="0" bgcolor="#EACD9D">
                                                    <tbody>
                                                        <tr>
                                                            <td width="100" height="55">
                                                                <div align="center">
                                                                    <n>密 碼</n>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </td>
                                        <td width="338">
                                            <table width="380" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                                                <tbody>
                                                    <tr valign="middle">
                                                        <td height="48" align="center">
                                                            <input type="password" style="font-size: 16px; width: 390px; height: 43px;" value="" id="p_NEW_PASSWD" placeholder="請輸入英文或數字6~15碼">
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td width="40">&nbsp;</td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <table width="500" align="center" cellpadding="0" cellspacing="0" bgcolor="#EACD9D">
                                <tbody>
                                    <tr>
                                        <td width="100">
                                            <div align="left">
                                                <table width="100" border="0" cellpadding="0" cellspacing="0" bgcolor="#EACD9D">
                                                    <tbody>
                                                        <tr>
                                                            <td width="100" height="55">
                                                                <div align="center">
                                                                    <n>確認密碼</n>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </td>
                                        <td width="338">
                                            <table width="380" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                                                <tbody>
                                                    <tr valign="middle">
                                                        <td height="48" align="center">
                                                            <input type="password" style="font-size: 16px; width: 390px; height: 43px;" value="" id="p_CHK_PASSWD" placeholder="請再次輸入密碼確認">
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td width="40">&nbsp;</td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <table width="500" align="center" cellpadding="0" cellspacing="0" bgcolor="#EACD9D">
                                <tbody>
                                    <tr>
                                        <td width="100">
                                            <div align="left">
                                                <table width="100" border="0" cellpadding="0" cellspacing="0" bgcolor="#EACD9D">
                                                    <tbody>
                                                        <tr>
                                                            <td width="100" height="55">
                                                                <div align="center">
                                                                    <n>出生日期</n>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </td>
                                        <td width="338">
                                            <table width="380" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                                                <tbody>
                                                    <tr valign="middle">
                                                        <td height="48">
                                                            <div class="style5">
                                                                <span class="style4" style="margin-left: 10px;">
                                                                    <select id="p_YEAR"></select>年
                              <select id="p_MONTH"></select>月
                              <select id="p_DAY"></select>日
                              <select id="p_HOUR"></select>時
                                                                </span>
                                                                <br>
                                                                <span class="style4" style="margin-left: 10px;">
                                                                    <input name="checkbox" type="checkbox" id="p_CALENDAR">農曆
                              <input name="checkbox2" type="checkbox" id="p_MONTHPLUS">閏月 
                                                                </span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                        <td width="40">&nbsp;</td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <table width="480" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td width="222">
                                            <div align="center">會員服務使用條款</div>
                                        </td>
                                        <td width="113">
                                            <input name="" type="radio" id="rad1" value="">我不同意</td>
                                        <td width="145">
                                            <input name="" type="radio" id="rad2" value="">我同意 </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <div align="center"></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div align="center">
                                <textarea name="textarea" cols="85" rows="5" readonly="readonly">                    命運好好玩網站會員申請同意書
        ※如滿一年未登入會員，本站經自動刪除您的會員資料※
        非常歡迎您加入命運好好玩網站的大家庭！為了維護您的權益，請詳細閱讀本同意書所有內容，同意後申請成為會員，使用本網的優質服務。
        1.台端於申請會員時，所填寫之會員資料，僅供命運好好玩網站會員服務之用，命運好好玩網站不會以任何非法形式販售、傳佈，您所提供的個人資料，請您安心成為命運好好玩的會員。
        2.經註冊會員成功後，會員可享有命運好好玩網站電子報，及所有由命運好好玩網站提供之會員專享免費資源。
        3.註冊時個人資料應填寫詳實，因登錄不實，所造成的個人損失，本網概不負責，若會員之不當行為，致使對命運好好玩網站造成危害，會員申請人在此聲明放棄所有抗告權利，並承擔所有相關的法律及賠償責任，命運好好玩網站亦得保留隨時終止會員資格及使用各項服務資格之權利。
        4.任何未經 命運好好玩網站書面授權，非法重製、傳布、使用、引用命運好好玩網站內容資料者，命運好好玩網站得保留隨時終止會員資格及使用各項服務資格之權利，會員申請人在此聲明放棄所有抗告權利，並承擔所有相關的法律及賠償責任。
        5.若會員主動將帳號與密碼洩露或提供予第三人，及會員因保管不慎而致使會員帳號密碼遭盜用，所造成之損失，命運好好玩網站 概不負責。若會員帳號或密碼，發現有任何使用安全之異常情事，應隨即向命運好好玩網站通告。
        6.命運好好玩網站保留隨時修改本會員申請同意書內容條款之權利，命運好好玩網站逢修改會員申請同意書條款時，會將相關資訊公佈於命運好好玩網站，不另行做會員個別通知，會員應主動注意關切條款，若會員不同意修改的內容，應停用命運好好玩網站所提供之服務，若會員未停用命運好好玩網站提供之服務，則視為會員已同意並接受命運好好玩網站所增訂或修改之內容及條款。
                  </textarea>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div align="center">
                                <p>請詳閱會員條款，以保障會員權益。並選擇同意後送出。 </p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <div align="center">
                                <img src="../images/Login-go2.gif" width="250" height="47" style="cursor: pointer;" id="btnRegister"></div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <div align="center"></div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <p>&nbsp;</p>

        </div>
    </div>

    <div id="popupEvent" class="popup_container" style="display: none;">
        <div class="popupFrame">
            <span class="link_popupclose" onclick="closePopup(event)">X</span>
            <div class="popupContent">
                <%=bannerClass.Get_banner_by_classid ("30") %>
            </div>
        </div>
    </div>
    <script>
        function showPopup() {
            var oPopup = $("#popupEvent");
            if (oPopup == undefined || oPopup == null) return;
            var spaceHeight = $(window).height() - oPopup.height();
            window.scrollTo(0, $(window).scrollTop());
            var top = spaceHeight / 2;
            var left = ($(window).width() - oPopup.width()) / 2;

            oPopup.css({ top: top, left: left });
            oPopup.show();
        }

        function closePopup(evt) {
            $.get('libs/Get_session.ashx?str_SESSION_Key=LoginGift', function (data) {
                if (data == 'Y') {
                    alert('恭喜您獲得購物金100元！');
                }

                var oRoot = $(evt.target).parents("div[id='popupEvent']");
                oRoot.hide();
                var page = GetURLParameter("returnUrl");
                if (GetURLParameter("page") != undefined) {                    
                    page = GetURLParameter("page");               
                    page = base64_decode(page);
                }
                if (page == undefined || page =='')  {
                    location.href = "memberData.aspx?=_" + new Date().getTime().toString();
                } else {
                  
                    var s = page;                                
                    if (s.indexOf('?') != -1) s  =s + "&_=" + new Date().getTime().toString();
                    else s = page + "?_=" + new Date().getTime().toString();                   
                    location.href = s;
                }
            });
        }
    </script>

</asp:Content>
