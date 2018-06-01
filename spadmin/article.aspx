<%@ Page Language="C#" AutoEventWireup="true" CodeFile="article.aspx.cs" Inherits="spadmin_article" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title></title>
    <!-- basic styles -->
    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="assets/css/font-awesome.min.css" />
    <!-- page specific plugin styles -->
    <link rel="stylesheet" href="assets/css/jquery-ui-1.10.3.custom.min.css" />
    <link rel="stylesheet" href="assets/css/chosen.css" />
    <!--<link rel="stylesheet" href="assets/css/datepicker.css" />-->
    <link rel="stylesheet" href="assets/css/bootstrap-timepicker.css" />
    <link rel="stylesheet" href="assets/css/daterangepicker.css" />
    <link rel="stylesheet" href="assets/css/colorpicker.css" />
    <!-- fonts -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />
    <!-- ace styles -->
    <link rel="stylesheet" href="assets/css/ace.min.css" />
    <link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
    <link rel="stylesheet" href="assets/css/ace-skins.min.css" />
    <script src="assets/js/ace-extra.min.js"></script>
    <!-- basic scripts -->
    <script src="assets/js/jquery-2.0.3.min.js"></script>
    <!--datepicker -->
    <script type="text/javascript" src="/js/jquery.ui.datepicker-zh-TW.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    
    <script>
    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }
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
        var articleId = getParameterByName('articleId');
        if (articleId == null || articleId == '' || articleId == undefined) {
            articleId = 0;
        }
      
   
        $(function () {
            $("#postday").datepicker();
            $("#postday").datepicker("option", "dateFormat", "yy/mm/dd");

        });
        var maindata; 
        var flag;
        $(document).ready(function () {            
            if (articleId > 0) {
                var dataValue = "{articleId:'"+  articleId +"'}";             
                    $.postJSON('article.aspx/get_tbl_article', dataValue, 'application/json; charset=utf-8', function (result) {
                        if (result != "") {                           
                            var result = result.d;
                            result = JSON.parse(result);
                            maindata = result;                    
                            $('#postday').datepicker("setDate", new Date(result.PostDay));
                            $('#subject').val(result.Subject)
                            $('#subtitle').val(result.SubTitle);                          
                            $('#keywords').val(result.Keywords);
                            $('#author').val(result.Author);
                            $("#status").prop("checked", result.Status  == "Y" ? true : false);
                            $('#postDay').val(result.PostDay);
                            CKEDITOR.instances['contents'].setData(result.Contents);                           
                            document.getElementById('console').innerHTML = ("<img src=\"/webimages/article/" + result.Pic + "\" width=300>");
                            $('#logoPic').val(result.Pic);                           
                        }
                    });
                    $.postJSON('article.aspx/get_tbl_article_item', dataValue, 'application/json; charset=utf-8', function (result) {
                        if (result != "") {
                            var result = result.d;
                            if (result != '') {
                              //  result = JSON.parse(result);
                                $.each(result, function (key, val) {
                                  
                                    var v = '<input type="button" class="mod" value="修改">';
                                    v += '<input type="button" class="delete" value="刪除"><br>';
                                    v += '主旨: <span class="title">' + val.Title + '</span> <BR>';
                                    v += '內文: <span>' + val.Contents + '</span>';
                                    v += "<input type=\"hidden\" class=\"content\" value='" + val.Contents + "' /> ";
                                     $('#detailitem').append('<li style="background-color: #C0C0C0">' + v + '</li>');//新增LI
                                });     
                            }

                        }
                    });

            }

     
            $("#preview").click(function () {
                check_data('p');
            });
            $("#btn_save").click(function () {
                check_data('s');
            });
            $("#btn-next").click(function () { //新增明細介面
                CKEDITOR.instances['content'].setData('');
                $("#secno").val('');
                $("#title").val('');
                $('#recent-tab a[href="#item2"]').tab('show') //SHOW 明細tab
            })
            $("#btl_add").click(function () {
               // 新增明細資料
                var errmsg = "";
                var content = CKEDITOR.instances['content'].getData();
                var subject = $("#title").val();
                if (subject == '') {
                    errmsg += ('請輸入主標題\r\n');
                }
                if (content == '') {
                    errmsg += ('請輸入內容\r\n');
                }
                if (errmsg == '') {
                    var content = CKEDITOR.instances['content'].getData();
                    var v = '<input type="button" class="mod" value="修改">';
                    v += '<input type="button" class="delete" value="刪除"><br>';
                    v += '主旨: <span class="title">' + $('#title').val() + '</span> <BR>';
                    v += '內文: <span>' + content + '</span>';
                    v += "<input type=\"hidden\" class=\"content\" value='" + content + "' /> ";
                    if ($("#secno").val() == "") {
                        $('#detailitem').append('<li style="background-color: #C0C0C0">' + v + '</li>');//新增LI
                    }
                    else {
                        $("ul#detailitem li").eq($("#secno").val()).html(v); //修改明細LI
                    }
                    $('#recent-tab a[href="#item1"]').tab('show')
                } else {
                    alert(errmsg);
                }
            });
            $("#btl_cel").click(function () {
                $('#recent-tab a[href="#item1"]').tab('show') //返回主內容
            });
            $("ul#detailitem").on("click", "li", function () { //取得修改的明細
                var num = $(this).index();
                $("#secno").val(num);
                $("#title").val($(this).find('.title').text());
                CKEDITOR.instances['content'].setData($(this).find('.content').val());
                $('#recent-tab a[href="#item2"]').tab('show')
            })
            $(document).on('click', '.delete', function (event) { //刪掉明細li
                if (confirm('你確定嗎?')) { $(this).parent().remove(); }

            });
            get_tag();
          
            var dataValue = "{ kind: 'get' }";
            $.postJSON('article.aspx/get_category', dataValue, 'application/json; charset=utf-8', function (result) {
                if (result != "") {
                    var result = result.d;
                    result = JSON.parse(result);
                    result = result.main;
                    var cb = "";
                    var s = "";
                    $.each(result, function (key, val) {                   
                        if (val.detail.length > 0) {
                            cb += "<b>" + val.name + "</b>:";
                            for (i = 0; i < val.detail.length; i++) {                               
                                s = maindata ==  undefined ? "": check_cbx(maindata.Category, val.detail[i].id);                                
                                cb += "<input name='categoryid' class='ace ace-checkbox-2' type='checkbox' value='" + val.detail[i].id + "'" + s + "><span class=lbl>" + val.detail[i].name + "</span>";
                            }
                        }
                        else {
                            s = maindata ==  undefined ? "": check_cbx(maindata.Category, val.id);
                            cb += "<input name='categoryid' class='ace ace-checkbox-2' type='checkbox' value='" + val.id + "'" + s + "><span class=lbl>" + val.name + "</span>";

                        }
                        cb += "<Br>";
                    });
                    $("#category").html(cb);
                }
            });
        });
        function get_tag() {
            var dataValue = "{ kind: 'get' }";
            $.postJSON('article.aspx/get_tag', dataValue, 'application/json; charset=utf-8', function (result) {
                if (result != "") {
                    var result = result.d;
                    result = JSON.parse(result);
                    result = result.main;
                    var cb = "";
                    var s = "";
                    $.each(result, function (key, val) {        
                     
                        s = maindata ==  undefined ? "":check_cbx(maindata.Tags, val.id);                      
                        cb += "<input name='tags' class='ace ace-checkbox-2' type='checkbox' value='" + val.id + "'" + s + "><span class=lbl>" + val.name + "</span>";
                    });                    
                    $("#tag").html(cb);                    
                }
            });
        }
    
        function check_cbx(obj, val) {//check checkbox item ,設定勾選
            var s = "";          
            if (obj != undefined) {
                if (obj.length == 1) {
                    if (obj == val) s = " checked ";
                }
                else if (obj.length > 1) {
                    for (ix = 0; ix < obj.length; ix++) {
                        if (obj[ix] == val) s = " checked ";
                    }
                }
            }
           
            return s;
        }
        function check_data(kind) {//將主資料存到SESSION       
            var errmsg = "";
            var content = CKEDITOR.instances['contents'].getData();
            var subject = $("#subject").val();
            if (subject == '') {
                errmsg += ('請輸入主標題\r\n');
            }
            if (content == '') {
                errmsg += ('請輸入內容\r\n');

            }
            var Checked = $('input[name="tags"]:checked').length > 0;
            if (Checked == false) {
                errmsg += ('請勾選標籤\r\n');
            }
            Checked = $('input[name="categoryid"]:checked').length > 0;
            if (Checked == false) {
                errmsg += ('請勾選分類\r\n');
            }       
        
           if ( $("#postDay").val() == '') {
                errmsg += ('請輸入發佈日期\r\n');
            }
            if ( $("#logoPic").val() == '') {
                errmsg += ('文章主圖未上傳\r\n');
            }

            var categoryid = $('input:checkbox:checked[name="categoryid"]').map(function () { return $(this).val(); }).get();
            var tags = $('input:checkbox:checked[name="tags"]').map(function () { return $(this).val(); }).get();           
            var status = $("#status").prop("checked") == true ? "Y" : "N";
            
            var dataValue = {
                kind: "set", id: articleId, subject: $("#subject").val(), subtitle: $("#subtitle").val()
                , contents: content, pic: $("#logoPic").val(), keywords: $("#keywords").val()
                , status: status, categoryid: categoryid
                , tags: tags, author: $("#author").val(), postday: $("#postday").val()
            };

            if (errmsg == '') {
                $.postJSON('article.aspx/Set_data', JSON.stringify(dataValue), 'application/json; charset=utf-8', function (result) {
                    result = result.d;
                    if (result == '')
                        check_item(kind);
                    else
                        alert(result);
                });

            } else {
                alert(errmsg);
            }
        }
        function JSONparse(str) {
            str = str.replace("\r\n", "");
            str = str.replace("\r", "").replace("\n", "");
            str = str.replace("\"", "\\\""); 
            return str 
        }
        function check_item(kind) {//將明細資料存到SESSION   
            
            var dataValue = "{\"kind\": \"set\", \"id\":\"" + articleId + "\",\"item\":[";
            var i = 0;
            $("ul#detailitem li").each(function () {
                i++;              
                if (i != 1) { dataValue += ","; }
                if ($(this).find('.content').val() != undefined) {
                   
                    dataValue += "{\"Title\":\"" + $(this).find('.title').text() + "\"";
                    dataValue += ",\"Id\":\"" + articleId + "\"";
                    dataValue += ",\"Secno\":\"" + i + "\"";
                    dataValue += ",\"Image\":\"\",\"Layout\":\"\"";
                    dataValue += ",\"Contents\":\"\"}";
                }
            });
            dataValue += "]}"
            dataValue = JSON.parse(dataValue);
            result =  dataValue.item;          
            $.each(result, function (key, val) {             
                val.Contents =  $("ul#detailitem li").eq(key).find('.content').val();
            });
            dataValue.item = result;
            
            $.postJSON('article.aspx/Set_ItemData', JSON.stringify(dataValue), 'application/json; charset=utf-8', function (result) {
                if (result != "") {
                    var result = result.d;
                    if (result == '' ){
                        $('#recent-tab a[href="#item1"]').tab('show')
                        if (kind == "s") {
                            save_db();
                        }
                        else if (kind == 'p') {
                            window.open('/detail');

                        }
                    }
                    return (result)
                }
            });
        }
        function ret() {  //返回上層    
            if (flag != 'Y') {
                if (confirm('你確定嗎?'))  {
                    parent.$.fn.colorbox.close();
                }
            }
            else
                 parent.$.fn.colorbox.close();
        }
        function save_db() {
             var dataValue = "{ kind: 'get' }";
            $.postJSON('article.aspx/Set_DB', dataValue, 'application/json; charset=utf-8', function (result) {
                if (result != "") {
                    var result = result.d;
                    if (result == '')
                    {
                        alert('已存檔');
                        ret();
                    }
                    else
                    { alert(result); }
                }
            });

        }
   
    </script>
                                    

    <script src="ckeditor/ckeditor.js"></script>
</head>
<body>
    <form id="form1">
        <div class="widget-box transparent" id="recent-box">
            <div class="widget-header">
                <div>
                    <ul class="nav nav-tabs" id="recent-tab">
                        <li class="active">
                            <a data-toggle="tab" href="#item1">主 內 容</a>
                        </li>

                        <li>
                            <a data-toggle="tab" href="#item2">明細內容</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="widget-body">
                <div class="widget-main padding-4">
                    <div class="tab-content padding-8 overflow-visible">
                        <div id="item1" class="tab-pane active">
                            <table style="background-color: #FFFFFF">
                                <tr>
                                    <td>主標題</td>
                                    <td>
                                        <input id="subject" type="text" style="width: 500px" /></td>
                                </tr>
                                <tr>
                                    <td>次標題</td>
                                    <td>
                                        <input id="subtitle" type="text" style="width: 500px" /></td>
                                </tr>
                                <tr>
                                    <td>主圖示</td>
                                    <td>
                                        <script type="text/javascript" src="js/plupload.full.min.js"></script>
                                        <div id="filelist" class="col-sm-9">
                                            Your browser doesn't have Flash, Silverlight or HTML5 support.
                                        </div>
                                        <div id="container" class="col-sm-9">
                                            <input id="pickfiles" type="button" value="選擇檔案" />
                                            <input id="uploadfiles" type="button" value="上傳檔案" />
                                        </div>
                                        <input id="logoPic" type="hidden" />
                                        <pre id="console" class="col-sm-9"> </pre>

                                        <div style="display: none" class="col-sm-9">
                                            <div id="list_menu">
                                            </div>
                                            <div id="baseli" style="display: none">
                                                <div>
                                                    <input type="button" value="刪除" class="btn btn-app btn-danger btn-sm" />
                                                    <input type="file" name="myFile" />
                                                </div>
                                            </div>
                                            <input type="button" value="新增圖檔+" id="btnadd" />
                                        </div>
                                        <div id="pd_img" class="col-sm-9">
                                            <ul id="sortable" class="gridImg">
                                            </ul>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>內容</td>
                                    <td>
                                        <input id="contents" type="text" style="height: 600px" />
                                        <script>
                                            CKEDITOR.replace('contents');

                                        </script>
                                    </td>

                                </tr>
                                <tr>
                                    <td>標籤</td>
                                    <td>
                                        <label id="tag"></label><br />
                                   
                                        <a href="Edit_tag.aspx?unitid=13" class="iframe cboxElement"><i class="icon-double-angle-right"></i>標簽管理</a>
                                    </td>

                                </tr>
                                <tr>
                                    <td>作者</td>
                                    <td>
                                        <input type="text" name="author" id="author" value=""   placeholder="請輸入作者 ..." />

                                    </td>
                                </tr>
                                <tr>
                                    <td>關鍵字</td>
                                    <td>
                                        <input type="text" name="keywords" id="keywords" value=""   placeholder="請輸入關鍵字 ..." />

                                    </td>
                                </tr>
                                <tr>
                                    <td>發佈日</td>
                                    <td>
                                        <input id="postday" type="text" />
                                    </td>

                                </tr>
                                <tr>
                                    <td>所屬分類</td>
                                    <td>
                                        <label id="category"></label>

                                    </td>
                                </tr>
                                <tr>
                                    <td>狀態</td>
                                    <td>
                                        <input id="status" name="status" type="checkbox" class="ace ace-switch ace-switch-6" />
                                        <span class="lbl"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <ul id="detailitem">
                                        </ul>
                                    </td>

                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <button type="button" class="btn btn-primary" onclick="ret()">返 回</button>
                                        <button type="button" class="btn btn-primary" id="btn_save">存 檔</button>
                                        <button type="button" class="btn btn-primary" id="preview">預 覽</button>
                                        <button type="button" class="btn btn-primary" id="btn-next">新增段落</button>

                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="item2" class="tab-pane">
                            <table>
                                <tr>
                                    <td>標題</td>
                                    <td>
                                        <input id="title" type="text" /></td>
                                </tr>
                                <tr>
                                    <td>內容</td>
                                    <td>
                                        <input id="content" type="text" />

                                        <script>
                                            CKEDITOR.replace('content');
                                        </script>
                                        <input type="hidden" id="secno" value="" />
                                    </td>

                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <button type="button" class="btn btn-primary" id="btl_add">確認</button>
                                        <button type="button" class="btn btn-primary" id="btl_cel">取消</button>
                                    </td>
                                </tr>
                            </table>

                        </div>
                    </div>
                </div>
                <!-- /widget-main -->
            </div>
            <!-- /widget-body -->
        </div>
        <!-- /widget-box -->

        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/typeahead-bs2.min.js"></script>
        <script src="assets/js/jquery-ui-1.10.3.custom.min.js"></script>
        <script src="assets/js/jquery.ui.touch-punch.min.js"></script>
        <script src="assets/js/chosen.jquery.min.js"></script>
        <script src="assets/js/fuelux/fuelux.spinner.min.js"></script>
        <script src="assets/js/date-time/bootstrap-timepicker.min.js"></script>
        <script src="assets/js/date-time/moment.min.js"></script>
        <script src="assets/js/date-time/daterangepicker.min.js"></script>
        <script src="assets/js/bootstrap-colorpicker.min.js"></script>
        <script src="assets/js/jquery.knob.min.js"></script>
        <script src="assets/js/jquery.autosize.min.js"></script>
        <script src="assets/js/jquery.inputlimiter.1.3.1.min.js"></script>
        <script src="assets/js/jquery.maskedinput.min.js"></script>
        <script src="assets/js/bootstrap-tag.min.js"></script>
        <!-- ace scripts -->
        <script src="assets/js/ace-elements.min.js"></script>
        <script src="assets/js/ace.min.js"></script>
        <!-- inline scripts related to this page -->
        <script type="text/javascript">
            jQuery(function ($) {
                //we could just set the data-provide="tag" of the element inside HTML, but IE8 fails!
                var tag_input = $('#keywords');
                if (!(/msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()))) {
                    tag_input.tag(
                        {
                            placeholder: tag_input.attr('placeholder'),
                            //enable typeahead by specifying the source array
                            source: ace.variable_US_STATES,//defined in ace.js >> ace.enable_search_ahead
                        }
                    );
                }
                else {
                    //display a textarea for old IE, because it doesn't support this plugin or another one I tried!
                    tag_input.after('<textarea id="' + tag_input.attr('id') + '" name="' + tag_input.attr('name') + '" rows="3">' + tag_input.val() + '</textarea>').remove();
                    //$('#form-field-tags').autosize({append: "\n"});
                }
                var tag_input1 = $('#author');
                if (!(/msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()))) {
                    tag_input1.tag(
                        {
                            placeholder: tag_input.attr('placeholder'),
                            //enable typeahead by specifying the source array
                            source: ace.variable_US_STATES,//defined in ace.js >> ace.enable_search_ahead
                        }
                    );
                }
                else {
                    //display a textarea for old IE, because it doesn't support this plugin or another one I tried!
                    tag_input1.after('<textarea id="' + tag_input.attr('id') + '" name="' + tag_input.attr('name') + '" rows="3">' + tag_input.val() + '</textarea>').remove();
                    //$('#form-field-tags').autosize({append: "\n"});
                }


            });
        </script>

        <!-- page specific plugin styles -->
        <link rel="stylesheet" href="assets/css/colorbox.css" />
        <!-- page specific plugin scripts -->
        <script src="assets/js/jquery.colorbox-min.js"></script>
        <script>
            $(document).ready(function () {
                $(".group1").colorbox({ rel: 'group1' });
                $(".group2").colorbox({ rel: 'group2', transition: "fade" });
                $(".group3").colorbox({ rel: 'group3', transition: "none", width: "75%", height: "75%" });
                $(".group4").colorbox({ rel: 'group4', slideshow: true });
                $(".ajax").colorbox();
                $(".youtube").colorbox({ iframe: true, innerWidth: 640, innerHeight: 390 });
                $(".vimeo").colorbox({ iframe: true, innerWidth: 500, innerHeight: 409 });
                $(".iframe").colorbox({
                    iframe: true, width: "100%", height: "100%",
                    onClosed: function () {                      
                        get_tag();
                     
                    }
                });
                $(".inline").colorbox({ inline: true, width: "50%" });
              	$(".callbacks").colorbox({
					onOpen:function(){ alert('onOpen: colorbox is about to open'); },
					onLoad:function(){ alert('onLoad: colorbox has started to load the targeted content'); },
					onComplete:function(){ alert('onComplete: colorbox has displayed the loaded content'); },
					onCleanup:function(){ alert('onCleanup: colorbox has begun the close process'); },
					onClosed:function(){ alert('onClosed: colorbox has completely closed'); }
				});

                $('.non-retina').colorbox({ rel: 'group5', transition: 'none' })
                $('.retina').colorbox({ rel: 'group5', transition: 'none', retinaImage: true, retinaUrl: true });


          


            });

                
        var uploader = new plupload.Uploader({
                    runtimes: 'html5,flash,silverlight,html4',
                    browse_button: 'pickfiles', // you can pass in id...
                    container: document.getElementById('container'), // ... or DOM Element itself
                    url: '/spadmin/saveMultiUpload?kind=article',
                    multipart: true,
                    filters: {
                        max_file_size: '10mb',
                        mime_types: [
                            { title: "Image files", extensions: "jpg,gif,png" },
                            { title: "Zip files", extensions: "zip" }
                        ]
                    },

                    init: {
                        PostInit: function () {
                            document.getElementById('filelist').innerHTML = '';
                            document.getElementById('uploadfiles').onclick = function () {
                                uploader.start();
                                return false;
                            };
                        },

                        FilesAdded: function (up, files) {
                            plupload.each(files, function (file) {
                                document.getElementById('filelist').innerHTML += '<div id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b></div>';

                            });
                        },

                        UploadProgress: function (up, file) {
                            document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";

                        },

                        UploadComplete: function (up, files) {
                            alert('上傳完畢');
                            document.getElementById('filelist').innerHTML = "";
                        },
                        FileUploaded: function (up, file, res) {                                                       
                            var json = $.parseJSON(res.response);
                            document.getElementById('console').innerHTML = ("<img src=\"/webimages/article/" + json.result + "\">");
                            $("#logoPic").val(json.result);

                        },

                        Error: function (up, err) {
                            document.getElementById('console').innerHTML += "\nError #" + err.code + ": " + err.message;
                        }

                    }
                });

                uploader.init();

        </script>
    </form>
</body>
</html>
