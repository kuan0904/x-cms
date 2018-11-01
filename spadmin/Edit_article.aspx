<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="Edit_article.aspx.cs" Inherits="spadmin_Edit_article" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_title" runat="Server">
 <script >
    $.extend({
      jYoutube: function( url, size ){
        if(url === null){ return ""; }

        size = (size === null) ? "big" : size;
        var vid;
        var results;

        results = url.match("[\?&]v=([^&#]*)");

        vid = ( results === null ) ? url : results[1];

        if(size == "small"){
          return "http://img.youtube.com/vi/"+vid+"/2.jpg";
        }else {
          return "http://img.youtube.com/vi/"+vid+"/0.jpg";
        }
      }
    });
    $(document).ready(function () {

    
        $('img:first').click(function() {
            $('iframe:first').fadeToggle('400');
        });
  
    // Get youtube video thumbnail on user click
    var url = '';
    $('#youtubeurl').blur(function(){
            // Check for empty input field
            if($('#youtubeurl').val() != ''){
                // Get youtube video's thumbnail url
                // using jYoutube jQuery plugin
                url = $.jYoutube($('#youtubeurl').val());
            
                // Now append this image to <div id="thumbs">
                $('#thumbs').append($('<img src="'+url+'" />'));
            }
        });
    });

     $(function () {
          $("#postday").datepicker();
          $("#postday").datepicker("option", "dateFormat", "yy/mm/dd");

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
                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="articleId" OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging">
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
                                                             <th runat="server">分類</th>
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
                    CommandArgument='<%# Eval("articleId").ToString()%>' class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>                                                    
            
                                    <asp:LinkButton ID="LinkButton2" runat="server" Text="" OnClick="link_delete" OnClientClick="return confirm('你確定要刪除嗎?')"
                    CommandArgument='<%# Eval("articleId").ToString()%>' class="btn btn-danger"><i class="icon-trash icon-white"></i>刪除</asp:LinkButton> 
                    
                <button type="button" class="btn btn-primary" name="preview" onclick ="p('<%# Eval("articleid") %>');"><i class="icon-external-link icon-white"></i>預覽</button>  <br />
                       
                                    </td> 
                                <td>
                                    <%# Eval("articleid") %>
                                </td>
                                 <td>
                                   <%# article.Web.Get_category_link ((int)Eval ("articleid")).Replace ("</a>","</a><br>") %>
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
                    $('#SubTitle').val(result.SubTitle);     
                    $('#keywords').val(result.Keywords);                 
                    $('#author').val(result.Author);
                    $("#status").prop("checked", result.Status == "Y" ? true : false);
                    $('#youtubeurl').val(result.YoutubeUrl);     
                    $("#recommend").prop("checked", result.Recommend  == "Y" ? true : false);
                    $('#postDay').val(result.PostDay);   
                    CKEDITOR.instances['contents'].setData(result.Contents);                           
                    document.getElementById('console').innerHTML = ("<img src=\"" + result.Pic + "\" width=300>");
                  
                    $('#logoPic').val(result.Pic); 
                    $("#youtubeurl").trigger("blur");
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
        });
    
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
            var status = $("#status").prop("checked") == true ? "Y" : "N";   
            var postday = $("#postday").val();

            if (status == "Y") {
                var Checked = $('input[name="tags"]:checked').length > 0;
                if (Checked == false) {
                    //  errmsg += ('請勾選標籤\r\n');
                }
                Checked = $('input[name="categoryid"]:checked').length > 0;
                if (Checked == false) {
                    errmsg += ('請勾選分類\r\n');
                }

                if ($("#postday").val() == '') {
                    errmsg += ('請輸入發佈日期\r\n');
                }
                if ($("#logoPic").val() == '') {
                    errmsg += ('文章主圖未上傳\r\n');
                }
            } else {
                
            }
            if (postday =="")  postday = "2018/1/1";
            var categoryid = $('input:checkbox:checked[name="categoryid"]').map(function () { return $(this).val(); }).get();
            var tags = $('input:checkbox:checked[name="tags"]').map(function () { return $(this).val(); }).get();              
            var recommend = $("#recommend").prop("checked") == true ? "Y" : "N";     
            var dataValue = {
                Id: articleId,
                Subject: $("#subject").val(),
                SubTitle: $("#SubTitle").val(),
                Contents: content,
                Pic: $("#logoPic").val(),
                PostDay: postday,
                Status: status,
                Viewcount: "0",
                Keywords: $("#keywords").val(),               
                Category: categoryid,
                Recommend: recommend,
                Tags: tags,
                Author: $("#author").val(),               
                kind: "A",                
                Tempid :"",
                YoutubeUrl:$("#youtubeurl").val(),
                    Lesson: [{
                        Id: 0, StartDay:"", EndDay: "", Lecturer: [], Lessontime: "", Address:"" ,
                        LessonDetail: { Id: 0, LessonId: 0, Price: 0, Sellprice:0, Limitnum:0, Description: "" }
                    }]
             
            };
          //   var result = dataValue.postdata[0];         
         
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
                        history.back();
                    }
                    else
                    {
                        alert(result);
                    }
                }
            });

        }
   
    </script>

    
            <div class="widget-body">
                <div class="widget-main padding-4">
                    <div class="tab-content padding-8 overflow-visible">
                        <div id="item1" class="tab-pane active">
                            <table style="background-color: #FFFFFF">
                                <tr>
                                    <td>文章所屬分類(*)</td>
                                    <td>
                                        <label id="category"></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>主標題(*)</td>
                                    <td>
                                        <input id="subject" type="text" style="width: 500px" placeholder="必填"  /></td>
                                </tr>       
                                <tr>
                                    <td>副標題</td>
                                    <td>
                                        <textarea id="SubTitle" name="SubTitle" cols="80" rows="3"></textarea>
                                   </td>
                                </tr>
                                <tr>
                                    <td>youtube連結</td>
                                    <td> <input id="youtubeurl" type="text" style="width: 500px" placeholder="youtube連結"  />
                                      <br />
                                        <span id="thumbs"></span>
                                    </td>
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
                                <tr>
                                    <td colspan="2">
                                        <ul id="detailitem">
                                        </ul>
                                    </td>

                                </tr>
                                <tr><td></td>
                                    <td>
                                    <a  class="iframe cboxElement"   href='editImages.aspx?type=image&kind=photoQuickUpload"';"><i  class="btn btn-greyicon icon-camera" >相簿管理</i></a>   
                                   <a class="iframe cboxElement"  href='editImages.aspx?type=file&kind=photoQuickUpload';"><i class="btn btn-grey icon-book">檔案管理</i></a>   
                      
                                    </td>
                                </tr>
                                <tr>
                                   <td colspan="2" align="center">
                                        
                                        <button type="button" class="btn btn-danger icon-save" id="btn_save">存 檔</button>
                                        <button type="button" class="btn btn-success icon-eye-open" id="preview">預 覽</button>
                                          <asp:Button ID="Btn_cancel" runat="server" class="btn icon-undo" Text="取 消" OnClick ="Btn_cancel_Click" />
                                      

                                   </td>
                                </tr>
                            </table>
                        </div>
                       
                                    

                                   
                    </div>
                </div>
                <!-- /widget-main -->
            </div>
            <!-- /widget-body -->
   
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
                        placeholder: tag_input1.attr('placeholder') ,
                        //enable typeahead by specifying the source array
                       
                        source: ace.variable_US_STATES,//defined in ace.js >> ace.enable_search_ahead
                    }
                );
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
    <script>
    $(function () {
        var availableTags = [<%=getword()%>
        ];
        function split(val) {
            return val.split(/,\s*/);
        }
        function extractLast(term) {
            return split(term).pop();
        }
         //與TAG 結合下拉
        $(".tags input[type='text']")            
            .on("keydown", function (event) {
                if (event.keyCode === $.ui.keyCode.TAB &&
                    $(this).autocomplete("instance").menu.active) {
                    event.preventDefault();
                }
            })
            .autocomplete({
                minLength: 0,
                source: function (request, response) {
                    // delegate back to autocomplete, but extract the last term
                    response($.ui.autocomplete.filter(
                        availableTags, extractLast(request.term)));
                },
                focus: function () {
                    // prevent value inserted on focus
                    return false;
                },
                select: function (event, ui) {
                    var terms = split(this.value);
                    // remove the current input
                    terms.pop();
                    // add the selected item
                    terms.push(ui.item.value);
                    // add placeholder to get the comma-and-space at the end
                    terms.push("");

                    this.value = terms.join(", ");
                    return false;
                }
            });
    });
</script>
                </asp:View>
                </asp:MultiView>

            </div>
        </div>
    </div>
     
       
</asp:Content>

