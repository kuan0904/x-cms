<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_title" runat="Server">
 

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script >
        var companyinfo;
    function getdata() {   
    $.post('companyinfo.ashx', { "action": "get", "_": new Date().getTime() }, function (data) {       
        if (data != "") {             
            companyinfo = JSON.parse(data);                                         
            companyinfo = companyinfo[0];           
            $.each(companyinfo, function (key, val) {
                var data = val;
            
                var id = "#" + key
             
                if (key == 'logoPic') {
                    $(id).val(val);
                    document.getElementById('console').innerHTML = ("<img src=\"" + val + "\">");                  
                   
                }
                else if ($(id) != undefined) {
                    $(id).val(val);
                }
                
                   
            });

           

        }
    });     
}

    $(document).ready(function () {  
        getdata();
        $("#update").click(function () {
            var data = "{\"action\":\"set\"";              
            $.each(companyinfo, function (key, val) {
                var id = "#" + key                
                if ($(id) != undefined) {
                  
                    data += ",\"" + key + "\"" + ":" + "\"" + $(id).val() + "\"";                    
                }
                
            }); 
            data += "}";
            var data = JSON.parse(data);
            $.post('companyinfo.ashx',  data, function (data) {   
                if (data == '1') {
                    alert('更新完畢');
                };
                        
            });
        });
    });
    </script>
    <div class="page-header">
        <h1>公司基本資料設定
        </h1>
    </div>
    <!-- /.page-header -->

    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
       
                <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">公司名稱 </label>
                    <div class="col-sm-9">
                        <input type="text" id="companyName" placeholder="公司名稱" class="col-xs-10 col-sm-5" />
                    </div>
                </div>
                    <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">系統名稱 </label>
                    <div class="col-sm-9">
                        <input type="text" id="systemName" placeholder="系統名稱" class="col-xs-10 col-sm-5" />
                    </div>
                </div>
                   <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">公司統編 </label>
                    <div class="col-sm-9">
                        <input type="text" id="companyNo" placeholder="公司統編" class="col-xs-10 col-sm-5" />
                    </div>
                </div>
                  <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">聯絡電話</label>
                    <div class="col-sm-9">
                        <input type="text" id="phone" placeholder="聯絡電話" class="col-xs-10 col-sm-5" />
                    </div>
                </div>
                  <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">公司地址</label>
                    <div class="col-sm-9">
                        <input type="text" id="address" placeholder="地址" class="col-xs-10 col-sm-5" />
                    </div>
                </div>
                   <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">FacebookAppId</label>
                    <div class="col-sm-9">
                        <input type="text" id="FacebookAppId" placeholder="FacebookAppId" class="col-xs-10 col-sm-5" />
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">FacebookAppSecret</label>
                    <div class="col-sm-9">
                        <input type="text" id="FacebookAppSecret" placeholder="FacebookAppSecret" class="col-xs-10 col-sm-5" />
                    </div>
                </div>
                   <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">googleapi Key</label>
                    <div class="col-sm-9">
                        <input type="text" id="googleapiKey" placeholder="googleapi Key" class="col-xs-10 col-sm-5" />
                    </div>
                </div>
                 <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">google clientId</label>
                    <div class="col-sm-9">
                        <input type="text" id="googleclientId" placeholder="google clientId" class="col-xs-10 col-sm-5" />
                    </div>
                </div>
              <div class="form-group">
                     <label class="col-sm-3 control-label no-padding-right" for="form-field-1">公司logo 圖示</label>
        <script type="text/javascript" src="js/plupload.full.min.js"></script>
            <div id="filelist" class="col-sm-9">
                Your browser doesn't have Flash, Silverlight or HTML5 support.</div>
            <div id="container" class="col-sm-9">
                <input id="pickfiles" type="button" value="選擇檔案" style="height: 33px; width: 137px" />
                <input id="uploadfiles" type="button" value="上傳檔案" style="height: 33px; width: 137px" />
            </div>
                  <input id="logoPic" type="hidden" />
            <pre id="console" class="col-sm-9">

            </pre>
            <script type="text/javascript">
            $(document).ready(function(){

                $(document).on('click', '#sortable li a', function (event) {
                    if (confirm("你確定刪除") ){
                        $(this).parent().remove();
                    }
                    return false;
                });
   
          

            })
            </script>
            <script type="text/javascript">

                var uploader = new plupload.Uploader({
                    runtimes: 'html5,flash,silverlight,html4',
                    browse_button: 'pickfiles', // you can pass in id...
                    container: document.getElementById('container'), // ... or DOM Element itself
                    url: '/spadmin/saveMultiUpload?kind=companylogo',
                    multipart: true,
                 
                    filters: {
                        max_file_size: '10mb',
                        mime_types: [
			                { title: "Image files", extensions: "jpg,gif,png" },
			                { title: "Zip files", extensions: "zip" }
		                ]
                    },

                    init: {
                        PostInit: function() {
                            document.getElementById('filelist').innerHTML = '';
                            document.getElementById('uploadfiles').onclick = function() {
                                uploader.start();
                                return false;
                            };
                        },

                        FilesAdded: function(up, files) {
                            plupload.each(files, function(file) {
                                document.getElementById('filelist').innerHTML += '<div id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b></div>';
                                                 
                            });
                        },

                        UploadProgress: function(up, file) {
                            document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";
                        
                        },

                        UploadComplete: function (up, files) {
                            alert('上傳完畢');
                            document.getElementById('filelist').innerHTML = "";
                        },
                        FileUploaded: function (up, file, res) {
                            // alert(up);
                            //  alert(file.id);
                            var json = $.parseJSON(res.response);
                                document.getElementById('console').innerHTML = ("<img src=\"" + json.result + "\">");                  
                                $("#logoPic").val(json.result);

                        },

                        Error: function(up, err) {
                            document.getElementById('console').innerHTML += "\nError #" + err.code + ": " + err.message;
                        }

                    }
                });

                uploader.init();
    /**
                uploader.bind('FileUploaded', function (upldr, file, object) {
                    var myData;

                    try {
                        myData = eval(object.response);
                    } catch (err) {
                        myData = eval('(' + object.response + ')');
                    }
              
                  $("#pd_img ul").append('<li><a href="#">刪除</a><br><image src="/webimages/product/' + myData.result + '"><input type="hidden" name="pd_img" value="' + myData.result + '"</li>');
                });
                **/
    </script>
                  
                                <div style="display: none" class="col-sm-9">
                                    <div id="list_menu">
                                    </div>
                                    <div id="baseli" style="display: none">
                                        <div>
                                            <input type="button" value="刪除" class="btn btn-app btn-danger btn-sm" />
                                            <input type="file" name="myFile" />
                                        </div>
                                    </div>
                                    <input type="button" value="新增圖檔+" id="btnadd"/>
                                </div>  
                                <div id="pd_img" class="col-sm-9">    
                                    <ul id="sortable" class="gridImg">    
                                    </ul>

                               </div>    
        </div>

            
                <div class="space-4"></div>

                <div class="clearfix form-actions">
                    <div class="col-md-offset-3 col-md-9">
                        <button class="btn btn-info" type="button" id="update">
                            <i class="icon-ok bigger-110"></i>
                            更新內容
                        </button>

                        &nbsp; &nbsp; &nbsp;
											<button class="btn" type="reset">
                                                <i class="icon-undo bigger-110"></i>
                                                Reset
                                            </button>
                    </div>
                </div>

                <div class="hr hr-24"></div>

         </div>
        </div>
    

                    



</asp:Content>

