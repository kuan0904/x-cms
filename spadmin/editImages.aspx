<%@ Page Title="" Language="C#"   AutoEventWireup="true" CodeFile="editImages.aspx.cs" Inherits="spadmin_editImages" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title></title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />

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


    <script type="text/javascript">
        var i = 0;
        $(function() {
            $(document).on('click', '.btnremove', function(event) {
                $(this).parent().remove();
            });

            $("#btnadd").click(function() {
                $("#list_menu").append($("#baseli").html());
                $("#list_menu").find("[name=myFile]").attr('name', 'myFile' + i);
                i++;
            });

            //-----------------------------------------

            $("#select_layear").selectmenu();

        });

    </script>

    <!-- multi upload -->

    <script type="text/javascript" src="js/plupload.full.min.js"></script>

           <style>
                          #sortable { list-style-type: none; margin: 0; padding: 0; width: 1020px; }
                          #sortable li { margin: 1px 1px 1px 0; padding: 1px; float: left; width: 210px; height: 210px;}
                          </style>
                           <script type="text/javascript">
           $(function() {
               $("#sortable").sortable({
                     cancel: ".ui-state-disabled",                  
                     update: function( event, ui ) {
                                              
                          //paget 歸位
                          var pagecount = 10;    
                          
                          for(var x=0; x< Math.ceil($("#sortable li").length / (pagecount+1)); x++){
                          
                            //to前進
                            var page_to = x *(pagecount+1) ; 
                            if($("#sortable li").eq(page_to+1).attr('class') == "ui-state-disabled"){
                               $($("#sortable li").eq(page_to)).insertAfter( $("#sortable li").eq(page_to+1)); 
                            }
                         
                            //from後退                          
                             var page_from = x *(pagecount+1) ; 
                             if($("#sortable li").eq(page_from-1).attr('class') == "ui-state-disabled"){
                               $($("#sortable li").eq(page_from-1)).insertAfter( $("#sortable li").eq(page_from)); 
                             }  
                          }                        
  
                     }
               });
               
               $("#sortable").disableSelection();
           });

        </script>    
    </head>
<body>
     <form id="form1" runat="server">
         		
    <div style="display: none">
        <div id="list_menu">
        </div>
        <div id="baseli" style="display: none">
            <div>
                <input type="button" value="刪除" class="btnremove" />
                <input type="file" name="myFile" />
            </div>
        </div>
        <input type="button" value="新增圖檔+" id="btnadd">
    </div>
    <div class="row-fluid">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2>
                    相簿</h2>
            </div>
            <div class="box-content">
                <div id="filelist">
                    Your browser doesn&#39;t have Flash, Silverlight or HTML5 support.</div>
                <div id="container" style="text-align: center">
                    <a id="pickfiles" class="btn btn-large" href="javascript:"><i class="icon-folder-open">
                    </i>選擇檔案</a> <a id="uploadfiles" class="btn btn-large" href="javascript:"><i class="icon-upload">
                    </i>上傳檔案</a>
                </div>
                <br />
                <pre id="console"></pre>

                <script type="text/javascript">
                    // Custom example logic

                    var uploader = new plupload.Uploader({
                        runtimes: 'html5,flash,silverlight,html4',
                        browse_button: 'pickfiles', // you can pass in id...
                        container: document.getElementById('container'), // ... or DOM Element itself
                        url: 'saveMultiUpload.aspx?kind=photoQuickUpload&type=<%= Request.QueryString["type"] %>',
                        filters: {
                            max_file_size: '10mb',
                            mime_types: [
			                    { title: "Image files", extensions: "jpg,gif,png" },
                                { title: "Zip files", extensions: "zip" },
                                { title: "Doc", extensions: "Doc,Docx" },
                                { title: "ppt", extensions: "ppt,pptx" },
                                { title: "Execl", extensions: "xls,xlsx" },
                                  { title: "Pdf", extensions: "pdf" },
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

                            UploadComplete: function(up, files) {
                               location.reload(); // 完成重新整理 
                            },

                            Error: function(up, err) {
                                document.getElementById('console').innerHTML += "\nError #" + err.code + ": " + err.message;
                            }

                        }
                    });

                    uploader.init();
    $(document).ready(function() {
       
        $("#rtn").click(function() {
            parent.$.colorbox.close();
            return false;
        })
    });
</script>

                <div class="form-actions" style="text-align: center">
                    <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="更新排序及狀態" ValidationGroup="check1" OnClick ="Btn_save_Click"  />
                  <button class="btn btn-primary" id="rtn">返回</button> 
                </div>
                 連結輸入請先按滑鼠右鍵
                <ul id="sortable" class="gridImg">
                <asp:Repeater ID="Repeater_image" runat="server" >   
                    <ItemTemplate>
                        <li class="ui-state-default">  
                       
                            <input name="img_id" type="hidden" value='<%# Eval("imgid") %>' />
                            <asp:HiddenField ID="img_id" runat="server" Value='<%# Eval("imgid") %>' />
                            <asp:CheckBox ID="chk_del" runat="server" Text="刪除" /><br />
                           
                            <img src='/webimages/gallery/<%#Eval("filename") %>' width="200"/><br /><br />
                           <asp:TextBox ID="TextBox1" runat="server" Text ='<%#Eval("link").ToString () %>'  ></asp:TextBox>
                           
                        </li>
                    </ItemTemplate>
                 
                </asp:Repeater> 
        
                <asp:Repeater ID="Repeater_file" runat="server" >   
                    <ItemTemplate>
                        <li class="ui-state-default">  
                       
                            <input name="file_id" type="hidden" value='<%# Eval("imgid") %>' />
                            <asp:HiddenField ID="file_id" runat="server" Value='<%# Eval("imgid") %>' />
                                                   
                            <img src="/images/<%#  Showico (Eval("filename").ToString ()) %>" width ="80"/> <br />
                            <asp:CheckBox ID="chk_del" runat="server" Text="刪除" /><br />  <%#Eval("filename") %><br />
                           <asp:TextBox ID="TextBox1" runat="server" Text ='<%#Eval("link").ToString () %>' ></asp:TextBox>
                           
                        </li>
                    </ItemTemplate>
                 
                </asp:Repeater> </ul>
               
             
         
                			
    </form>
</body>
</html>
