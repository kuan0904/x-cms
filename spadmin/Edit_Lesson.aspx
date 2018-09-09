<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="Edit_Lesson.aspx.cs" Inherits="spadmin_Edit_Lesson" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_title" runat="Server">
    <script>
     $(function () {
        $("#postday").datepicker();
        $("#postday").datepicker("option", "dateFormat", "yy/mm/dd");
        $("#startday").datepicker();
        $("#startday").datepicker("option", "dateFormat", "yy/mm/dd");
        $("#endday").datepicker();
        $("#endday").datepicker("option", "dateFormat", "yy/mm/dd");
        });
           function p(id) {
            window.open("/Article/" + id);
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
                   
    <div class="row-fluid">
        <div class="box span12">
          <div class="box-content">
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">    
                    <div class="box-header well" data-original-title>
                        <asp:TextBox ID="searchtxt" runat="server"></asp:TextBox><asp:Button ID="Btn_find"  class="btn btn-yellow" runat="server" Text="搜尋"  OnClick ="Btn_find_Click"/>
                        <asp:LinkButton ID="btn_add" runat="server" Text=""  OnClick ="btn_add_Click"  class="btn btn-app btn-primary btn-xs"><i class="icon-edit bigger-230"></i>新增資料</asp:LinkButton> 
                    </div>
                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="articleId" >
                        <EmptyDataTemplate>
                            <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                                <tr>
                                    <td>未傳回資料。</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                                <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table id="itemPlaceholderContainer" runat="server" class="table table-striped table-bordered bootstrap-datatable datatable">
                                            <thead>
                                                <tr runat="server">
                                                    <th runat="server"></th>
                                                    <th runat="server">id</th>
                                                    <th runat="server">標題</th>
                                                    <th runat="server">圖示</th>
                                                    <th runat="server">狀態</th>
                                                    <th runat="server">上稿日</th>                                                       
                                                </tr>
                                            </thead>
                                            <tr id="itemPlaceholder" runat="server">
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server">
                                        <div class="pagenavi">
                                            <asp:DataPager ID="DataPager1" runat="server">
                                                <Fields>
                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                    <asp:NumericPagerField ButtonCount="10" NextPageText="下十頁" PreviousPageText="上十頁" />
                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                </Fields>
                                            </asp:DataPager>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>                         
                                       <asp:LinkButton ID="LinkButton1" runat="server" Text=""  OnClick="LinkButton1_Click"
                    CommandArgument='<%# Eval("articleId").ToString()%>' class="btn btn-info"><i class="icon-trash icon-white"></i>編輯</asp:LinkButton>                                                    
            
                                    <asp:LinkButton ID="LinkButton2" runat="server" Text="" OnClick="link_delete" OnClientClick="return confirm('你確定要刪除嗎?')"
                    CommandArgument='<%# Eval("articleId").ToString()%>' class="btn btn-danger"><i class="icon-trash icon-white"></i>刪除</asp:LinkButton>                                                    
              <button type="button" class="btn btn-primary" name="preview" onclick ="p('<%# Eval("articleid") %>');"><i class="icon-external-link icon-white"></i>預覽</button>  <br />
                       
                                </td>
                                <td>
                                    <%# Eval("articleid") %>
                                </td>
                                <td>
                                    <%# Eval("subject") %>
                                </td>
                                <td>
                                   <img src="/webimages/article/<%# Eval("pic") %>" width ="300" />
                                </td>
                                <td>
                                    <%# Eval("status").ToString () =="Y" ? "上架":"下架" %>
                                </td>                            
                                <td>
                                    <%# DateTime .Parse(Eval("postday").ToString()).ToString("yyyy/MM/dd") %>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:ListView>
                    <asp:HiddenField runat="server" ID="Selected_id"></asp:HiddenField>
                    </asp:View>
                <asp:View ID="View2" runat="server">
        <script>
        var articleId = '<%=articleId%>';
        var maindata; 
        var flag;
        function get_data() {
             if (articleId != "0") {
                var dataValue = "{articleId:'"+  articleId +"'}";             
                $.postJSON('article.aspx/get_tbl_article', dataValue, 'application/json; charset=utf-8', function (result) {
                    var result = result.d;
                    result = JSON.parse(result);
                    maindata = result;     
                   
                    $('#postday').datepicker("setDate", new Date(result.PostDay));
                    $('#subject').val(result.Subject);                                           
                    $('#keywords').val(result.Keywords);    
                    $('#subtitle').val(result.SubTitle);          
                    $("#status").prop("checked", result.Status  == "Y" ? true : false);
                    $("#recommend").prop("checked", result.Recommend  == "Y" ? true : false);
                    CKEDITOR.instances['contents'].setData(result.Contents);                           
                    document.getElementById('console').innerHTML = ("<img src=\""+ result.Pic + "\" width=300>");
                    $('#logoPic').val(result.Pic); 
                   
                    if (result.Lesson[0] != undefined) {
                        $('#address').val(result.Lesson[0].Address);  
                        $('#lessontime').val(result.Lesson[0].Lessontime);
                        $('#startday').datepicker("setDate", new Date(result.Lesson[0].StartDay));
                        $('#endday').datepicker("setDate", new Date(result.Lesson[0].EndDay));
                        var detail = result.Lesson[0].LessonDetail;                  
                        $.each(detail, function (key, val) {                      
                            var v = ' <div class="row-fluid"> <div class="box-content"><input type="button" class="mod" value="修改">';
                            v += '<input type="button" class="delete" value="刪除"><br>';
                            v += '序號:<span class = "lessonid">' + val.LessonId + '</span><br>';
                            v += '說明:<span class="description">' + val.Description + '</span> <BR>';
                            v += '課程費用(原價):<span class="sellprice">' + val.Sellprice + '</span><br>';
                            v += '課程費用(特價):<span class="price">' + val.Price + '</span><br>';
                            v += '可報名人數:<span class="limitnum">' + val.Limitnum + '</span><b ></div></div> ';
                            $('#detailitem').append('<li style="background-color: #C0C0C0">' + v + '</li>');
                         });   
                    }
                
                  
                });
            }
        }

        $(document).ready(function () {            
            get_data();          
            $("#preview").click(function () {
                check_data('p');
            });
            $("#btn_save").click(function () {
                check_data('s');
            });         
            get_category();  
            get_lecturer();

              $("#btl_add").click(function () {
               // 新增明細資料
                var errmsg = "";
                var description = $("#description").val();
                var price = $("#price").val();
                var sellprice = $("#sellprice").val();
                var limitnum = $("#limitnum").val();
                var lessonid = $("#lessonid").val();
                if (description == '') {
                    errmsg += ('請輸入課程說明\r\n');
                  }
                if (sellprice == '') {
                    errmsg += ('請輸原價\r\n');
                }
                if (price == '') {
                    errmsg += ('請輸入特價\r\n');
                  }
                if (limitnum == '') {
                    errmsg += ('請輸入可報名人數\r\n');
                }
                if (errmsg == '') {
                   
                    var v = ' <div class="row-fluid"> <div class="box-content"><input type="button" class="mod" value="修改">';
                    v += '<input type="button" class="delete" value="刪除"><br>';
                    v += '序號:<span class = "lessonid">' + lessonid + '</span><br>';
                    v += '說明:<span class="description">' + description + '</span> <BR>';
                    v += '課程費用(原價):<span class="sellprice">' + sellprice + '</span><br>';
                    v += '課程費用(特價):<span class="price">' + price + '</span><br>';
                    v += '可報名人數:<span class="limitnum">' + limitnum + '</span><b ></div></div> ';
                 
                    if ($("#lessonid").val() == "") {
                        $('#detailitem').append('<li style="background-color: #C0C0C0">' + v + '</li>');//新增LI
                    }
                    else {
                        $("ul#detailitem li").eq($("#lessonid").val()).html(v); //修改明細LI
                    }
                    $("#description").val('');
                    $("#price").val('');
                    $("#sellprice").val('');
                    $("#limitnum").val('');
                    $("#lessonid").val('');
                   // $('#recent-tab a[href="#item1"]').tab('show')
                    $("#btl_add").html("新增資料");
                } else {
                    alert(errmsg);
                }
            });
            $("#btl_cel").click(function () {
                $('#recent-tab a[href="#item1"]').tab('show') //返回主內容
            });
            $("ul#detailitem").on("click", "li", function () { //取得修改的明細
                var num = $(this).index();             
                $("#lessonid").val(num);
                $("#price").val($(this).find('.price').text());
                $("#description").val($(this).find('.description').text());
                $("#limitnum").val($(this).find('.limitnum').text());
                $("#sellprice").val($(this).find('.sellprice').text());
                $("#btl_add").html("更新資料");
                // $('#recent-tab a[href="#item3"]').tab('show')
            })
            $(document).on('click', '.delete', function (event) { //刪掉明細li
                if (confirm('你確定嗎?')) { $(this).parent().remove(); }

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
          function get_lecturer() {
            var dataValue = "{ kind: 'get' }";
              $.postJSON('article.aspx/get_lecturer', dataValue, 'application/json; charset=utf-8', function (result) {
                 
                if (result != "") {
                    var result = result.d;
                    result = JSON.parse(result);
                    result = result.main;
                    var cb = "";
                    var s = "";
  
                    $.each(result, function (key, val) {     
                      
                        s = maindata.Lesson[0].Lecturer == undefined ? "" : check_cbx(maindata.Lesson[0].Lecturer, val.id);
                        cb += "<input name='lecturerid' class='ace ace-checkbox-2' type='checkbox' value='" + val.id + "'" + s + "><span class=lbl>" + val.name + "</span>";
                });       
                 
                   $("#lecturer").html(cb);                    
                }
            });
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
              //  errmsg += ('請勾選標籤\r\n');
            }
            Checked = $('input[name="categoryid"]:checked').length > 0;
            if (Checked == false) {
                errmsg += ('請勾選分類\r\n');
            }       
        
           if ( $("#postday").val() == '') {
                errmsg += ('請輸入發佈日期\r\n');
            }
            if ( $("#logoPic").val() == '') {
                errmsg += ('文章主圖未上傳\r\n');
            }
            if ($("#startday").val() == '') {
                errmsg += ('請輸入活動開始日期\r\n');
            }
            if ($("#endday").val() == '') {
                errmsg += ('請輸入活動開始日期\r\n');
            }
            if ($("#lessontime").val() == '') {
                errmsg += ('請輸入上課時間說明\r\n');
            }
            if ($("#address").val() == '') {
                errmsg += ('請輸入上課地點\r\n');
            }

            var categoryid = $('input:checkbox:checked[name="categoryid"]').map(function () { return $(this).val(); }).get();
            var tags = $('input:checkbox:checked[name="tags"]').map(function () { return $(this).val(); }).get();  
            var lecturerid = $('input:checkbox:checked[name="lecturerid"]').map(function () { return $(this).val(); }).get();
            var status = $("#status").prop("checked") == true ? "Y" : "N";   
            var recommend = $("#recommend").prop("checked") == true ? "Y" : "N";     
        
         var Detail = "[";
            var i = 0;
            $("ul#detailitem li").each(function () {
                i++;              
                if (i != 1) { Detail += ","; }
                var lid = $(this).find('.lessonId').text();
                if (lid == "") lid = 1;
      

                    Detail += "{\"Id\":\"" + articleId + "\"";
                    Detail += ",\"LessonId\":\"" + lid + "\"";
                    Detail += ",\"Description\":\"" +  $(this).find('.description').text()  + "\"";
                    Detail += ",\"Price\":\"" + $(this).find('.price').text() + "\"";
                    Detail += ",\"Sellprice\":\"" + $(this).find('.sellprice').text() + "\"";
                    Detail += ",\"Limitnum\":\"" + $(this).find('.limitnum').text() + "\"}";
            });    
            Detail += "]";
       
           Detail = JSON.parse(Detail);      
            var dataValue = {
                 id: articleId, subject: $("#subject").val(), subtitle: $("#subtitle").val()
                , contents: content, pic: $("#logoPic").val(), keywords: $("#keywords").val()
                , status: status, categoryid: categoryid
                , tags: tags, author: "", postday: $("#postday").val(),recommend:recommend
                ,  kind: "L",
                Lesson: [{
                    Id: articleId, StartDay: $("#startday").val(), EndDay: $("#endday").val(), Lecturer: lecturerid,
                    Lessontime: $("#lessontime").val(), Address: $("#address").val(),
                    LessonDetail: Detail
                }]
            };

            if (errmsg == '') {
                $.postJSON('article.aspx/Set_data', JSON.stringify(dataValue), 'application/json; charset=utf-8', function (result) {
                    result = result.d;
                    if (result == '')
                        if (kind == "s") {
                            save_db();
                        }
                        else if (kind == 'p') {
                            window.open('/detail');

                        }
                    else
                        alert(result);
                });

            } else {
                alert(errmsg);
            }
        }    
        function save_db() {
             var dataValue = "{ kind: 'get' }";
            $.postJSON('article.aspx/Set_DB', dataValue, 'application/json; charset=utf-8', function (result) {
                if (result != "") {
                    var result = result.d;
                    if (result == '')
                    {
                        alert('已存檔');
                         location.href = location.href;
                    }
                    else
                    { alert(result); }
                }
            });

        }
   
    </script>

            <div class="widget-box transparent" id="recent-box">
            <div class="widget-header">
                <div>
                    <ul class="nav nav-tabs" id="recent-tab">
                        <li class="active">
                            <a data-toggle="tab" href="#item1">課程內容</a>
                        </li>
                           <li>
                            <a data-toggle="tab" href="#item2">開課設定</a>
                        </li>
                        <li>
                      <!--      <a data-toggle="tab" href="#item3">段落內容</a>-->
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
                                    <td>課程所屬分類(*)</td>
                                    <td>
                                        <label id="category"></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>課程名稱(*)</td>
                                    <td>
                                        <input id="subject" type="text" style="width: 500px" placeholder="必填"  /></td>
                                </tr>
                                <tr>
                                    <td>課程說明</td>
                                    <td>
                                        <input id="subtitle" type="text" style="width: 500px;height:100px;" /></td>
                                </tr>
                                <tr>
                                    <td>主圖示(750x500)(*)</td>
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
                                    <td>內容(*)</td>
                                    <td>
                                        <input id="contents" type="text" style="height: 600px" />
                                        <script>
                                            CKEDITOR.replace('contents');
                                        </script>
                                    </td>
                                </tr>                   
              
                                <tr>
                                    <td>
                                        開始時間</td>
                                    <td>
                                        <input id="startday" type="text" size="10"  />
                                       
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        結束時間</td>
                                    <td>  <input id="endday" type="text" size="10"  />
                                       
                                    </td>
                                </tr>
                                <tr>
                                    <td>上課時間說明</td>
                                    <td><input id="lessontime" type="text" size="60"  /> </td>
                                </tr>
                                <tr>
                                   <td>地址</td>
                                   <td><input id="address" type="text" size="100"  /> </td>
                               </tr>   
                                <tr>
                                    <td>講師管理</td>
                                    <td>  <label id="lecturer"></label><br />  
                                        <a href="Edit_tag.aspx?unitid=14" class="iframe cboxElement"><i class="icon-double-angle-right"></i>講師管理</a>
                              
                                    </td>
                                  </tr>

                                <tr>
                                    <td>關鍵字</td>
                                    <td>
                                        <input type="text" name="keywords" id="keywords" value=""   placeholder="請輸入關鍵字 ..." />
                                    </td>
                                </tr>
                                <tr>
                                    <td>發佈日(*)</td>
                                    <td>
                                        <input id="postday" type="text" />
                                    </td>
                                </tr> 
                                   <tr>
                                    <td>推薦</td>
                                    <td>
                                        <input id="recommend" name="recommend" type="checkbox" class="ace ace-switch ace-switch-6" />
                                        <span class="lbl"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>狀態</td>
                                    <td>
                                        <input id="status" name="status" type="checkbox" class="ace ace-switch ace-switch-6" />
                                        <span class="lbl"></span>
                                    </td>
                                </tr>
                                      <tr><td></td>
                                    <td>
                                    <a  class="iframe cboxElement"   href='editImages.aspx?type=image&kind=photoQuickUpload"';"><i  class="btn btn-greyicon icon-camera" >相簿管理</i></a>   
                                   <a class="iframe cboxElement"  href='editImages.aspx?type=file&kind=photoQuickUpload';"><i class="btn btn-grey icon-book">檔案管理</i></a>   
                      
                                    </td>
                                </tr>
                                <tr>
                                   <td colspan="2"  align ="center">
                                        
                                       <button type="button" class="btn btn-danger icon-save" id="btn_save">存 檔</button>
                                        <button type="button" class="btn btn-success icon-eye-open" id="preview">預 覽</button>
                                          <asp:Button ID="Btn_cancel" runat="server" class="btn icon-undo" Text="取 消" OnClick ="Btn_cancel_Click" />
                                         </td>
                                </tr>
                            </table>
                        </div>
          
                        <div id="item2" class="tab-pane">

                   
                            <table >
                                <tr>
                                    <td>說明</td>
                                    <td><input id="description" type="text"    /></td>
                                </tr>
                               <tr>
                                   <td>課程費用(原價)</td>
                                   <td> <input id="sellprice" type="number"    /> </td>
                               </tr>
                                <tr>
                                   <td>課程費用(特價)</td>
                                   <td>  <input id="price" type="number"    /> </td>
                               </tr>   
                                      <tr>
                                    <td>可報名人數</td>
                                    <td> <input id="limitnum" type="number"     /> </td>
                                  </tr>
                                <tr>

                                    <td colspan="2"> <input id="lessonid" type="hidden" value=""   /> <button type="button" class="btn btn-primary" id="btl_add">新增資料</button></td>
                                </tr>
              
                                <tr>
                                    <td colspan="2">
                                        <ul id="detailitem" >
                                        </ul>
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
                </asp:View>
                 
                </asp:MultiView>

            </div>
        </div>
    </div>
     
       
 

</asp:Content>

