﻿Date.prototype.yyyymmdd = function () {
    var mm = this.getMonth() + 1; // getMonth() is zero-based
    var dd = this.getDate();
    return [this.getFullYear() + ".",
    (mm > 9 ? '' : '0') + mm + ".",
    (dd > 9 ? '' : '0') + dd
    ].join('');
};

jQuery.postJSON = function (url, para, contentType, callback) {
    if (contentType == null || contentType == '') contentType = "text/xml";
    $.ajax({
        type: 'POST',
        url: url,
        data: para,
        dataType: "json",
        contentType: contentType,
        async: false,
        cache: false,
        success: function (data) { callback(data); },
        error: function (xhr, error) { callback(''); }
    });
};
jQuery.post = function (url, para, callback) {
    $.ajax({
        type: 'POST',
        url: url,
        data: para,
        dataType: "text",
        async: false,
        cache: false,
        success: function (data) { callback(data); },
        error: function (xhr, error) { callback(''); }
    });
};
//if (!jQuery.isEmptyObject(f.price1)) {
//    e = f.price1
//}
function initHeaderLink() {
    $("#link_home").prop("href", "index.html");
    $("#link_cart").prop("href", "shoppingcart-page-1.aspx");
    $("#link_collect").prop("href", "collect-list.html");
    $("#form_search").prop("action", "product-search.aspx")
}
function initFooter() {
    $(".footer").load("footer.html")
}

function base64_encode(s) { return Base64.encode(s); }
function base64_decode(s) { return Base64.decode(s); }
var Base64 = {
    _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
    encode: function (c) {
        var a = "";
        var k, h, f, j, g, e, d;
        var b = 0;
        c = Base64._utf8_encode(c);
        while (b < c.length) {
            k = c.charCodeAt(b++);
            h = c.charCodeAt(b++);
            f = c.charCodeAt(b++);
            j = k >> 2;
            g = ((k & 3) << 4) | (h >> 4);
            e = ((h & 15) << 2) | (f >> 6);
            d = f & 63;
            if (isNaN(h)) {
                e = d = 64
            } else {
                if (isNaN(f)) {
                    d = 64
                }
            }
            a = a + this._keyStr.charAt(j) + this._keyStr.charAt(g) + this._keyStr.charAt(e) + this._keyStr.charAt(d)
        }
        return a
    },
    decode: function (c) {
        var a = "";
        var k, h, f;
        var j, g, e, d;
        var b = 0;
        c = c.replace(/[^A-Za-z0-9\+\/\=]/g, "");
        while (b < c.length) {
            j = this._keyStr.indexOf(c.charAt(b++));
            g = this._keyStr.indexOf(c.charAt(b++));
            e = this._keyStr.indexOf(c.charAt(b++));
            d = this._keyStr.indexOf(c.charAt(b++));
            k = (j << 2) | (g >> 4);
            h = ((g & 15) << 4) | (e >> 2);
            f = ((e & 3) << 6) | d;
            a = a + String.fromCharCode(k);
            if (e != 64) {
                a = a + String.fromCharCode(h)
            }
            if (d != 64) {
                a = a + String.fromCharCode(f)
            }
        }
        a = Base64._utf8_decode(a);
        return a
    },
    _utf8_encode: function (b) {
        b = b.replace(/\r\n/g, "\n");
        var a = "";
        for (var e = 0; e < b.length; e++) {
            var d = b.charCodeAt(e);
            if (d < 128) {
                a += String.fromCharCode(d)
            } else {
                if ((d > 127) && (d < 2048)) {
                    a += String.fromCharCode((d >> 6) | 192);
                    a += String.fromCharCode((d & 63) | 128)
                } else {
                    a += String.fromCharCode((d >> 12) | 224);
                    a += String.fromCharCode(((d >> 6) & 63) | 128);
                    a += String.fromCharCode((d & 63) | 128)
                }
            }
        }
        return a
    },
    _utf8_decode: function (a) {
        var b = "";
        var d = 0;
        var e = c1 = c2 = 0;
        while (d < a.length) {
            e = a.charCodeAt(d);
            if (e < 128) {
                b += String.fromCharCode(e);
                d++
            } else {
                if ((e > 191) && (e < 224)) {
                    c2 = a.charCodeAt(d + 1);
                    b += String.fromCharCode(((e & 31) << 6) | (c2 & 63));
                    d += 2
                } else {
                    c2 = a.charCodeAt(d + 1);
                    c3 = a.charCodeAt(d + 2);
                    b += String.fromCharCode(((e & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                    d += 3
                }
            }
        }
        return b
    }
};
function getUrlValue() {
    var a = new Array();
    if (window.location.search != undefined) {
        var c = window.location.search.substring(1, window.location.search.length).split("&");
        for (var b in c) {
            var e = c[b];
            var d = e.indexOf("=");
            if (d >= 0) {
                a[e.substr(0, d)] = e.substr(d + 1, e.length)
            }
        }
    }
    return a
}
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
function GetURLParameter(a) {
    var b = getUrlValue();
    return b[a]
}
function validEmail(v) {
    if (v.indexOf(' ') != -1) {
        alert('email不可以有空白符號');
        return false;
    }
    if (v.indexOf(',') != -1) {
        alert('email不可以有","符號');
        return false;
    }
    var b = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    return (v.match(b) == null) ? false : true
}


//fb login
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

function RemoveHTML(strText) {

    var regEx = /<[^>]*>/g;

    return strText.replace(regEx, "");

}

function setInputStyle(a, b, msg) {
    //  b.prop("placeholder", d);
    switch (a) {
        case "reset":
            //     b.parent().prop("class", "form-group");
            var c = b.next();
            c.remove();
            break;
        case "warning":
            //     b.parent().prop("class", "form-group has-warning has-feedback");
            alert(msg);
            b.focus();
            break;
        case "error":
            //   b.parent().prop("class", "form-group has-error has-feedback");
            alert(msg);
            b.focus();
            break;
    }
}

function mytemplate(template, data) {
    var b = template;
    var c = new Array();
    var a = "";
    $.each(data, function (i, item) {
        a = b;
        $.each(item, function (name, key) {
            if (key == null) key = "";
            a = a.replace(new RegExp("@" + name + "@", 'g'), key);
        });
        c.push(a)

    });
    return c.join("");
}


$(document).ready(function () {
    //    if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
    //$(this).removeAttr('width')
    //$(this).removeAttr('height'); 
    // }  
    $('.post-content img').each(function () {
        var str = $(this).attr("style") == undefined ? "" : $(this).attr("style");
        $(this).removeAttr('style')
        if (str.indexOf("float: none; display: block; margin-left: auto; margin-right: auto;") != -1) {
            $(this).attr('style', 'float: none; display: block; margin-left: auto; margin-right: auto;');
        }


    });

});
$(document).ready(function () {
    text = $(document).find("title").text();
    var dataValue = {};


    //分享至臉書
    $(".share-fb").click(function () {
        dataValue = { "id": $(this).data('item'), "kind": $(this).attr('title'), "url": encodeURIComponent(location.href) };
        $.postJSON('/api/article/SocialShare', JSON.stringify(dataValue), 'application/json; charset=utf-8', function (result) { });
        window.open('https://www.facebook.com/share.php?u='.concat(encodeURIComponent(location.href)), "_blank", "toolbar=yes,location=yes, directories=no, status=no,menubar=yes,scrollbars=yes,esizable=no, copyhistory=yes, width=600,  height=400")
    })
    $(".share-twitter").click(function () {
        dataValue = { "id": $(this).data('item'), "kind": $(this).attr('title'), "url": encodeURIComponent(location.href) };
        $.postJSON('/api/article/SocialShare', JSON.stringify(dataValue), 'application/json; charset=utf-8', function (result) { });
        window.open('https://twitter.com/share?text=' + text + '&url='.concat(encodeURIComponent(location.href)), "_blank", "toolbar=yes,location=yes, directories=no, status=no,menubar=yes,scrollbars=yes,esizable=no, copyhistory=yes, width=600,  height=400")
    })
    $(".share-google").click(function () {
        dataValue = { "id": $(this).data('item'), "kind": $(this).attr('title'), "url": encodeURIComponent(location.href) };
        $.postJSON('/api/article/SocialShare', JSON.stringify(dataValue), 'application/json; charset=utf-8', function (result) { });
        window.open('https://plus.google.com/share?url='.concat(encodeURIComponent(location.href)), "_blank", "toolbar=yes,location=yes, directories=no, status=no,menubar=yes,scrollbars=yes,esizable=no, copyhistory=yes, width=600,  height=400")
    })
    $(".share-print").click(function () {
        dataValue = { "id": $(this).data('item'), "kind": $(this).attr('title'), "url": encodeURIComponent(location.href) };
        $.postJSON('/api/article/SocialShare', JSON.stringify(dataValue), 'application/json; charset=utf-8', function (result) { });
        window.open('https://pinterest.com/pin/create/button/?description=' + text + '&url='.concat(encodeURIComponent(location.href)), "_blank", "toolbar=yes,location=yes, directories=no, status=no,menubar=yes,scrollbars=yes,esizable=no, copyhistory=yes, width=600,  height=400")
    })

    $(".share-collection").click(function () {
        articleId = $(this).data('item');
        dataValue = { "p_ACTION": "CheckLogin", "_": new Date().getTime() };
        $.post('/lib/member_handle.ashx', {
            "p_ACTION": "CheckLogin", "_": new Date().getTime()
        }, function (data) {
            if (data == "") {
                alert('請先登入或加入會員');
            }
            else {
                data = JSON.parse(data);

                dataValue = { "id": articleId, "memberid": data.Memberid };
                $.postJSON('/api/article/AddCollection', JSON.stringify(dataValue), 'application/json; charset=utf-8', function (result) { });

            }
        });


    })
    $('input[name="s1"]').keypress(function (e) {
        if (e.which == 13) {
            $('input[name="header-search"]').trigger("click");
            return false;    //<---- Add this line
        }
    });
    $('input[name="s"]').keypress(function (e) {
        if (e.which == 13) {
            $('input[name="header-search"]').trigger("click");
            return false;    //<---- Add this line
        }
    });
    $('input[name="header-search"]').click(function () {
        var text = "";

        if ($('input[name="s1"]') != undefined) {
            text = $('input[name="s1"]').val();
        }
        if ($('input[name="s"]').val() != "") {
            text = $('input[name="s"]').val();
        }

        location.href = '/search/' + text;
        return false;
    })
    $('#Emailregist').click(function () {
        var text = $('#InputEmail').val();
        $.post('/lib/registemail.ashx', { "email": text }, function (result) {
            if (result != "") {

                alert(result);

            }
        });

    })



});

