<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="product.aspx.cs" Inherits="spadmin_product" validateRequest="False"%>
<%@ Register Assembly="CKFinder" Namespace="CKFinder" TagPrefix="CKFinder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

      <script type="text/javascript" src="js/plupload.full.min.js"></script>
        <script>
      $(function () {
          $("#<%=enabledate.ClientID %>").datepicker();
          $("#<%=enabledate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");
          $("#<%=disabledate.ClientID %>").datepicker();
          $("#<%=disabledate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");
      });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="DataOrderDataDataContext" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="order_list">
    </asp:LinqDataSource>
      <div class="box-header well" data-original-title>
                        <h2>產品管理    <asp:LinkButton ID="Btn_add" runat="server" Text="" class="btn btn-large" OnClick ="Btn_add_Click" ><i class="icon-plus"></i>新增資料</asp:LinkButton>
                        類別:<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource4" DataTextField="name" DataValueField="KindId">
                        </asp:DropDownList>
                        <asp:TextBox ID="search_txt" runat="server"></asp:TextBox>
                        庫存<asp:DropDownList ID="DropDownList2" runat="server">
                            <asp:ListItem Value ="">不區分</asp:ListItem>
                            <asp:ListItem Value =">">></asp:ListItem>
                            <asp:ListItem Value ="<"><</asp:ListItem>
                            <asp:ListItem Value ="=">=</asp:ListItem>                    
                          </asp:DropDownList>
                            
                            <asp:TextBox runat="server" ID="num" Width ="50" TextMode="Number"></asp:TextBox>
                        <asp:Button ID="btn_search" runat="server" Text=" 查 詢 " OnClick="btn_search_click" class="btn btn-success" /></h2>
          </div>
            <div class="box-content">

                 <asp:SqlDataSource ID="viewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>" SelectCommand=""></asp:SqlDataSource>

                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>" SelectCommand="SELECT * FROM [tbl_product_kind]"></asp:SqlDataSource>

                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                     
                        <asp:ListView ID="ListView1" runat="server" DataKeyNames="p_id"    OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging">


                            <EmptyDataTemplate>
                                <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                                    <tr>
                                        <td>未傳回資料。</td>
                                    </tr>
                                </table>
                            </EmptyDataTemplate>

                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="EditButton" runat="server" Text="" OnClick="link_edit" CommandName="Edit" CommandArgument='<%# Eval(" p_id")%>'
                                            class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                                          <asp:LinkButton ID="LinkButton1" runat="server" Text="" OnClick="link_edit" CommandName="copy" CommandArgument='<%# Eval(" p_id")%>'
                                            class="btn btn-success">複製</asp:LinkButton>
                                    </td>
                                    <td>
                                        <%# Eval("p_id") %>
                                    </td>
                                    <td>
                                        <%#  Eval("productcode")  %>
                                    </td>
                                    <td>
                                        <%# Eval("productname")  %>
                                    </td>
                                    <td>
                                        <%# Eval("name") %>
                                    </td>
                                       <td>
                                        <%# Eval("fcount") %>
                                    </td>
                                    <td>
                                        <%# Eval("addcart") %>
                                    </td>
                                    <td>
                                        <%# Eval("price2") %>
                                    </td>
                                    <td>
                                        <%# Eval("price3") %>
                                    </td>
                                    <td>
                                        <%# Eval("storage") %>
                                    </td>
                                    <td>
                                        <%# (Eval("status").ToString()  == "1") ? "啟用" : "關閉"  %>
                                    </td>
                                    <td>
                                        <a href="../productdetail.aspx?p_ID=<%#Eval("p_id") %>" target="_blank">預覽</a>
                                    </td>
                                       <td >
                                        <a href="../phone/shop/shoppingcart.aspx?p_ID=<%#Eval("p_id") %>" target="_blank" > <%#Eval("channel").ToString ()==""?"":"預覽" %></a>
                                    </td>


                                </tr>
                            </ItemTemplate>
                            <LayoutTemplate>
                                <table runat="server">
                                    <tr runat="server">
                                        <td runat="server">
                                            <table id="itemPlaceholderContainer" runat="server" class="table table-striped table-bordered bootstrap-datatable datatable">
                                                <thead>
                                                    <tr runat="server">
                                                        <th runat="server"></th>
                                                        <th runat="server"><asp:LinkButton ID="sort1" runat="server" CommandArgument="desc" CommandName="p_id" onclick ="sortdata">商品序號</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton2" runat="server" CommandArgument="desc" CommandName="productcode" onclick ="sortdata">商品代號</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton3" runat="server" CommandArgument="desc" CommandName="productname" onclick ="sortdata">商品名稱</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton4" runat="server" CommandArgument="desc" CommandName="kindid" onclick ="sortdata">類型</asp:LinkButton></th>
                                                        <th runat ="server"><asp:LinkButton ID="LinkButton10" runat="server" CommandArgument="desc" CommandName="fcount" onclick ="sortdata">收藏數</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton8" runat="server" CommandArgument="desc" CommandName="addcart" onclick ="sortdata">加入次數</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton5" runat="server" CommandArgument="desc" CommandName="price2" onclick ="sortdata">會員價</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton6" runat="server" CommandArgument="desc" CommandName="price3" onclick ="sortdata">優惠價</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton7" runat="server" CommandArgument="desc" CommandName="storage" onclick ="sortdata">庫存</asp:LinkButton></th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton9" runat="server" CommandArgument="desc" CommandName="status" onclick ="sortdata">狀態</asp:LinkButton></th>
                                                                    <th runat="server">網站</th><th runat="server">FB</th>
                                                    </tr>
                                                </thead>
                                                <tr id="itemPlaceholder" runat="server">
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server">  <button ><a href="report_product2.aspx" target="_blank">匯出檔案</a> </button>
                                            <asp:DataPager ID="DataPager1" runat="server" class="pagenavi">
                                                <Fields>
                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                    <asp:NumericPagerField ButtonCount="10" NextPageText="下十頁" PreviousPageText="上十頁" />
                                                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                                </Fields>
                                            </asp:DataPager>
                                        </td>
                                    </tr>
                                </table>
                            </LayoutTemplate>

                        </asp:ListView>

                        <asp:HiddenField runat="server" ID="Selected_id"></asp:HiddenField>
                    </asp:View>


                    <asp:View ID="View2" runat="server">
                     
                        <table class="table table-striped table-bordered bootstrap-datatable datatable">
                            <tr>
                                <td>商品序號</td>
                                <td>
                                    <asp:Label ID="p_id" runat="server"></asp:Label>
                                </td>

                                <td>商品代號</td>
                                <td>
                                    <asp:TextBox ID="productcode" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>商品名稱
                                </td>
                                <td>
                                    <asp:TextBox ID="productname" runat="server" Width="350px"></asp:TextBox></td>
                                <td>
                                    站內搜尋關鍵字</td>
                                <td>
                                    <asp:TextBox ID="keyword" runat="server"></asp:TextBox>
                                </td>                               
                            </tr>
                            <tr>
                                <td>商品屬性</td>
                                <td >
                                    <asp:DropDownList ID="kindid" runat="server">
                                    </asp:DropDownList>
                                    <asp:CheckBox ID="preorder" runat="server" />預購商品
                           <asp:CheckBox ID="usecash" runat="server" />不可使用折價券
                                </td>
                                <td>狀態</td>
                                <td>
                                    <asp:DropDownList ID="status" runat="server">
                                        <asp:ListItem Value="1">啟用</asp:ListItem>
                                        <asp:ListItem Value="0">停用</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>

                            <tr>
                                <td >價格</td>
                            <td>
                                    市價:<asp:TextBox ID="price1" runat="server" Width="100px"></asp:TextBox>/
                                    會員價:<asp:TextBox ID="price2" runat="server" Width="100px"></asp:TextBox>/
                                    優惠價:<asp:TextBox ID="price3" runat="server" Width="100px"></asp:TextBox></td>
                                <td>庫存量</td>
                                <td>
                                    <asp:TextBox ID="storage" runat="server" Width="100px"></asp:TextBox></td>

                            </tr>
                            <tr>
                                <td>FB</td>
                                <td>銷售
                                   <asp:CheckBox ID="channel" runat="server" /> FB售價:<asp:TextBox ID="fbprice" runat="server" Width="100px"></asp:TextBox></td>
                                <td></td>
                                <td>收藏數:<%=fcount %><br />
                                    加入購數車次數:<%=addcart %></td>
                            </tr>
                            <tr>
                                <td>上層群組</td>
                                <td>
                                           <asp:DropDownList ID="groupproductcode" runat="server"></asp:DropDownList>
                                 
                                </td>
                                <td>特殊配送   </td>
                                <td>     <asp:DropDownList ID="ship" runat="server">     
                                         <asp:ListItem>N</asp:ListItem>
                                        <asp:ListItem>Y</asp:ListItem>                                  
                                    </asp:DropDownList></td>
                           
                              
                            </tr>
                             <tr>
                                 <td>設為群組</td>
                                 <td><asp:DropDownList ID="isgroup" runat="server">
                                        <asp:ListItem>N</asp:ListItem>
                                        <asp:ListItem>Y</asp:ListItem>
                                    </asp:DropDownList></td>
                             <td>群組產品</td>
                            <td>
                                <asp:Literal ID="groupproductlabel" runat="server"></asp:Literal></td>
                                  </tr>
                                <tr>
                                <td>啟用時間</td>
                                <td>
                                    <asp:TextBox ID="enabledate" runat="server"></asp:TextBox>日<asp:DropDownList ID="enabledatetime" runat="server"></asp:DropDownList>時</td>
                                <td>停用時間</td>
                                <td>
                                    <asp:TextBox ID="disabledate" runat="server"></asp:TextBox>日<asp:DropDownList ID="disabledatetime" runat="server"></asp:DropDownList>時

                                </td>
                            </tr>

                            <script type="text/javascript">
                            $(document).ready(function(){

                                //取第一層類別
                                var data = {  "kind": "all", "Id": "", "_": new Date().getTime() };
                                var p_id = $("#ContentPlaceHolder1_p_id").text();
                              
                                $.ajax({
                                    type: "post",
                                    url: "../libs/Get_category.ashx",
                                    data: (data),                                 
                                    success: function (data) {                                       
                                        //tbl_category_class
                                        var data = JSON.parse(data);
                                        var Categories = data.tbl_category_class;                                    
                                        for (i = 0; i < 10; i++) {
                                           
                                            $("#CATEGORY_CLASS" + i + '_1').append($("<option></option>").attr("value", "0").text("請選擇"));
                                            $("#CATEGORY_CLASS" + i + '_2').append($("<option></option>").attr("value", "0").text("請選擇"));
                                            $("#CATEGORY_CLASS" + i + '_3').append($("<option></option>").attr("value", "0").text("請選擇"));

                                            $.each(Categories, function (key, val) {
                                               
                                                $("#CATEGORY_CLASS" + i + '_1').append($("<option></option>").attr("value", val.classId).text(val.title));
                                            });
                                         

                                        }                                       
                                    },
                                    error: (function (jqXHR, textStatus, errorThrown) {
                                        alert(jqXHR.responseText);                                        
                                    })
                                });

                                if (p_id != '') {
                                    //取二三層
                                    var secno = 0;
                                    data = {  "kind": "product_category", "p_id": p_id, "_": new Date().getTime() };
                                    $.ajax({
                                       type: "post",
                                       url: "../libs/Get_category.ashx/ProcessRequest",
                                       data: (data),
                                        success: function (data) {                                           
                                            var cid;                                        
                                            var data = JSON.parse(data);
                                           // var Categories = data.tbl_category_class;
                                            $.each(data["tbl_category"], function (key, val) {
                                                //$("#test").append(val.categoryid);
                                                cid = val.categoryid;  
                                                $("#CATEGORY_CLASS" + secno  + '_1').val(val.classId);
                                              
                                                $.each(data[cid], function (key, val) {
                                                    $("#CATEGORY_CLASS" + secno + '_2').append($("<option></option>").attr("value", val.categoryid).text(val.title));
                                                });
                                           
                                                if (val.parentid != "0") {
                                                    $.each(data[val.parentid], function (key, val) {
                                                        $("#CATEGORY_CLASS" + secno + '_3').append($("<option></option>").attr("value", val.categoryid).text(val.title));

                                                    });
                                                    $("#CATEGORY_CLASS" + secno + '_2').val(val.parentid);
                                                    $("#CATEGORY_CLASS" + secno + '_3').val(val.categoryid);
                                                }
                                                else {
                                                    $("#CATEGORY_CLASS" + secno + '_3').hide();
                                                    $("#CATEGORY_CLASS" + secno + '_2').val(val.categoryid);
                                                }
                                      
                                                secno++;
                                          
                                            });
                                        
                                            for (i = secno; i <10; i++) {
                                                $("#CATEGORY_CLASS" + i + '_3').hide();
                                                $("#CATEGORY_CLASS" + i + '_2').hide();

                                            }

                                        },
                                        error: (function (jqXHR, textStatus, errorThrown) {
                                            alert(jqXHR.responseText);                                        
                                        })
                                    });
                                }
                                $("select.CATEGORY_CLASS").change(function () { //設定事件發生
                                    var obj = this.id.replace("CATEGORY_CLASS", "");
                                   
                                    var lvl = obj.substring(2, 3);
                                    var idx = obj.substring(0, 1);
                                   
                                   var val = $(this).val();
                              
                                   if (lvl == "1") {
                                       data = { "kind": "child_category",  "classId": val, "categoryid": "" , "_": new Date().getTime()  };
                                   }else{
                                       data = { "kind": "child_category", "classId": "", "categoryid": val, "_": new Date().getTime() };
                                   }
                                   if (val != "0") {
                                       $.ajax({
                                           type: "post",
                                           url: "../libs/Get_category.ashx/ProcessRequest",
                                           data: (data),
                                           success: function (data) {
                                               var data = JSON.parse(data);
                                               if (lvl == "1") {
                                                   $("#CATEGORY_CLASS" + idx + '_2')
                                                    .find('option')
                                                    .remove()
                                                    .end()
                                                    .append('<option value="0">請選擇</option>')
                                                    .show()
                                                   ;
                                                   $("#CATEGORY_CLASS" + idx + '_3')
                                                       .find('option')
                                                       .remove()
                                                       .end()
                                                       .append('<option value="0">請選擇</option>')
                                                       .hide()
                                                   ;

                                                   $.each(data["tbl_category"], function (key, val) {
                                                       $("#CATEGORY_CLASS" + idx + '_2').append($("<option></option>").attr("value", val.categoryid).text(val.title));
                                                   });
                                               }
                                               if (lvl == "2") {
                                                   $("#CATEGORY_CLASS" + idx + '_3')
                                                    .find('option')
                                                    .remove()
                                                    .end()
                                                    .append('<option value="0">請選擇</option>')
                                                     .show()
                                                   ;
                                                   $.each(data["tbl_category"], function (key, val) {
                                                       $("#CATEGORY_CLASS" + idx + '_3').append($("<option></option>").attr("value", val.categoryid).text(val.title));
                                                   });

                                                   if ($("#CATEGORY_CLASS" + idx + '_3 option').length == 1) {
                                                       $("#CATEGORY_CLASS" + idx + '_3').hide();
                                                   }

                                               }




                                           },
                                           error: (function (jqXHR, textStatus, errorThrown) {
                                               alert(jqXHR.responseText);
                                           })
                                       });

                                   }

                                });
                            })
                        
                            </script>
                            <tr>
                                <td>商品分類</td>
                                <td colspan="3">
                                    <table >
                                        <tr>
                                        <td style ="vertical-align:top;">
                                            <select id="CATEGORY_CLASS0_1" name ="CATEGORY_CLASS1" class="CATEGORY_CLASS"></select><br />
                                            <select id="CATEGORY_CLASS0_2" name ="CATEGORY_CLASS2" class="CATEGORY_CLASS"></select><br /> 
                                            <select id="CATEGORY_CLASS0_3" name ="CATEGORY_CLASS3"></select>      
                                        </td>
                                        <td style ="vertical-align:top;">
                                            <select id="CATEGORY_CLASS1_1" name ="CATEGORY_CLASS1" class="CATEGORY_CLASS"></select><br />
                                            <select id="CATEGORY_CLASS1_2" name ="CATEGORY_CLASS2" class="CATEGORY_CLASS"></select><br /> 
                                            <select id="CATEGORY_CLASS1_3" name ="CATEGORY_CLASS3"></select>      
                                        </td>
                                        <td style ="vertical-align:top;">
                                            <select id="CATEGORY_CLASS2_1" name ="CATEGORY_CLASS1" class="CATEGORY_CLASS"></select><br />
                                            <select id="CATEGORY_CLASS2_2" name ="CATEGORY_CLASS2" class="CATEGORY_CLASS"></select><br /> 
                                            <select id="CATEGORY_CLASS2_3" name ="CATEGORY_CLASS3"></select>      
                                        </td>
                                        <td style ="vertical-align:top;">
                                            <select id="CATEGORY_CLASS3_1" name ="CATEGORY_CLASS1" class="CATEGORY_CLASS"></select><br />
                                            <select id="CATEGORY_CLASS3_2" name ="CATEGORY_CLASS2" class="CATEGORY_CLASS"></select><br /> 
                                            <select id="CATEGORY_CLASS3_3" name ="CATEGORY_CLASS3"></select>      
                                        </td>
                                         <td style ="vertical-align:top;">
                                            <select id="CATEGORY_CLASS4_1" name ="CATEGORY_CLASS1" class="CATEGORY_CLASS"></select><br />
                                            <select id="CATEGORY_CLASS4_2" name ="CATEGORY_CLASS2" class="CATEGORY_CLASS"></select><br /> 
                                            <select id="CATEGORY_CLASS4_3" name ="CATEGORY_CLASS3"></select>      
                                        </td>
                                        </tr>
                                    <tr>
                                        <td style ="vertical-align:top;">
                                            <select id="CATEGORY_CLASS5_1" name ="CATEGORY_CLASS1" class="CATEGORY_CLASS"></select><br />
                                            <select id="CATEGORY_CLASS5_2" name ="CATEGORY_CLASS2" class="CATEGORY_CLASS"></select><br /> 
                                            <select id="CATEGORY_CLASS5_3" name ="CATEGORY_CLASS3"></select>      
                                        </td>
                                        <td style ="vertical-align:top;">
                                            <select id="CATEGORY_CLASS6_1" name ="CATEGORY_CLASS1" class="CATEGORY_CLASS"></select><br />
                                            <select id="CATEGORY_CLASS6_2" name ="CATEGORY_CLASS2" class="CATEGORY_CLASS"></select><br /> 
                                            <select id="CATEGORY_CLASS6_3" name ="CATEGORY_CLASS3"></select>      
                                        </td>
                                        <td style ="vertical-align:top;">
                                            <select id="CATEGORY_CLASS7_1" name ="CATEGORY_CLASS1" class="CATEGORY_CLASS"></select><br />
                                            <select id="CATEGORY_CLASS7_2" name ="CATEGORY_CLASS2" class="CATEGORY_CLASS"></select><br /> 
                                            <select id="CATEGORY_CLASS7_3" name ="CATEGORY_CLASS3"></select>      
                                        </td>
                                        <td style ="vertical-align:top;">
                                            <select id="CATEGORY_CLASS8_1" name ="CATEGORY_CLASS1" class="CATEGORY_CLASS"></select><br />
                                            <select id="CATEGORY_CLASS8_2" name ="CATEGORY_CLASS2" class="CATEGORY_CLASS"></select><br /> 
                                            <select id="CATEGORY_CLASS8_3" name ="CATEGORY_CLASS3"></select>      
                                        </td>
                                         <td style ="vertical-align:top;">
                                            <select id="CATEGORY_CLASS9_1" name ="CATEGORY_CLASS1" class="CATEGORY_CLASS"></select><br />
                                            <select id="CATEGORY_CLASS9_2" name ="CATEGORY_CLASS2" class="CATEGORY_CLASS"></select><br /> 
                                            <select id="CATEGORY_CLASS9_3" name ="CATEGORY_CLASS3"></select>      
                                        </td>
                                        </tr>
                           
                         
                                        </table>



                                </td>

                            </tr>

                            <tr>
                                <td>商品圖片</td>
                                <td colspan ="3">
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

                        UploadComplete: function (up, files) {
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
                                <div id="pd_img">    
                                    <ul id="sortable" class="gridImg">    
                                        <asp:Literal ID="pd_imglist" runat="server"></asp:Literal>       
                                    </ul>

                               </div>                            

                                </td>

                            </tr>
                            <tr>
                                <td>影片連結</td>
                                <td colspan="3">
                                    <asp:TextBox ID="videourl" runat="server" Width ="500"></asp:TextBox>
                                    <%= yuurl  %>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>商品簡介</td>
                                <td colspan="3">
                                        <asp:TextBox ID="briefcont" runat="server" TextMode="MultiLine" Height="600px" Width="750px"></asp:TextBox>
                                        <script>
                                            CKEDITOR.replace('<%=briefcont.ClientID  %>');
                                        </script>   
                                  

                                </td>
                            </tr>
                            <tr>
                                <td>商品規格</td>
                                <td colspan="3">
                                  
                                       <asp:TextBox ID="spec" runat="server" TextMode="MultiLine" Height="300px" Width="750px"></asp:TextBox>
                                        <script>
                                            CKEDITOR.replace('<%=spec.ClientID  %>');
                                        </script>   
                                  
                                </td>
                            </tr>
                            <tr>
                                <td>商品介紹</td>
                                <td colspan="3">
                                   
                                     <asp:TextBox ID="description" runat="server" TextMode="MultiLine" Height="600px" Width="750px"></asp:TextBox>
                                        <script>
                                            CKEDITOR.replace('<%=description.ClientID  %>');
                                        </script>   

                                </td>
                            </tr>
                            <tr>
                                <td>使用方法</td>
                                <td colspan="3">
                      
                           
                                        <asp:TextBox ID="howtouse" runat="server" TextMode="MultiLine" Height="200px" Width="750px"></asp:TextBox>
                                        <script>
                                            CKEDITOR.replace('<%=howtouse.ClientID  %>');
                                        </script>   

                                </td>
                            </tr>

                            <tr>
                                <td>備註說明</td>
                                <td colspan="3">                          
                                    
                                    <asp:TextBox ID="memo" runat="server" TextMode="MultiLine" Height="200px" Width="750px"></asp:TextBox>
                                    <script>
                                        CKEDITOR.replace('<%=memo.ClientID  %>');
                                    </script>   

                                </td>
                            </tr>
                                <tr>
                                <td>tvmall 備註說明</td>
                                <td colspan="3">                                                              
                                    <asp:TextBox ID="Remarks" runat="server" TextMode="MultiLine" Height="200px" Width="750px"></asp:TextBox>                                   
                                </td>
                            </tr>
                          
                        </table>

  <script>
      $(function () {
          $("#<%=enabledate.ClientID %>").datepicker();
          $("#<%=enabledate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");
          $("#<%=disabledate.ClientID %>").datepicker();
          $("#<%=disabledate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");
      });

            function checkinput() {
               
                var obj = "ContentPlaceHolder1_";
                var kindid = $("#<% =kindid.ClientID %>").val();
                 if ($("#<% =price1.ClientID %>").val() == '' && kindid != 12) {
                    alert('市價未輸入');
                    return false;
                }         
         
                if (  $("#<% =channel.ClientID  %>").prop('checked') == true && $("#<%=fbprice.ClientID %>").val()=='') {
                    alert('FB售價未輸入');
                    return false;
                }
                if ($("#<%=price2.ClientID %>").val() == '' && kindid != 12) {
                    alert('會員價未輸入');
                    return false;
                }
                               
                if ($("#<%= productcode.ClientID %>").val() == '') {
                    alert('商品代號未輸入');
                    return false;
                }
                if ($("#<%=productname.ClientID %>").val() == '') {
                    alert('商品名稱未輸入');
                    return false;
                }
                if ($("#<%=storage.ClientID %>").val() == '') {
                    alert('庫存量未輸入');
                    return false;
                }
                if ($("#<%=enabledate.ClientID %>").val() == '' && kindid != 12) {
                    alert('上架日未輸入');
                    return false;
                }
                      
                for (i = 0; i < 10; i++) {
                                       
                    if ($("#CATEGORY_CLASS" + i + '_1').val() != "0" && $("#CATEGORY_CLASS" + i  + '_2').val() == "0") {
                        alert('第' + (i + 1) + '個第二層未選');
                        return false;
                    }

                    if ($("#CATEGORY_CLASS" + i + '_2').val() != "0" &&  $("#CATEGORY_CLASS" + i + '_3').val() == "0" && $("#CATEGORY_CLASS" + i + '_3').is(':visible')) {
                        alert('第' + (i + 1) + '個第三層未選'); 
                        return false;

                    }
                }
                                   
            }

        </script>

                        <table class="table table-striped table-bordered bootstrap-datatable datatable">
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text=" 存 檔 " OnClientClick="return checkinput();" OnClick="Btn_save_Click" />
                                    <asp:Button ID="Btn_cancel" runat="server" class="btn" Text=" 取 消 " OnClick="Btn_cancel_Click" />
                               <input id="Btn_back" type="button" value=" 返  回 " onclick="history.back();" class="btn btn-primary" />
                                        </td>

                            </tr>
                        </table>





                    </asp:View>

                </asp:MultiView>

            </div>
    
</asp:Content>
