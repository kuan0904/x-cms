<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="Edit_article.aspx.cs" Inherits="spadmin_Edit_article" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
   input[type=checkbox] {              
                color: #999;
                font-weight: bold;
                font-size: 11px;
                line-height: 18px;             
                height: 20px;
                overflow: hidden;              
                background-color: #f5f5f5;             
                border: 1px solid #CCC;
                text-align: left;
                float: left;
                padding: 0;
                width: 40px;
               
            }

     

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_title" runat="Server">
   <script>
      $(function () {
          $("#postday").datepicker();
          $("#postday").datepicker("option", "dateFormat", "yy/mm/dd");

      });

</script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <button><a href="article.aspx" class='iframe' >add</a></button>
    <div class="row-fluid">
        <div class="box span12">
          <div class="box-content">
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                    <asp:LinkButton ID="Btn_add" runat="server" Text="" class="btn btn-large" OnClick ="Btn_add_Click" ><i class="icon-plus"></i>新增資料</asp:LinkButton>                                                                                                 
                    <asp:ListView ID="ListView1" runat="server" DataKeyNames="c_id" >
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
                                    <asp:LinkButton ID="EditButton" runat="server" Text="" OnClick="link_edit" CommandName="Edit" CommandArgument='<%# Eval("c_id")%>'
                                        class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>

                                </td>
                                <td>
                                    <%# Eval("articleid") %>
                                </td>
                                <td>
                                    <%# Eval("title") %>
                                </td>
                                <td>
                                    <%# Eval("pic") %>
                                </td>
                                <td>
                                    <%# Eval("status") %>
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
							<div class="widget-body">
								<div class="widget-main">
									<div id="fuelux-wizard" class="row-fluid" data-target="#step-container">
										<ul class="wizard-steps">
											<li data-target="#step1" class="active">
												<span class="step">1</span>
												<span class="title">主內容維護</span>
											</li>

											<li data-target="#step2" >
												<span class="step">2</span>
												<span class="title">明細內容維護</span>
											</li>

															
										</ul>
									</div>

									<hr />
            
            <div class="widget-body">
                <div class="widget-main padding-4">
                    <div class="tab-content padding-8 overflow-visible">
                        <div id="item1" class="tab-pane active">   
                        <table>
                        <tr>
                            <td>主標題</td>
                            <td>
                                <input id="subject" type="text" /></td>
                        </tr>
                        <tr>
                            <td>次標題</td>
                            <td>
                                <input id="subtitle" type="text" /></td>
                        </tr>
                        <tr>
                            <td>主圖示</td>
                            <td>
                                    <script type="text/javascript" src="js/plupload.full.min.js"></script>
                        <div id="filelist" class="col-sm-9">
                        Your browser doesn't have Flash, Silverlight or HTML5 support.</div>
                            <div id="container" class="col-sm-9">
                                <input id="pickfiles" type="button" value="選擇檔案"  />
                                <input id="uploadfiles" type="button" value="上傳檔案"  />
                            </div>
                            <input id="logoPic" type="hidden" />
                            <pre id="console" class="col-sm-9">

                            </pre>
                            <script type="text/javascript">

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
                                                document.getElementById('console').innerHTML = ("<img src=\"/webimages/article/" + json.result + "\">");                  
                                                $("#logoPic").val(json.result);

                                        },

                                        Error: function(up, err) {
                                            document.getElementById('console').innerHTML += "\nError #" + err.code + ": " + err.message;
                                        }

                                    }
                                });

                                uploader.init();

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
    


                            </td>
                        </tr>

                        <tr>
                            <td>內容</td>
                            <td>  <input id="contents" type="text"   />
                               
                                <script>
                                    CKEDITOR.replace('contents');
                                </script>        

                            </td>

                        </tr>
                        <tr>
                            <td>標籤</td>
                            <td>	
                                <asp:CheckBoxList ID="tag" runat="server"  RepeatDirection="Horizontal" RepeatLayout="Table"></asp:CheckBoxList>
							</td>
											
                        </tr>
                        <tr>
                            <td>作者</td>
                            <td>	
                            <asp:CheckBoxList ID="writer" runat="server"  RepeatDirection="Horizontal" RepeatLayout="Table"></asp:CheckBoxList>
							</td>
                        </tr>
                        <tr>
                            <td>關鍵字</td>
                            <td><input type="text" name="keywords" id="form-field-tags" value="" width="600px" placeholder="請輸入關鍵字 ..." />
									
							</td>
                        </tr>
                        <tr>
                            <td>發佈日</td>
                            <td>
                             
                                <input id="postday"  type="text" />
                            </td>

                        </tr>
                        <tr>
                            <td>狀態</td>
                            <td>
                                <asp:DropDownList ID="status" runat="server" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5">
                                    <asp:ListItem Value="Y">開啟</asp:ListItem>
                                    <asp:ListItem Value="N">關閉</asp:ListItem>


                                </asp:DropDownList>

                            </td>
                        </tr>
                             
                        </table>
                        </div>

                        <div id="item2" class="tab-pane">
                                 
                            標題:<input id="Text1" type="text" /><br />
                                           

                            <div class="hr hr-double hr8"></div>
                        </div>

   
                                
                    </div>
                </div><!-- /widget-main -->
            </div><!-- /widget-body -->

									<hr />
									<div class="row-fluid wizard-actions">
                                            <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔" />
                                <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" />
										<span class="btn btn-prev" id="btn-prev" >
											<i class="icon-arrow-left" ></i>  
											主內容
										</span>
                                                       
										<span class="btn btn-success btn-next"  id="btn-next">
										明細內容
											<i class="icon-arrow-right icon-on-right"></i>
										</span>
									</div>
								</div><!-- /widget-main -->
							</div><!-- /widget-body -->
                     
<script type="text/javascript">
    var MainData={
      id:"",
       title:"", 
       subtitle:"", 
       pic: "",
       contents:"",
       postday: "",
       tags: "",
       writer: "",
       keyword:"",
       status:""

    }
    var item = new Array();  
    var itemdata = {
        secno:"",
        title: "", 
       subtitle:"", 
       pic: "",
       contents:"",
     
    }

    function cleartxt() {
        $("#subject").val('');
        $("#subtitle").val('');
        $("#contents").val('');
                                    
    }
    $(document).ready(function(){
                              
        $( "#btn-next" ).click(function() {
            MainData.title = $("#subject").val();
            MainData.subtitle = $("#subtitle").val();
            MainData.contents = $("#contents").val();
            MainData.pic = $("#logoPic").val();
            MainData.keyword = $("#keywords").val();
            MainData.postday = $("#postday").val();
            MainData.status = $("#keywords").val();
            MainData.tags = $("#keywords").val();
            $('.wizard-steps li').eq(1).addClass('active');
            cleartxt();           
        });
        $( "#btn-prev" ).click(function() {
            $("#subject").val(MainData.title);
            $("#subtitle").val(MainData.subtitle);
            $("#contents").val(MainData.contents);
            $("#logoPic").val(MainData.pic);
            $("#keywords").val(MainData.keyword);
            $("#postday").val(MainData.postday);
                                   
                                   
            $('.wizard-steps li').eq(1).removeClass("active");
                          
        });
        $(document).on('click', '#sortable li a', function (event) {
            if (confirm("你確定刪除") ){
                $(this).parent().remove();
            }
            return false;
        });
   
          

    })
    </script>
                               
                        

                    </asp:View>
                 
                </asp:MultiView>

            </div>
        </div>
    </div>
</asp:Content>

