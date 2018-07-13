<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="editImages.aspx.cs" Inherits="spadmin_editImages" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

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

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_title" runat="Server">
           <style>
                          #sortable { list-style-type: none; margin: 0; padding: 0; width: 800px; }
                          #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: 210px; height: 210px;}
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                        url: 'saveMultiUpload.aspx?kind=photoQuickUpload&articleid=<%= Request.QueryString["articleId"] %>',
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

                            UploadComplete: function(up, files) {
                               location.reload(); // 完成重新整理 
                            },

                            Error: function(up, err) {
                                document.getElementById('console').innerHTML += "\nError #" + err.code + ": " + err.message;
                            }

                        }
                    });

                    uploader.init();

</script>

                <div class="form-actions" style="text-align: center">
                    <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔" ValidationGroup="check1" OnClick ="Btn_save_Click"  />
                    <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消"  OnClick ="Btn_cancel_Click"/>
                </div>
                <ul id="sortable" class="gridImg">
                <asp:Repeater ID="Repeater_page" runat="server" >
   
                    <ItemTemplate>
                        <li class="ui-state-default">  
                       
                            <input name="Hidden_id" type="hidden" value='<%# Eval("imgid") %>' />
                            <asp:HiddenField ID="Hidden_id" runat="server" Value='<%# Eval("imgid") %>' />
                            <asp:CheckBox ID="chk_del" runat="server" Text="刪除" /><br />
                           
                            <img src='/webimages/gallery/<%#Eval("mainImg") %>' width="200"/><br />
                           <asp:TextBox ID="TextBox1" runat="server" Text ='<%#Eval("link").ToString () %>' disableSelection></asp:TextBox>
                           
                        </li>
                    </ItemTemplate>
                 
                </asp:Repeater> </ul>
                連結輸入請先按滑鼠右鍵
             
         
</asp:Content>
