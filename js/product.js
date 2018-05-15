var p_LIMIT = 8;
var p_PAGE = 1;

$(document).ready(function () {
	getProduct();
});

function getProduct() {
    $.post('../libs/php/process/cls.product.php', {"p_ACTION": "List", "p_PAGE": "1", "p_LIMIT": p_LIMIT, "_": new Date().getTime() }, function (data) {
        $("#wContent").html(data);
        addEvent();
	});		
}

function addEvent() {
	$("#numberpager").find("span").click(function(){
		p_PAGE = $(this).attr('num');
		p_PRODUCTCODE = $(this).attr('_pPRODUCTCODE');
		var p_CLASS = $(this).attr('classid');
	    $.post('../libs/php/process/cls.product.php', {"p_PRODUCTCODE1": p_PRODUCTCODE, "p_CLASS": p_CLASS, "p_ACTION": "List", "p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "_": new Date().getTime() }, function (data) {
	        $("#wContent").html(data);
	        addEvent();
		});		
	});	

	$("#btnSearch").click(function(){
		var p_PRODUCTCODE = $("#p_PRODUCTCODE").val();
	    $.post('../libs/php/process/cls.product.php', {"p_PRODUCTCODE1": p_PRODUCTCODE, "p_ACTION": "List", "p_PAGE": "1", "p_LIMIT": p_LIMIT, "_": new Date().getTime() }, function (data) {
	        $("#wContent").html(data);
	        addEvent();
		});		
	});		

	$("table").find("tr").find("#btnSort").click(function(){
		var _pPHOTOSORT = $(this).attr("_pPHOTOSORT");
		_pPHOTOSORT = base64_decode(_pPHOTOSORT);

        $.getScript("../libs/js/jquery.blockUI.js")
	    .done(function() { 
	    	$("#loader").hide();
	        $.blockUI({ 
	            message: _pPHOTOSORT, 
	            css: { 
	                top:  '10px', 
	                left: (getBrowserWidth() - 800) /2 + 'px', 
	                width: '850px',
	                height: '200px',
		            'overflow-y': 'scroll',
		            'overflow-x': 'hidden'
	            },
	            onOverlayClick: $.unblockUI,
	            onUnblock: function(){ 
	            	$("#loader").show(); 
	            	getProduct();
	            } 
	        }); 	 			       
	    })
	    .fail(function() { alert('讀取失敗'); });
	});		

	$("table").find("tr").find("#btnBrowser").click(function(){
		var _pPHOTO = $(this).attr("_pPHOTO");
		_pPHOTO = base64_decode(_pPHOTO);
			
        $.getScript("../libs/js/jquery.blockUI.js")
	    .done(function() { 
	    	$("#loader").hide();
	        $.blockUI({ 
	            message: _pPHOTO, 
	            css: { 
	                top:  '10px', 
	                left: (getBrowserWidth() - 800) /2 + 'px', 
	                width: '800px',
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

	$("table").find("tr").find("#p_PNAME").click(function(){
		var _pMEMO = $(this).attr("_pMEMO");
		var _pHOWTOUSE = $(this).attr("_pHOWTOUSE");
		var _pSPEC = $(this).attr("_pSPEC");
		var _pDESCRIPTION = $(this).attr("_pDESCRIPTION");
		var _pBRIEFCONT = $(this).attr("_pBRIEFCONT");
		_pMEMO = base64_decode(_pMEMO);
		_pHOWTOUSE = base64_decode(_pHOWTOUSE);
		_pSPEC = base64_decode(_pSPEC);
		_pDESCRIPTION = base64_decode(_pDESCRIPTION);
		_pBRIEFCONT = base64_decode(_pBRIEFCONT);
		
		var s = '<table border="1">';
		s += '<tr><td width="100px;">商品簡介</td><td>'+_pBRIEFCONT+'</td></tr>'
		s += '<tr><td>商品規格</td><td>'+_pSPEC+'</td></tr>'
		s += '<tr><td>商品介紹</td><td>'+_pDESCRIPTION+'</td></tr>'
		s += '<tr><td>使用方法</td><td>'+_pHOWTOUSE+'</td></tr>'
		s += '<tr><td>備註說明</td><td>'+_pMEMO+'</td></tr>'
		s += '</table>'

        $.getScript("../libs/js/jquery.blockUI.js")
	    .done(function() { 
	    	$("#loader").hide();
	        $.blockUI({ 
	            message: s, 
	            css: { 
	                top:  '10px', 
	                left: (getBrowserWidth() - 800) /2 + 'px', 
	                width: '800px',
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

	$("#p_PHOTO").bind("change",function() {
		var result = '';
		var imgobject = document.getElementById('p_PHOTO').files[0];
		reader = new FileReader();
		reader.onload = (function (tFile) {
			return function (evt) {
				var div = document.createElement('div');
				div.innerHTML = '<img style="width: 200px;" src="' + evt.target.result + '" />';
				$('#preview_img1').html(div);
			};
		}(imgobject));
		reader.readAsDataURL(imgobject);		
	});		
}

function UpdatePhotoSort(_key) {
	var p_FILE1; 
	var p_FILE2; 
	var p_FILE3; 
	var p_FILE4; 
	var p_FILE5; 
	var p_ID = _key;

	$("#sortable").find("li").each(function(i) { 
		if (i == 0) p_FILE1 = $(this).find("img").attr("src").replace('../webimages/product/', '');
		else if (i == 1) p_FILE2 = $(this).find("img").attr("src").replace('../webimages/product/', '');
		else if (i == 2) p_FILE3 = $(this).find("img").attr("src").replace('../webimages/product/', '');
		else if (i == 3) p_FILE4 = $(this).find("img").attr("src").replace('../webimages/product/', '');
		else if (i == 4) p_FILE5 = $(this).find("img").attr("src").replace('../webimages/product/', '');
	});

    $.post('../libs/php/process/cls.product.php', {"p_ID": _key, 
		"p_FILE1": p_FILE1, "p_FILE2": p_FILE2, "p_FILE3": p_FILE3, "p_FILE4": p_FILE4, "p_FILE5": p_FILE5,    	
    	"p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "p_ACTION": "Update2", 
    	"_": new Date().getTime() }, function (data) {
        //$("#wContent").html(data);
        //addEvent();
	});			
}

function btnPreivew(_key) {
	window.open('../productdetail.php?p_ID='+_key,'_blank');
}

function btnDel(_key) {
	if(confirm("確定要刪除該筆資料嗎？")) {
	    $.post('../libs/php/process/cls.product.php', {"p_ID": _key, "p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "p_ACTION": "Delete", "_": new Date().getTime() }, function (data) {
	        $("#wContent").html(data);
	        addEvent();
		});			
	}
}

function btnModify(_key) {
    $.post('../libs/php/process/cls.product.php', {"p_ID": _key, "p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "p_ACTION": "Modify", "_": new Date().getTime() }, function (data) {

        $.getScript("//cdn.ckeditor.com/4.4.5/full/ckeditor.js")
	    .done(function() { 
	        $("#wContent").html(data);

	        CKEDITOR.replace('p_BRIEFCONT',
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
	        CKEDITOR.replace('p_SPEC',
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
	        CKEDITOR.replace('p_DESCRIPTION',
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
	        CKEDITOR.replace('p_HOWTOUSE',
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
	        CKEDITOR.replace('p_MEMO',
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
			CKEDITOR.config.height = 80;	        
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

	        $("#p_ENABLEDATE").datepicker({
	            beforeShow: function (input, instance) {
	            }, minDate: 0, dateFormat: 'yy-mm-dd'
	        });

	        $("#p_DISABLEDATE").datepicker({
	            beforeShow: function (input, instance) {
	            }, minDate: 0
	        });

	        $('#p_ENABLEDATE1').timepicker({ 
					hourText: '小時', minuteText: '分鐘', 
	                showLeadingZero: false, 
	                showNowButton: false, 
	                showMinutes: false
	        });

	        $('#p_DISABLEDATE1').timepicker({ 
					hourText: '小時', minuteText: '分鐘', 
	                showLeadingZero: false, 
	                showNowButton: false, 
	                showMinutes: false
	        });			
	    })
	    .fail(function() { alert('讀取失敗'); });
        
        addEvent();        
	});
}

function btnAdd() {
    $.post('../libs/php/process/cls.product.php', {"p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "p_ACTION": "Add", "_": new Date().getTime() }, function (data) {
        $.getScript("//cdn.ckeditor.com/4.4.5/full/ckeditor.js")
	    .done(function() { 
	        $("#wContent").html(data);

	        CKEDITOR.replace('p_BRIEFCONT',
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
	        CKEDITOR.replace('p_SPEC',
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
	        CKEDITOR.replace('p_DESCRIPTION',
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
	        CKEDITOR.replace('p_HOWTOUSE',
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
	        CKEDITOR.replace('p_MEMO',
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
			CKEDITOR.config.height = 80;	        
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

	        $("#p_ENABLEDATE").datepicker({
	            beforeShow: function (input, instance) {
	            }, minDate: 0, dateFormat: 'yy-mm-dd'
	        });

	        $("#p_DISABLEDATE").datepicker({
	            beforeShow: function (input, instance) {
	            }, minDate: 0
	        });

	        $('#p_ENABLEDATE1').timepicker({ 
					hourText: '小時', minuteText: '分鐘', 
	                showLeadingZero: false, 
	                showNowButton: false, 
	                showMinutes: false
	        });

	        $('#p_DISABLEDATE1').timepicker({ 
					hourText: '小時', minuteText: '分鐘', 
	                showLeadingZero: false, 
	                showNowButton: false, 
	                showMinutes: false
	        });	

			$("#p_CATEGORY_CLASS1").bind("change",function() {
				$("#p_CATEGORY1").html('');
		    	$("#p_PARENT_CATEGORY1").html('');

				if ($(this).val() != "") {
					var p_CLASS = $(this).val().split('-')[0];
					var p_STYLE = $(this).val().split('-')[1];
					if (p_STYLE == "0") {
					    $.post('../libs/php/process/cls.category.php', {"p_CLASS": p_CLASS, "p_STYLE": p_STYLE, "p_ACTION": "SubClass", "_": new Date().getTime() }, function (data) {
					    	var s = "<select id=\"p_CATEGORY_OPTIONS1\">";
					    	s += data;
					    	s += "</select>";
					    	$("#p_CATEGORY1").html(s);
						});											
					} else {	
					    $.post('../libs/php/process/cls.category.php', {"p_CLASS": p_CLASS, "p_ACTION": "ParentClass", "_": new Date().getTime() }, function (data) {
					    	var s = "<select id=\"p_PARENT_CATEGORY_OPTIONS1\">";
					    	s += data;
					    	s += "</select>";
					    	$("#p_PARENT_CATEGORY1").html(s);

							$("#p_PARENT_CATEGORY_OPTIONS1").bind("change",function() {
								if ($(this).val() != "") {
									var p_CLASS = $("#p_CATEGORY_CLASS1").val().split('-')[0];
									var p_ID = $(this).val();
								    $.post('../libs/php/process/cls.category.php', {"p_CLASS": p_CLASS, "p_STYLE": p_STYLE, "p_ID": p_ID, "p_ACTION": "SubClass", "_": new Date().getTime() }, function (data) {
								    	var s = "<select id=\"p_CATEGORY_OPTIONS1\">";
								    	s += data;
								    	s += "</select>";
								    	$("#p_CATEGORY1").html(s);
									});											
								}
							});		
						});											
					}
				}
			});		

			$("#p_CATEGORY_CLASS2").bind("change",function() {
				$("#p_CATEGORY2").html('');
		    	$("#p_PARENT_CATEGORY2").html('');

				if ($(this).val() != "") {
					var p_CLASS = $(this).val().split('-')[0];
					var p_STYLE = $(this).val().split('-')[1];
					if (p_STYLE == "0") {
					    $.post('../libs/php/process/cls.category.php', {"p_CLASS": p_CLASS, "p_STYLE": p_STYLE, "p_ACTION": "SubClass", "_": new Date().getTime() }, function (data) {
					    	var s = "<select id=\"p_CATEGORY_OPTIONS2\">";
					    	s += data;
					    	s += "</select>";
					    	$("#p_CATEGORY2").html(s);
						});											
					} else {	
					    $.post('../libs/php/process/cls.category.php', {"p_CLASS": p_CLASS, "p_ACTION": "ParentClass", "_": new Date().getTime() }, function (data) {
					    	var s = "<select id=\"p_PARENT_CATEGORY_OPTIONS2\">";
					    	s += data;
					    	s += "</select>";
					    	$("#p_PARENT_CATEGORY2").html(s);

							$("#p_PARENT_CATEGORY_OPTIONS2").bind("change",function() {
								if ($(this).val() != "") {
									var p_CLASS = $("#p_CATEGORY_CLASS2").val().split('-')[0];
									var p_ID = $(this).val();
								    $.post('../libs/php/process/cls.category.php', {"p_CLASS": p_CLASS, "p_STYLE": p_STYLE, "p_ID": p_ID, "p_ACTION": "SubClass", "_": new Date().getTime() }, function (data) {
								    	var s = "<select id=\"p_CATEGORY_OPTIONS2\">";
								    	s += data;
								    	s += "</select>";
								    	$("#p_CATEGORY2").html(s);
									});											
								}
							});		
						});											
					}
				}
			});		

			$("#p_CATEGORY_CLASS3").bind("change",function() {
				$("#p_CATEGORY3").html('');
		    	$("#p_PARENT_CATEGORY3").html('');

				if ($(this).val() != "") {
					var p_CLASS = $(this).val().split('-')[0];
					var p_STYLE = $(this).val().split('-')[1];
					if (p_STYLE == "0") {
					    $.post('../libs/php/process/cls.category.php', {"p_CLASS": p_CLASS, "p_STYLE": p_STYLE, "p_ACTION": "SubClass", "_": new Date().getTime() }, function (data) {
					    	var s = "<select id=\"p_CATEGORY_OPTIONS3\">";
					    	s += data;
					    	s += "</select>";
					    	$("#p_CATEGORY3").html(s);
						});											
					} else {	
					    $.post('../libs/php/process/cls.category.php', {"p_CLASS": p_CLASS, "p_ACTION": "ParentClass", "_": new Date().getTime() }, function (data) {
					    	var s = "<select id=\"p_PARENT_CATEGORY_OPTIONS3\">";
					    	s += data;
					    	s += "</select>";
					    	$("#p_PARENT_CATEGORY3").html(s);

							$("#p_PARENT_CATEGORY_OPTIONS3").bind("change",function() {
								if ($(this).val() != "") {
									var p_CLASS = $("#p_CATEGORY_CLASS3").val().split('-')[0];
									var p_ID = $(this).val();
								    $.post('../libs/php/process/cls.category.php', {"p_CLASS": p_CLASS, "p_STYLE": p_STYLE, "p_ID": p_ID, "p_ACTION": "SubClass", "_": new Date().getTime() }, function (data) {
								    	var s = "<select id=\"p_CATEGORY_OPTIONS3\">";
								    	s += data;
								    	s += "</select>";
								    	$("#p_CATEGORY3").html(s);
									});											
								}
							});		
						});											
					}
				}
			});		
	    })
	    .fail(function() { alert('讀取失敗'); });

        addEvent();        
	});
}

function btnSubmit(_key) {
	var imgobject = document.getElementById('p_PHOTO').files[0];
	var p_NAME = $("#p_NAME").val();
	var p_ENABLEDATE = $("#p_ENABLEDATE").val();
	var p_ENABLEDATE1 = $("#p_ENABLEDATE1").val();
	var p_STORAGE = $("#p_STORAGE").val();	
	var p_PRICE1 = $("#p_PRICE1").val();
	var p_PRICE2 = $("#p_PRICE2").val();

	if (p_NAME == "") {	
		alert("請輸入商品名稱");
	} else if (p_ENABLEDATE == "") {	
		alert("請輸入啟用日期");
	} else if (p_ENABLEDATE1 == "") {	
		alert("請輸入啟用時間");
	} else if (p_STORAGE == "") {	
		alert("請輸入庫存");
	} else if (p_PRICE1 == "") {	
		alert("請輸入市價");
	} else if (p_PRICE1 == "") {	
		alert("請輸入會員價");
	} else {
		if (imgobject === undefined) {
			var p_DISABLEDATE = $("#p_DISABLEDATE").val();
			var p_DISABLEDATE1 = $("#p_DISABLEDATE1").val();
			var p_PRICE3 = $("#p_PRICE3").val();
			var p_BRIEFCONT = CKEDITOR.instances.p_BRIEFCONT.getData();
			var p_SPEC = CKEDITOR.instances.p_SPEC.getData();
			var p_DESCRIPTION = CKEDITOR.instances.p_DESCRIPTION.getData();
			var p_HOWTOUSE = CKEDITOR.instances.p_HOWTOUSE.getData();
			var p_MEMO = CKEDITOR.instances.p_MEMO.getData();
			var p_ID = _key;
			var p_KIND = $("#p_PRODUCT_KIND").val();
			var p_SHIP = $("#p_SHIP").val();
			var p_STATUS = $("#p_STATUS_OPTIONS").val();

			p_ENABLEDATE = p_ENABLEDATE + " " + p_ENABLEDATE1 + ":00:00";
			if (p_DISABLEDATE != "") p_DISABLEDATE = p_DISABLEDATE + " " + p_DISABLEDATE1 + ":00:00";

			p_BRIEFCONT = base64_encode(p_BRIEFCONT);
			p_SPEC = base64_encode(p_SPEC);
			p_DESCRIPTION = base64_encode(p_DESCRIPTION);
			p_HOWTOUSE = base64_encode(p_HOWTOUSE);
			p_MEMO = base64_encode(p_MEMO);

		    $.post('../libs/php/process/cls.product.php', {
		    	"p_ID": p_ID, "p_NAME": p_NAME, "p_STATUS": p_STATUS,
		    	"p_ENABLEDATE": p_ENABLEDATE, "p_DISABLEDATE": p_DISABLEDATE,
				"p_STORAGE": p_STORAGE, "p_PRICE1": p_PRICE1, "p_PRICE2": p_PRICE2, "p_PRICE3": p_PRICE3,    	
		    	"p_BRIEFCONT": p_BRIEFCONT, "p_SPEC": p_SPEC, "p_DESCRIPTION": p_DESCRIPTION,
		    	"p_HOWTOUSE": p_HOWTOUSE, "p_MEMO": p_MEMO, "p_KIND": p_KIND, "p_SHIP": p_SHIP,
		    	"p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "p_ACTION": "Update1", 
		    	"_": new Date().getTime() }, function (data) {
		    	if(data == "1") {
		    		alert("更新完成");
		    		getProduct();
		    	} else {
		    		alert("更新失敗");
		    	}
			});		
		} else {
			var oXHR = new XMLHttpRequest();
			oXHR.addEventListener('load', uplpadfile1, false);
			oXHR.open('POST', '../libs/php/process/cls.upload1.php');

			var data = new FormData($("#uploadphoto")[0]);
			oXHR.send(data);		
		}
	}
}

function btnSubmit1() {
	var imgobject = document.getElementById('p_PHOTO').files[0];	

	var p_PRODUCTCODE = $("#p_PRODUCTCODE").val();
	var p_NAME = $("#p_NAME").val();
	var p_ENABLEDATE = $("#p_ENABLEDATE").val();
	var p_ENABLEDATE1 = $("#p_ENABLEDATE1").val();
	var p_STORAGE = $("#p_STORAGE").val();	
	var p_PRICE1 = $("#p_PRICE1").val();
	var p_PRICE2 = $("#p_PRICE2").val();

	if (imgobject === undefined) {
		alert("請選擇圖檔");
	} else if (p_PRODUCTCODE == "") {	
		alert("請輸入商品代號");
	} else if (p_NAME == "") {	
		alert("請輸入商品名稱");
	} else if (p_ENABLEDATE == "") {	
		alert("請輸入啟用日期");
	} else if (p_ENABLEDATE1 == "") {	
		alert("請輸入啟用時間");
	} else if (p_STORAGE == "") {	
		alert("請輸入庫存");
	} else if (p_PRICE1 == "") {	
		alert("請輸入市價");
	} else if (p_PRICE1 == "") {	
		alert("請輸入會員價");
	} else {
		var oXHR = new XMLHttpRequest();
		oXHR.addEventListener('load', uplpadfile, false);
		oXHR.open('POST', '../libs/php/process/cls.upload1.php');

		var data = new FormData($("#uploadphoto")[0]);
		oXHR.send(data);		
	}
}

function uplpadfile(e) {
	var msg = e.target.responseText;
	if (msg.substr(0,2) != "1-") {
		alert('圖檔上傳失敗');
		return false;
	}
	var p_FILE1; 
	var p_FILE2; 
	var p_FILE3; 
	var p_FILE4; 
	var p_FILE5; 

	var p_FILENAME = msg.split('-')[2];
	var p_FILENAME1 = p_FILENAME.split(' ');

	if (p_FILENAME1.length > 5) p_FILE5 = p_FILENAME1[5];
	if (p_FILENAME1.length > 4) p_FILE4 = p_FILENAME1[4];
	if (p_FILENAME1.length > 3) p_FILE3 = p_FILENAME1[3];
	if (p_FILENAME1.length > 2) p_FILE2 = p_FILENAME1[2];
	if (p_FILENAME1.length > 1) p_FILE1 = p_FILENAME1[1];

	var p_PRODUCTCODE = $("#p_PRODUCTCODE").val();
	var p_NAME = $("#p_NAME").val();
	var p_ENABLEDATE = $("#p_ENABLEDATE").val();
	var p_ENABLEDATE1 = $("#p_ENABLEDATE1").val();
	var p_DISABLEDATE = $("#p_DISABLEDATE").val();
	var p_DISABLEDATE1 = $("#p_DISABLEDATE1").val();
	var p_STORAGE = $("#p_STORAGE").val();	
	var p_PRICE1 = $("#p_PRICE1").val();
	var p_PRICE2 = $("#p_PRICE2").val();
	var p_PRICE3 = $("#p_PRICE3").val();
	var p_BRIEFCONT = CKEDITOR.instances.p_BRIEFCONT.getData();
	var p_SPEC = CKEDITOR.instances.p_SPEC.getData();
	var p_DESCRIPTION = CKEDITOR.instances.p_DESCRIPTION.getData();
	var p_HOWTOUSE = CKEDITOR.instances.p_HOWTOUSE.getData();
	var p_MEMO = CKEDITOR.instances.p_MEMO.getData();
	var p_KIND = $("#p_PRODUCT_KIND").val();

	var p_CATEGORY1 = "";
	var p_CATEGORY2 = "";
	var p_CATEGORY3 = "";

	var p_CATEGORY1_LEVEL2 = $("#p_PARENT_CATEGORY_OPTIONS1").val();
	var p_CATEGORY2_LEVEL2 = $("#p_PARENT_CATEGORY_OPTIONS2").val();
	var p_CATEGORY3_LEVEL2 = $("#p_PARENT_CATEGORY_OPTIONS3").val();

	if ((p_CATEGORY1_LEVEL2 !== undefined) && (p_CATEGORY1_LEVEL2 != "0")) p_CATEGORY1 = p_CATEGORY1_LEVEL2;
	if ((p_CATEGORY2_LEVEL2 !== undefined) && (p_CATEGORY2_LEVEL2 != "0")) p_CATEGORY2 = p_CATEGORY2_LEVEL2;
	if ((p_CATEGORY3_LEVEL2 !== undefined) && (p_CATEGORY3_LEVEL2 != "0")) p_CATEGORY3 = p_CATEGORY3_LEVEL2;

	var p_CATEGORY1_LEVEL3 = $("#p_CATEGORY_OPTIONS1").val();
	var p_CATEGORY2_LEVEL3 = $("#p_CATEGORY_OPTIONS2").val();
	var p_CATEGORY3_LEVEL3 = $("#p_CATEGORY_OPTIONS3").val();
	var p_SHIP = $("#p_SHIP").val();

	if ((p_CATEGORY1_LEVEL3 !== undefined) && (p_CATEGORY1_LEVEL3 != "0")) p_CATEGORY1 = p_CATEGORY1_LEVEL3;
	if ((p_CATEGORY2_LEVEL3 !== undefined) && (p_CATEGORY2_LEVEL3 != "0")) p_CATEGORY2 = p_CATEGORY2_LEVEL3;
	if ((p_CATEGORY3_LEVEL3 !== undefined) && (p_CATEGORY3_LEVEL3 != "0")) p_CATEGORY3 = p_CATEGORY3_LEVEL3;

	p_ENABLEDATE = p_ENABLEDATE + " " + p_ENABLEDATE1 + ":00:00";
	if (p_DISABLEDATE != "") p_DISABLEDATE = p_DISABLEDATE + " " + p_DISABLEDATE1 + ":00:00";

	p_BRIEFCONT = base64_encode(p_BRIEFCONT);
	p_SPEC = base64_encode(p_SPEC);
	p_DESCRIPTION = base64_encode(p_DESCRIPTION);
	p_HOWTOUSE = base64_encode(p_HOWTOUSE);
	p_MEMO = base64_encode(p_MEMO);

    $.post('../libs/php/process/cls.product.php', {
    	"p_PRODUCTCODE": p_PRODUCTCODE, "p_NAME": p_NAME,
    	"p_ENABLEDATE": p_ENABLEDATE, "p_DISABLEDATE": p_DISABLEDATE,
		"p_STORAGE": p_STORAGE, "p_PRICE1": p_PRICE1, "p_PRICE2": p_PRICE2, "p_PRICE3": p_PRICE3,    	
    	"p_BRIEFCONT": p_BRIEFCONT, "p_SPEC": p_SPEC, "p_DESCRIPTION": p_DESCRIPTION,
    	"p_HOWTOUSE": p_HOWTOUSE, "p_MEMO": p_MEMO, "p_KIND" : p_KIND, "p_SHIP": p_SHIP,
		"p_FILE1": p_FILE1, "p_FILE2": p_FILE2, "p_FILE3": p_FILE3, "p_FILE4": p_FILE4, "p_FILE5": p_FILE5,    	
		"p_CATEGORY1": p_CATEGORY1, "p_CATEGORY2": p_CATEGORY2, "p_CATEGORY3": p_CATEGORY3, 
    	"p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "p_ACTION": "Save", 
    	"_": new Date().getTime() }, function (data) {
    	if(data == "1") {
    		alert("儲存完成");
    		getProduct();
    	} else {
    		alert("儲存失敗");
    	}
	});		
}	

function uplpadfile1(e) {
	var msg = e.target.responseText;
	if (msg.substr(0,2) != "1-") {
		alert('圖檔上傳失敗');
		return false;
	}

	var p_FILE1; 
	var p_FILE2; 
	var p_FILE3; 
	var p_FILE4; 
	var p_FILE5; 

	var p_ID = msg.split('-')[1];
	var p_FILENAME = msg.split('-')[2];
	var p_FILENAME1 = p_FILENAME.split(' ');

	if (p_FILENAME1.length > 5) p_FILE5 = p_FILENAME1[5];
	if (p_FILENAME1.length > 4) p_FILE4 = p_FILENAME1[4];
	if (p_FILENAME1.length > 3) p_FILE3 = p_FILENAME1[3];
	if (p_FILENAME1.length > 2) p_FILE2 = p_FILENAME1[2];
	if (p_FILENAME1.length > 1) p_FILE1 = p_FILENAME1[1];

	var p_NAME = $("#p_NAME").val();
	var p_DISABLEDATE = $("#p_DISABLEDATE").val();
	var p_DISABLEDATE1 = $("#p_DISABLEDATE1").val();
	var p_STORAGE = $("#p_STORAGE").val();	
	var p_PRICE1 = $("#p_PRICE1").val();
	var p_PRICE2 = $("#p_PRICE2").val();
	var p_PRICE3 = $("#p_PRICE3").val();
	var p_BRIEFCONT = CKEDITOR.instances.p_BRIEFCONT.getData();
	var p_SPEC = CKEDITOR.instances.p_SPEC.getData();
	var p_DESCRIPTION = CKEDITOR.instances.p_DESCRIPTION.getData();
	var p_HOWTOUSE = CKEDITOR.instances.p_HOWTOUSE.getData();
	var p_MEMO = CKEDITOR.instances.p_MEMO.getData();
	var p_KIND = $("#p_PRODUCT_KIND").val();
	var p_SHIP = $("#p_SHIP").val();
	var p_STATUS = $("#p_STATUS_OPTIONS").val();

	p_ENABLEDATE = p_ENABLEDATE + " " + p_ENABLEDATE1 + ":00:00";
	if (p_DISABLEDATE != "") p_DISABLEDATE = p_DISABLEDATE + " " + p_DISABLEDATE1 + ":00:00";

	p_BRIEFCONT = base64_encode(p_BRIEFCONT);
	p_SPEC = base64_encode(p_SPEC);
	p_DESCRIPTION = base64_encode(p_DESCRIPTION);
	p_HOWTOUSE = base64_encode(p_HOWTOUSE);
	p_MEMO = base64_encode(p_MEMO);

    $.post('../libs/php/process/cls.product.php', {
    	"p_ID": p_ID, "p_NAME": p_NAME, "p_STATUS": p_STATUS,
    	"p_ENABLEDATE": p_ENABLEDATE, "p_DISABLEDATE": p_DISABLEDATE,
		"p_STORAGE": p_STORAGE, "p_PRICE1": p_PRICE1, "p_PRICE2": p_PRICE2, "p_PRICE3": p_PRICE3,    	
    	"p_BRIEFCONT": p_BRIEFCONT, "p_SPEC": p_SPEC, "p_DESCRIPTION": p_DESCRIPTION,
    	"p_HOWTOUSE": p_HOWTOUSE, "p_MEMO": p_MEMO, "p_KIND" : p_KIND, "p_SHIP": p_SHIP,
		"p_FILE1": p_FILE1, "p_FILE2": p_FILE2, "p_FILE3": p_FILE3, "p_FILE4": p_FILE4, "p_FILE5": p_FILE5,    	
    	"p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "p_ACTION": "Update", 
    	"_": new Date().getTime() }, function (data) {
    	if(data == "1") {
    		alert("更新完成");
    		getProduct();
    	} else {
    		alert("更新失敗");
    	}
	});		
}	

function btnCancel() {
    $.post('../libs/php/process/cls.product.php', {"p_ACTION": "List", "p_PAGE": p_PAGE, "p_LIMIT": p_LIMIT, "_": new Date().getTime() }, function (data) {
        $("#wContent").html(data);
        addEvent();
	});	
}
