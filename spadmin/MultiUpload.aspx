<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="MultiUpload.aspx.cs" Inherits="spadmin_MultiUpload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <!-- multi upload -->

    <script type="text/javascript" src="js/plupload.full.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
     
        <div id="filelist">
            Your browser doesn't have Flash, Silverlight or HTML5 support.</div>
        <div id="container">
            <input id="pickfiles" type="button" value="選擇檔案" style="height: 33px; width: 137px" />
            <input id="uploadfiles" type="button" value="上傳檔案" style="height: 33px; width: 137px" />
        </div>
        <br />
        <pre id="console"></pre>

        <script type="text/javascript">
            // Custom example logic

            var uploader = new plupload.Uploader({
                runtimes: 'html5,flash,silverlight,html4',
                browse_button: 'pickfiles', // you can pass in id...
                container: document.getElementById('container'), // ... or DOM Element itself
                url: '/spadmin/saveMultiUpload?p_id=<%= p_id %>',
                multipart: true,
                //flash_swf_url : 'js/Moxie.swf',
                //silverlight_xap_url : 'js/Moxie.xap',

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
                        alert('上傳完畢');
                        document.getElementById('filelist').innerHTML = "";
                    },
                    FileUploaded: function (up, file, res) {
                       // alert(up);
                      //  alert(file.id);
                        var json = $.parseJSON(res.response);                     
                        $("#pd_img ul").append('<li><a href="#">刪除</a><br><image src="/webimages/product/' + json.result + '"><input type="hidden" name="pd_img" value="' + json.result + '"</li>');


                    },
                    Error: function(up, err) {
                        document.getElementById('console').innerHTML += "\nError #" + err.code + ": " + err.message;
                    }

                }
            });

            uploader.init();
            uploader.bind('FileUploaded', function (upldr, file, object) {
                var myData;
               
                try {
                    myData = eval(object.response);
                } catch (err) {
                    myData = eval('(' + object.response + ')');
                }
               // alert(myData.result);
             
            });
</script>

    </div>
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
    <br />
    <hr />
  
    <asp:Button ID="Btn_save" runat="server" class="button001" Height="33px" Width="137px"
        Text="存 檔"  />
    <asp:Button ID="Btn_cancel" runat="server" class="button001" Height="33px" Width="137px"
        Text="取 消"  />
    <br />
    <br />
  
            <div id="pd_img">    
            <ul id="sortable" class="gridImg">
    
                <asp:Literal ID="pd_imglist" runat="server"></asp:Literal>
       
            </ul>

       </div>
     
</asp:Content>