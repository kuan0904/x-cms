var p_LIMIT = 8;
var p_PAGE = 1;

$(document).ready(function () {
	getPopular();
});

function getPopular() {
    $.post('../libs/php/process/cls.member.news.php', {"p_ACTION": "List", "p_PAGE": "1", "p_LIMIT": p_LIMIT, "_": new Date().getTime() }, function (data) {
        $("#wContent").html(data);
        addEvent();
	});		
}

function addEvent() {
	$("#numberpager").find("span").click(function(){
		p_PAGE = $(this).attr('num');
	    $.post('../libs/php/process/cls.member.news.php', {"p_ACTION": "List", "p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "_": new Date().getTime() }, function (data) {
	        $("#wContent").html(data);
	        addEvent();
		});		
	});	

	$("table").find("tr").find("#p_NTITLE").click(function(){
		var _ncont = $(this).attr("_ncont");
        $.getScript("../libs/js/jquery.blockUI.js")
	    .done(function() { 
	    	$("#loader").hide();
	        $.blockUI({ 
	            message: base64_decode(_ncont), 
	            css: { 
	                top:  '10px', 
	                left: (getBrowserWidth() - 700) /2 + 'px', 
	                width: '700px',
	                height: '600px',
		            'overflow-y': 'scroll',
		            'overflow-x': 'hidden'
	            },
	            onOverlayClick: $.unblockUI,
	            onUnblock: function(){ $("#loader").show(); } 
	        }); 	 			       
	    })
	    .fail(function() { alert('讀取失敗'); });
	});		
}

function btnDel(_key) {
	if(confirm("確定要刪除該筆資料嗎？")) {
	    $.post('../libs/php/process/cls.member.news.php', {"p_NID": _key, "p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "p_ACTION": "Delete", "_": new Date().getTime() }, function (data) {
	        $("#wContent").html(data);
	        addEvent();
		});			
	}
}

function btnModify(_key) {
    $.post('../libs/php/process/cls.member.news.php', {"p_NID": _key, "p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "p_ACTION": "Modify", "_": new Date().getTime() }, function (data) {
        $.getScript("//cdn.ckeditor.com/4.4.5/full/ckeditor.js")
	    .done(function() { 
	        $("#wContent").html(data);

	        CKEDITOR.replace('p_NCONT',
				{toolbarGroups: [	
			 		{ name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },			// Group's name will be used to create voice label.
					{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], groups: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
					{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], groups: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl', 'Language' ] },
					{ name: 'insert', groups: [ 'Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak', 'Iframe' ] },
					{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align' ] },
					'/',
					{ name: 'styles', groups: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
					{ name: 'colors',  groups: [ 'TextColor', 'BGColor' ] },
					{ name: 'links', groups: [ 'Link', 'Unlink', 'Anchor' ] }
				]}
	        );

			CKEDITOR.config.height = 200;	        
			CKEDITOR.config.width = 680;	
			CKEDITOR.config.filebrowserImageBrowseUrl = '../libs/js/ckfinder/ckfinder.html?Type=Images';
			CKEDITOR.config.filebrowserImageUploadUrl = '../libs/js/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Images';//可上傳圖檔

	        $.datepicker.regional['zh-TW'] = {
	            clearText: '清除', clearStatus: '清除已選日期',
	            closeText: '關閉', closeStatus: '取消選擇',
	            prevText: '<上一月', prevStatus: '顯示上個月',
	            nextText: '下一月>', nextStatus: '顯示下個月',
	            currentText: '今天', currentStatus: '顯示本月',
	            monthNames: ['一月','二月','三月','四月','五月','六月',
	            '七月','八月','九月','十月','十一月','十二月'],
	            monthNamesShort: ['一','二','三','四','五','六',
	            '七','八','九','十','十一','十二'],
	            monthStatus: '選擇月份', yearStatus: '選擇年份',
	            weekHeader: '周', weekStatus: '',
	            dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
	            dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
	            dayNamesMin: ['日','一','二','三','四','五','六'],
	            dayStatus: '設定每周第一天', dateStatus: '選擇 m月 d日, DD',
	            dateFormat: 'yy-mm-dd', firstDay: 1, 
	            initStatus: '請選擇日期', isRTL: false
	        };
	        $("#datepicker").datepicker();
	        $.datepicker.setDefaults($.datepicker.regional['zh-TW']);

	        $("#p_NDATE").datepicker({
	            beforeShow: function (input, instance) {
	            }, minDate: 0, dateFormat: 'yy-mm-dd'
	        });
	    })
	    .fail(function() { alert('讀取失敗'); });

        addEvent();        
	});	
}

function btnAdd() {
    $.post('../libs/php/process/cls.member.news.php', {"p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "p_ACTION": "Add", "_": new Date().getTime() }, function (data) {
        $.getScript("//cdn.ckeditor.com/4.4.5/full/ckeditor.js")
	    .done(function() { 
	        $("#wContent").html(data);

	        CKEDITOR.replace('p_NCONT',
				{toolbarGroups: [	
			 		{ name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },			// Group's name will be used to create voice label.
					{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], groups: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
					{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], groups: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl', 'Language' ] },
					{ name: 'insert', groups: [ 'Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak', 'Iframe' ] },
					{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align' ] },
					'/',
					{ name: 'styles', groups: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
					{ name: 'colors',  groups: [ 'TextColor', 'BGColor' ] },
					{ name: 'links', groups: [ 'Link', 'Unlink', 'Anchor' ] }
				]}
	        );

			CKEDITOR.config.height = 200;	        
			CKEDITOR.config.width = 680;	
			CKEDITOR.config.filebrowserImageBrowseUrl = '../libs/js/ckfinder/ckfinder.html?Type=Images';
			CKEDITOR.config.filebrowserImageUploadUrl = '../libs/js/ckfinder/core/connector/php/connector.php?command=QuickUpload&type=Images';//可上傳圖檔

	        $.datepicker.regional['zh-TW'] = {
	            clearText: '清除', clearStatus: '清除已選日期',
	            closeText: '關閉', closeStatus: '取消選擇',
	            prevText: '<上一月', prevStatus: '顯示上個月',
	            nextText: '下一月>', nextStatus: '顯示下個月',
	            currentText: '今天', currentStatus: '顯示本月',
	            monthNames: ['一月','二月','三月','四月','五月','六月',
	            '七月','八月','九月','十月','十一月','十二月'],
	            monthNamesShort: ['一','二','三','四','五','六',
	            '七','八','九','十','十一','十二'],
	            monthStatus: '選擇月份', yearStatus: '選擇年份',
	            weekHeader: '周', weekStatus: '',
	            dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
	            dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
	            dayNamesMin: ['日','一','二','三','四','五','六'],
	            dayStatus: '設定每周第一天', dateStatus: '選擇 m月 d日, DD',
	            dateFormat: 'yy-mm-dd', firstDay: 1, 
	            initStatus: '請選擇日期', isRTL: false
	        };
	        $("#datepicker").datepicker();
	        $.datepicker.setDefaults($.datepicker.regional['zh-TW']);

	        $("#p_NDATE").datepicker({
	            beforeShow: function (input, instance) {
	            }, minDate: 0, dateFormat: 'yy-mm-dd'
	        });
	    })
	    .fail(function() { alert('讀取失敗'); });

        addEvent();        
	});
}

function btnSubmit(_key) {
	var p_NTITLE = $("#p_NTITLE").val();
	var p_NDATE = $("#p_NDATE").val();
	var p_NCONT = CKEDITOR.instances.p_NCONT.getData();
	var p_NSTATUS = $("#p_STATUS_OPTIONS").val();

	if (p_NTITLE == "") {
		alert("活動標題不能為空白");
	} else if (p_NDATE == "") {
		alert("活動日期不能為空白");
	} else if (p_NCONT == "") {
		alert("活動內容不能為空白");
	} else {
		p_NTITLE =base64_encode(p_NTITLE);
		p_NCONT =base64_encode(p_NCONT);
	    $.post('../libs/php/process/cls.member.news.php', {
	    	"p_NID": _key, "p_NTITLE": p_NTITLE, "p_NCONT": p_NCONT, "p_NDATE": p_NDATE, "p_NSTATUS": p_NSTATUS,
	    	"p_ACTION": "Update", "_": new Date().getTime() }, function (data) {
	    	if (data == "1") {
	    		alert("更新完成");
	    		getPopular();
	    	} else {
	    		alert("更新失敗");
	    	}
		});		
	}
}

function btnSubmit1() {
	var p_NTITLE = $("#p_NTITLE").val();
	var p_NDATE = $("#p_NDATE").val();
	var p_NCONT = CKEDITOR.instances.p_NCONT.getData();

	if (p_NTITLE == "") {
		alert("活動標題不能為空白");
	} else if (p_NDATE == "") {
		alert("活動日期不能為空白");
	} else if (p_NCONT == "") {
		alert("活動內容不能為空白");
	} else {
		p_NTITLE =base64_encode(p_NTITLE);
		p_NCONT =base64_encode(p_NCONT);
	    $.post('../libs/php/process/cls.member.news.php', {
	    	"p_NTITLE": p_NTITLE, "p_NCONT": p_NCONT, "p_NDATE": p_NDATE,
	    	"p_ACTION": "Save", "_": new Date().getTime() }, function (data) {
	    	if (data == "1") {
	    		alert("儲存完成");
	    		getPopular();
	    	} else {
	    		alert("儲存失敗");
	    	}
		});		
	}
}

function btnCancel() {
    $.post('../libs/php/process/cls.member.news.php', {"p_ACTION": "List", "p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "_": new Date().getTime() }, function (data) {
        $("#wContent").html(data);
        addEvent();
	});	
}
