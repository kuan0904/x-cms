var RealPath = "";
var Person = null;
function base64_encode(a) {
    return Base64.encode(a)
}
function base64_decode(a) {
    return Base64.decode(a)
}
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

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }
    return "";
}

function checkLogin() {
    var pathname = window.location.pathname.split(".")[0];
    var tmp = pathname.replace(getPageName(), "");
    tmp = tmp.replace("/superluckyv2", "");
    var tmp1 = tmp.split("/");
    var tmp2 = "";
    for (i=0;i<=tmp1.length-1;i++) { if(tmp1[i] != "") tmp2 += "../"; }

    RealPath  = tmp2;

    //$.postJSON(tmp2 + 'libs/member_handle.ashx', { "p_ACTION": "CheckLogin", "_": new Date().getTime() }, function (data) {
    $.postJSON('../libs/member_handle.ashx', { "p_ACTION": "CheckLogin", "_": new Date().getTime() }, function (data) {
       
        if (data != "") {
            Person = data;           
            Person = JSON.parse(Person);
           
        }
    });     
}

$(document).ready(function () {
    //checkLogin();
   
    //if (Person != null) {
    //    $("#topURL10").hide();
    //    $("#topURL12").show();
    //    $("#topURL12").text('您好 ' + Person.name + ' 登出');

    //} else {
    //    $("#topURL12").hide();
    //    $("#topURL10").show();
    //}

});

function UrlExists(url) {
    var reslut = false;

    $.ajax({
        type: "HEAD",
        cache: false,
        async: false,
        url: url + "?=_" + new Date().getTime().toString(),
        success: function (data) {
            reslut = true;
        },
        error: function (request, status) {
        }
    });
    return reslut;
}

function getPageName() {
    var url = window.location.pathname;
    var index = url.lastIndexOf("/") + 1;
    var filenameWithExtension = url.substr(index);
    var filename = filenameWithExtension.split(".")[0]; 
    return filename;                                    
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
    var r = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    return (v.match(r) == null) ? false : true;
}

function getBrowserHeight() { if (/msie/.test(navigator.userAgent.toLowerCase())) return document.compatMode == "CSS1Compat" ? document.documentElement.clientHeight : document.body.clientHeight; else return self.innerHeight; }
function getBrowserWidth() { if (/msie/.test(navigator.userAgent.toLowerCase())) return document.compatMode == "CSS1Compat" ? document.documentElement.clientWidth : document.body.clientWidth; else return self.innerWidth; }
function GetURLParameter(sParam) { var sPageURL = window.location.search.substring(1); var sURLVariables = sPageURL.split('&'); for (var i = 0; i < sURLVariables.length; i++) { var sParameterName = sURLVariables[i].split('='); if (sParameterName[0] == sParam) return sParameterName[1]; } }

function validatorDate(value) { var check = false; value = value.replace("/", "").replace(/(\d{3})(\d{2})(\d{2})/, "$1/$2/$3"); var re = /^\d{3}\/\d{1,2}\/\d{1,2}$/; if (re.test(value)) { var adata = value.split('/'); var yy = parseInt(adata[0], 10) + 1911; var mm = parseInt(adata[1], 10); var dd = parseInt(adata[2], 10); var xdata = new Date(yy, mm - 1, dd); if ((xdata.getFullYear() == yy) && (xdata.getMonth() == mm - 1) && (xdata.getDate() == dd)) check = true; else check = false; } else { check = false; } return check; }
function validatorDate1(value) { var check = false; value = value.replace("/", "").replace(/(\d{4})(\d{2})(\d{2})/, "$1/$2/$3"); var re = /^\d{4}\/\d{1,2}\/\d{1,2}$/; if (re.test(value)) { var adata = value.split('/'); var yy = parseInt(adata[0], 10); var mm = parseInt(adata[1], 10); var dd = parseInt(adata[2], 10); var xdata = new Date(yy, mm - 1, dd); if ((xdata.getFullYear() == yy) && (xdata.getMonth() == mm - 1) && (xdata.getDate() == dd)) check = true; else check = false; } else { check = false; } return check; }

function randomString() { var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz"; var string_length = 8; var randomstring = ''; for (var i = 0; i < string_length; i++) { var rnum = Math.floor(Math.random() * chars.length); randomstring += chars.substring(rnum, rnum + 1); } return randomstring; }
function generateQuickGuid() { return Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15); }

var Base64 = {
    _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
    encode: function (input) { var output = ""; var chr1, chr2, chr3, enc1, enc2, enc3, enc4; var i = 0; input = Base64._utf8_encode(input); while (i < input.length) { chr1 = input.charCodeAt(i++); chr2 = input.charCodeAt(i++); chr3 = input.charCodeAt(i++); enc1 = chr1 >> 2; enc2 = ((chr1 & 3) << 4) | (chr2 >> 4); enc3 = ((chr2 & 15) << 2) | (chr3 >> 6); enc4 = chr3 & 63; if (isNaN(chr2)) { enc3 = enc4 = 64; } else if (isNaN(chr3)) { enc4 = 64; } output = output + this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) + this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4); } return output; },
    decode: function (input) { var output = ""; var chr1, chr2, chr3; var enc1, enc2, enc3, enc4; var i = 0; input = input.replace(/[^A-Za-z0-9\+\/\=]/g, ""); while (i < input.length) { enc1 = this._keyStr.indexOf(input.charAt(i++)); enc2 = this._keyStr.indexOf(input.charAt(i++)); enc3 = this._keyStr.indexOf(input.charAt(i++)); enc4 = this._keyStr.indexOf(input.charAt(i++)); chr1 = (enc1 << 2) | (enc2 >> 4); chr2 = ((enc2 & 15) << 4) | (enc3 >> 2); chr3 = ((enc3 & 3) << 6) | enc4; output = output + String.fromCharCode(chr1); if (enc3 != 64) { output = output + String.fromCharCode(chr2); } if (enc4 != 64) { output = output + String.fromCharCode(chr3); } } output = Base64._utf8_decode(output); return output; },
    _utf8_encode: function (string) { string = string.replace(/\r\n/g, "\n"); var utftext = ""; for (var n = 0; n < string.length; n++) { var c = string.charCodeAt(n); if (c < 128) { utftext += String.fromCharCode(c); } else if ((c > 127) && (c < 2048)) { utftext += String.fromCharCode((c >> 6) | 192); utftext += String.fromCharCode((c & 63) | 128); } else { utftext += String.fromCharCode((c >> 12) | 224); utftext += String.fromCharCode(((c >> 6) & 63) | 128); utftext += String.fromCharCode((c & 63) | 128); } } return utftext; },
    _utf8_decode: function (utftext) { var string = ""; var i = 0; var c = c1 = c2 = 0; while (i < utftext.length) { c = utftext.charCodeAt(i); if (c < 128) { string += String.fromCharCode(c); i++; } else if ((c > 191) && (c < 224)) { c2 = utftext.charCodeAt(i + 1); string += String.fromCharCode(((c & 31) << 6) | (c2 & 63)); i += 2; } else { c2 = utftext.charCodeAt(i + 1); c3 = utftext.charCodeAt(i + 2); string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63)); i += 3; } } return string; }
}

Date.prototype.getWeek = function () { var dt = new Date(this.getFullYear(), 0, 1); return Math.ceil((((this - dt) / 86400000) + dt.getDay() + 1) / 7); };
Date.prototype.DateAdd = function (interval, number) { switch (interval.toLowerCase()) { case "y": return new Date(this.setFullYear(this.getFullYear() + number)); case "m": return new Date(this.setMonth(this.getMonth() + number)); case "d": return new Date(this.setDate(this.getDate() + number)); case "w": return new Date(this.setDate(this.getDate() + 7 * number)); case "h": return new Date(this.setHours(this.getHours() + number)); case "n": return new Date(this.setMinutes(this.getMinutes() + number)); case "s": return new Date(this.setSeconds(this.getSeconds() + number)); case "l": return new Date(this.setMilliseconds(this.getMilliseconds() + number)); } }
Date.prototype.dateDiff = function (interval, objDate) { var dtEnd = new Date(objDate); if (isNaN(dtEnd)) return undefined; switch (interval) { case "s": return parseInt((dtEnd - this) / 1000); case "n": return parseInt((dtEnd - this) / 60000); case "h": return parseInt((dtEnd - this) / 3600000); case "d": return parseInt((dtEnd - this) / 86400000); case "w": return parseInt((dtEnd - this) / (86400000 * 7)); case "m": return (dtEnd.getMonth() + 1) + ((dtEnd.getFullYear() - this.getFullYear()) * 12) - (this.getMonth() + 1); case "y": return dtEnd.getFullYear() - this.getFullYear(); } }

$.monthLastDay = function () { var aDate = new Date(); var y = aDate.getFullYear(); var m = aDate.getMonth() + 1; return (new Date(y, m, 0)); }
$.LeftPad = function (i, l, s) { var o = i.toString(); if (!s) { s = '0'; } while (o.length < l) { o = s + o; } return o; }
$.RightPad = function (i, l, s) { var o = i.toString(); if (!s) { s = '0'; } while (o.length < l) { o = o + s; } return o; }

var isDebug = true;

jQuery.postJSON = function(url, para, callback) { 
    $.ajax({ 
        type: 'POST', 
        url: url, 
        data: para, 
        dataType: "json", 
        async: false, 
        cache: false, 
        success: function(data) { callback(data); },
        error: function(xhr, error) { callback(''); }         
    }); 
};
jQuery.post = function(url, para, callback) { 
    $.ajax({ 
        type: 'POST', 
        url: url, 
        data: para, 
        dataType: "text", 
        async: false, 
        cache: false, 
        success: function(data) { callback(data); }, 
        error: function(xhr, error) { callback(''); }         
    }); 
};

jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)\./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();

(function (w) { var c = 'assert,clear,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,table,time,timeEnd,timeStamp,trace,warn'.split(','), noop = function () { }; if (isDebug) { w.console = w.console || (function (len) { var ret = {}; while (len--) { ret[c[len]] = noop; } return ret; }(c.length)); } else { w.console = (function (len) { var ret = {}; while (len--) { ret[c[len]] = noop; } return ret; }(c.length)); } })(window);

(function ($) { $.fn.getInputType = function () { return this[0].tagName.toString().toLowerCase() === "input" ? $(this[0]).prop("type").toLowerCase() : this[0].tagName.toLowerCase(); };  }(jQuery));
(function ($) { $.fn.single_double_click = function (single_click_callback, double_click_callback, timeout) { return this.each(function () { var clicks = 0, self = this; var arr = ["INPUT", "SELECT", "TEXTAREA", "IMG"]; jQuery(this).click(function (event) { clicks++; if (clicks == 1) { setTimeout(function () { var nodeName = event.target.nodeName; if (jQuery.inArray(nodeName, arr) == -1) { if (clicks == 1) single_click_callback.call(self, event); else double_click_callback.call(self, event); } clicks = 0; }, timeout || 300); } }); }); } }(jQuery));

(function ($) { $.fn.genQuerySchema = function () { var xmlData = "<DataItem>"; $.each(this, function (index, value) { var col_label = value[0]; var col_value = value[1]; xmlData += "<" + col_label + ">" + col_value + "</" + col_label + ">"; }); xmlData += "</DataItem>"; return base64_encode(xmlData); }; }(jQuery));
(function ($) { $.fn.appendGenQuerySchema = function (root, elmid) { var xmlData = "<MUTILE id=\"" + elmid + "\">"; var master = base64_decode(root); $.each(this, function (index, value) { var col_label = value[0]; var col_value = value[1]; xmlData += "<" + col_label + ">" + col_value + "</" + col_label + ">"; }); xmlData += "</MUTILE>"; var xmlString = ""; var xmlDoc = $.parseXmlExt(master); var DataItemElement = $(xmlDoc).find('DataItem'); $($.parseXmlExt(xmlData)).find("MUTILE").appendTo(DataItemElement); xmlString = $(xmlDoc).xml(); return base64_encode(xmlString); }; }(jQuery));
(function ($) { $.fn.appendGenQuerySchema1 = function (root, elmid_s, elmid_d, elmname_s, elmname_d) { var xmlData = "<" + elmname_d + " id=\"" + elmid_d + "\">"; var master = base64_decode(root); $.each(this, function (index, value) { var col_label = value[0]; var col_value = value[1]; xmlData += "<" + col_label + ">" + col_value + "</" + col_label + ">"; }); xmlData += "</" + elmname_d + ">"; var xmlString = ""; var xmlDoc = $.parseXmlExt(master); var DataItemElement = $(xmlDoc).find(elmname_s + '[id="' + elmid_s + '"]'); $($.parseXmlExt(xmlData)).find(elmname_d).appendTo(DataItemElement); xmlString = $(xmlDoc).xml(); return base64_encode(xmlString); }; }(jQuery));
(function ($) {
    $.fn.setSchemaValue = function (row) {
        $.each(this, function (index, value) {
            var col_label = value[0]; var col_type = value[1]; var col_value = value[2]; var col_object = value[3];
            if (col_value == null) {
                if (col_type == "S") col_value = $.trim(row.children(col_label).text());
                else if (col_type == "D3") col_value = $.trim(row.children(col_label).text()).replace(/(\d{3})(\d{2})(\d{2})/, "$1/$2/$3");
                else if (col_type == "D4") col_value = $.trim(row.children(col_label).text()).replace(/(\d{4})(\d{2})(\d{2})/, "$1/$2/$3");
                else if (col_type == "N1") col_value = Number($.trim(row.children(col_label).text()));
                else if (col_type == "N2") col_value = $.number($.trim(row.children(col_label).text()));
            } if (col_object != null) {
                var col_object_type = $(col_object).getInputType();
                if ((col_object_type == "text") || (col_object_type == "select") || (col_object_type == "textarea") || (col_object_type == "hidden")) {
                    $(col_object).val(col_value);
                } else if (col_object_type == "radio") {
                    switch (col_value) { case "true": case "yes": case "1": $(col_object).prop("checked", true); break; case "false": case "no": case "0": $(col_object).prop("checked", false); break; }
                } else if (col_object_type == "checkbox") {
                    if ($(col_object).length == 1) {
                        switch (col_value.toLowerCase()) {
                            case "y": case "true": case "yes": case "1": $(col_object).prop("checked", true); break;
                            case "n": case "false": case "no": case "0": $(col_object).prop("checked", false); break;
                        }
                    } else { $(col_object).each(function (index) { if ($(this).val() == col_value) $(this).prop('checked', true); }); }
                } else if (col_object_type == "select") { $(col_object).find("option[value=" + col_value + "]").prop('selected', true); } else { $(col_object).html(col_value); }
            } value[2] = col_value;
        });
    };
}(jQuery));

function inserAT(textarea, string) { var rangeData = { text: "", start: 0, end: 0 }; textarea.focus(); if (textarea.setSelectionRange) { rangeData.start = textarea.selectionStart; rangeData.end = textarea.selectionEnd; rangeData.text = (rangeData.start != rangeData.end) ? textarea.value.substring(rangeData.start, rangeData.end) : ""; } else if (document.selection) { var i; oS = document.selection.createRange(), oR = document.body.createTextRange(); oR.moveToElementText(textarea); rangeData.text = oS.text; rangeData.bookmark = oS.getBookmark(); for (i = 0; oR.compareEndPoints('StartToStart', oS) < 0 && oS.moveStart("character", -1) !== 0; i++) { if (textarea.value.charAt(i) == '\n\r') { i++; } } rangeData.start = i; rangeData.end = rangeData.text.length + rangeData.start; } $(textarea).val($(textarea).val().substr(0, i) + string + $(textarea).val().substr(i)); caretTo(textarea, i + 1); }
function caretTo(el, index) { if (el.createTextRange) { var range = el.createTextRange(); range.move("character", index); range.select(); } else if (el.selectionStart != null) { el.focus(); el.setSelectionRange(index, index); } }

(function ($) {
    function mnpXml(opCode, xmlStr) { return this.each(function () {  if (typeof xmlStr != "string") return; if (!jQuery.isXMLDoc(this)) return; var node = $.parseXmlExt(xmlStr).firstChild.cloneNode(true); switch (opCode) { case "append": this.appendChild(node); break; case "prepend": if (this.childNodes.length > 0) this.insertBefore(node, this.firstChild); else this.appendChild(node); break; case "after": if (this.nextSibling) this.parentNode.insertBefore(node, this.nextSibling); else this.parentNode.appendChild(node); break; case "before": this.parentNode.insertBefore(node, this); break; } }); }
    $.fn.extend({ appendXml: function (s) { return mnpXml.call(this, "append", s); }, prependXml: function (s) { return mnpXml.call(this, "prepend", s); }, afterXml: function (s) { return mnpXml.call(this, "after", s); }, beforeXml: function (s) { return mnpXml.call(this, "before", s); }, xml: function () { var elem = this[0]; return elem.xml || (new XMLSerializer()).serializeToString(elem); }, innerXml: function () { var s = this.xml(); var i = s.indexOf(">"), j = s.lastIndexOf("<"); if (j > i) return s.substring(i + 1, j); else return ""; } });
    $.extend(jQuery, { parseXmlExt: function (xmlStr) { if (window.ActiveXObject) { var xd = new ActiveXObject("Microsoft.XMLDOM"); xd.async = false; xd.loadXML(xmlStr); return xd; } else if (typeof DOMParser != "undefined") { var xd = new DOMParser().parseFromString(xmlStr, "text/xml"); return xd; } else return null; }, toXml: function (obj, nodeName, useAttr) { var x = $($.parseXmlExt("<" + nodeName + " />")); var n = x.find(":first"); for (var p in obj) { if (useAttr) n.attr(p, obj[p]); else n.appendXml("<" + p + " />").find(p).text(obj[p]); } return x[0]; } });
})(jQuery);

;(function($) {
	$.timer = function(func, time, autostart) {	
	 	this.set = function(func, time, autostart) {
	 		this.init = true;
	 	 	if(typeof func == 'object') {
		 	 	var paramList = ['autostart', 'time'];
	 	 	 	for(var arg in paramList) {if(func[paramList[arg]] != undefined) {eval(paramList[arg] + " = func[paramList[arg]]");}};
 	 			func = func.action;
	 	 	}
	 	 	if(typeof func == 'function') {this.action = func;}
		 	if(!isNaN(time)) {this.intervalTime = time;}
		 	if(autostart && !this.isActive) {
			 	this.isActive = true;
			 	this.setTimer();
		 	}
		 	return this;
	 	};
	 	this.once = function(time) {
			var timer = this;
	 	 	if(isNaN(time)) {time = 0;}
			window.setTimeout(function() {timer.action();}, time);
	 		return this;
	 	};
		this.play = function(reset) {
			if(!this.isActive) {
				if(reset) {this.setTimer();}
				else {this.setTimer(this.remaining);}
				this.isActive = true;
			}
			return this;
		};
		this.pause = function() {
			if(this.isActive) {
				this.isActive = false;
				this.remaining -= new Date() - this.last;
				this.clearTimer();
			}
			return this;
		};
		this.stop = function() {
			this.isActive = false;
			this.remaining = this.intervalTime;
			this.clearTimer();
			return this;
		};
		this.toggle = function(reset) {
			if(this.isActive) {this.pause();}
			else if(reset) {this.play(true);}
			else {this.play();}
			return this;
		};
		this.reset = function() {
			this.isActive = false;
			this.play(true);
			return this;
		};
		this.clearTimer = function() {
			window.clearTimeout(this.timeoutObject);
		};
	 	this.setTimer = function(time) {
			var timer = this;
	 	 	if(typeof this.action != 'function') {return;}
	 	 	if(isNaN(time)) {time = this.intervalTime;}
		 	this.remaining = time;
	 	 	this.last = new Date();
			this.clearTimer();
			this.timeoutObject = window.setTimeout(function() {timer.go();}, time);
		};
	 	this.go = function() {
	 		if(this.isActive) {
	 			this.action();
	 			this.setTimer();
	 		}
	 	};

	 	if(this.init) {
	 		return new $.timer(func, time, autostart);
	 	} else {
			this.set(func, time, autostart);
	 		return this;
	 	}
	};
})(jQuery);

;(function($){
	$.fn.extend({
		adsRotator: function() {
			var timer = null;
			var i = 5000;
			var showIndex = 0;
			var defaultZ = 10;
			var fadeOutSpeed = 3000;
			var fadeInSpeed = 3000;
		
			var o = $(this);
			var aditems = o.find("li[class='aditem']");
			var items = aditems.length;
			
			aditems.on("mouseover",function(){
				if (timer != null) timer.pause();
			});
			aditems.on("mouseout",function(){
				if (timer != null) timer.play();
			});
			aditems.on("click",function(){
				//console.log($(this).attr("url"));
                if ($(this).attr("url") == "N") location.href = $(this).attr("url");
                else window.open($(this).attr("url"), '_blank');
			});
			
			if (items > 0) {
				aditems.css({
					zIndex: defaultZ - 1,
					opacity: 0,
					position: 'absolute'
				}).eq(showIndex).css({
					zIndex: defaultZ,
					opacity: 1,
					position: 'absolute'
				});

                /*          
                aditems.find("ul[class='controlA']").find("li").css({
                    opacity: 0
                });
                */

				aditems.find("ul[class='controlA']").find("li").on("mouseover",function(){
					timer.pause();
					aditems.stop().fadeTo(0, 0, function() {
					}).css('zIndex', defaultZ - 1);
					aditems.eq($(this).index()).stop().fadeTo(0, 1, function() {
					}).css('zIndex', defaultZ);
					showIndex = $(this).index();
				});

				aditems.find("ul[class='controlA']").find("li").on("mouseout",function(){
					timer.play();
				});
				
				timer = $.timer(function() {
					timer.pause();
					showIndex++;
					if (showIndex > items-1) showIndex = 0;
					
					aditems.stop().fadeTo(fadeOutSpeed, 0, function() {
					}).css('zIndex', defaultZ - 1);
					aditems.eq(showIndex).stop().fadeTo(fadeInSpeed, 1, function() {
					}).css('zIndex', defaultZ);
										
					timer.play();
				}, i, true);
			} 
		}
	});
})(jQuery);

;( function ( $ ){
  $.fn.addBack = $.fn.addBack || $.fn.andSelf;

  $.fn.extend({

    actual : function ( method, options ){
      // check if the jQuery method exist
      if( !this[ method ]){
        throw '$.actual => The jQuery method "' + method + '" you called does not exist';
      }

      var defaults = {
        absolute      : false,
        clone         : false,
        includeMargin : false
      };

      var configs = $.extend( defaults, options );

      var $target = this.eq( 0 );
      var fix, restore;

      if( configs.clone === true ){
        fix = function (){
          var style = 'position: absolute !important; top: -1000 !important; ';

          // this is useful with css3pie
          $target = $target.
            clone().
            attr( 'style', style ).
            appendTo( 'body' );
        };

        restore = function (){
          // remove DOM element after getting the width
          $target.remove();
        };
      }else{
        var tmp   = [];
        var style = '';
        var $hidden;

        fix = function (){
          // get all hidden parents
          $hidden = $target.parents().addBack().filter( ':hidden' );
          style   += 'visibility: hidden !important; display: block !important; ';

          if( configs.absolute === true ) style += 'position: absolute !important; ';

          // save the origin style props
          // set the hidden el css to be got the actual value later
          $hidden.each( function (){
            // Save original style. If no style was set, attr() returns undefined
            var $this     = $( this );
            var thisStyle = $this.attr( 'style' );

            tmp.push( thisStyle );
            // Retain as much of the original style as possible, if there is one
            $this.attr( 'style', thisStyle ? thisStyle + ';' + style : style );
          });
        };

        restore = function (){
          // restore origin style values
          $hidden.each( function ( i ){
            var $this = $( this );
            var _tmp  = tmp[ i ];

            if( _tmp === undefined ){
              $this.removeAttr( 'style' );
            }else{
              $this.attr( 'style', _tmp );
            }
          });
        };
      }

      fix();
      // get the actual value with user specific methed
      // it can be 'width', 'height', 'outerWidth', 'innerWidth'... etc
      // configs.includeMargin only works for 'outerWidth' and 'outerHeight'
      var actual = /(outer)/.test( method ) ?
        $target[ method ]( configs.includeMargin ) :
        $target[ method ]();

      restore();
      // IMPORTANT, this plugin only return the value of the first element
      return actual;
    }
  });
})( jQuery );














function imageDynamicResize(oImage) { oImage.hide(); oImage.removeAttr('width'); oImage.removeAttr('height'); var imgW = oImage.width(); var imgH = oImage.height(); var w = oImage.attr("_w")/imgW; var h = oImage.attr("_h")/imgH; var pre = 1; if (w>h) pre = h; else pre = w;  if (w>1 && h>1) { pre = 1; }     imgW = imgW*pre; imgH = imgH*pre; oImage.width(imgW); oImage.height(imgH); var top_margin = (oImage.attr("_h") -imgH)/2; var left_margin = (oImage.attr("_w") - imgW)/2; oImage.css( 'margin-top' , top_margin); oImage.css( 'margin-left' , left_margin); oImage.show(); }   
