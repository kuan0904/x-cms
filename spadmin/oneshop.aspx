<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="oneshop.aspx.cs" Inherits="spadmin_oneshop" %>
<%@ Register Assembly="CKFinder" Namespace="CKFinder" TagPrefix="CKFinder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

      
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="DataOrderDataDataContext" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="OrderData">
    </asp:LinqDataSource>
    <div class="box-header well" data-original-title>
                        <h2>一頁電商 </h2>
        <asp:LinkButton ID="Btn_add" runat="server" Text="" class="btn btn-large" OnClick ="Btn_add_Click" ><i class="icon-plus"></i>新增資料</asp:LinkButton>
                        類別:<asp:DropDownList ID="DropDownList1" runat="server" DataTextField="title" DataValueField="categoryid">
                        </asp:DropDownList>
                        <asp:TextBox ID="search_txt" runat="server"></asp:TextBox>
                        <asp:Button ID="btn_search" runat="server" Text=" 查 詢 " OnClick="btn_search_click" class="btn btn-success" />
          </div>
            <div class="box-content">

        
             <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                     
                        <asp:ListView ID="ListView1" runat="server" DataKeyNames="packageid"    OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging">
                            
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
                                        <asp:LinkButton ID="EditButton" runat="server" Text="" OnClick="link_edit"  CommandArgument='<%# Eval("packageid")%>'
                                            class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                                          <asp:LinkButton ID="LinkButton1" runat="server" Text="" OnClick="link_edit" CommandName="copy" CommandArgument='<%# Eval("packageid")%>'
                                            class="btn btn-success">複製</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-danger" CommandArgument='<%# Eval("packageid").ToString()%>' OnClick="link_delete" OnClientClick="return confirm('你確定要刪除嗎?')" Text=""  ><i class="icon-trash icon-white"></i>刪除</asp:LinkButton>
                                    </td>
                                    <td><%# Eval("packageid") %></td>
                                    <td><img src='../upload/<%#  Eval("logo")  %>?<%=DateTime.Now.ToString ("yyyyMMddhhmmss") %>' width ="100" /></td>
                                  
                                    <td><%# Eval("packagename")  %></td>                                
                                                         
                                    <td>
                                        <%# (Eval("status").ToString()  == "Y") ? "上架" : "下架"  %>
                                    </td>
                                    <td><%#Eval("viewcount") %></td>
                                    <td><%#Eval("sort") %></td>
                                    <td>
                                        <a href="/1shop/<%#Eval("packageid") %>" target="_blank">預覽</a>
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
                                                        <th runat="server"><asp:LinkButton ID="sort1" runat="server" CommandArgument="desc" CommandName="packageid" onclick ="sortdata">商品序號</asp:LinkButton></th>
                                                        <th runat="server">圖片</th>
                                                      
                                                        <th runat="server"><asp:LinkButton ID="LinkButton3" runat="server" CommandArgument="desc" CommandName="productname" onclick ="sortdata">商品名稱</asp:LinkButton></th>                                                                                             
                                                                                                         
                                                        <th runat="server"><asp:LinkButton ID="LinkButton9" runat="server" CommandArgument="desc" CommandName="status" onclick ="sortdata">狀態</asp:LinkButton></th>
                                                     <th runat ="server" >瀏覽數</th>
                                                       <th runat ="server" >排序</th>
                                                           <th runat="server"></th>
                                                    </tr>
                                                </thead>
                                                <tr id="itemPlaceholder" runat="server">
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr runat="server">
                                        <td runat="server">
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

                    </asp:View>


                    <asp:View ID="View2" runat="server">
                     
                        <table class="table table-striped table-bordered bootstrap-datatable datatable">
                            <tr>
                                <td>組合序號</td>
                                <td><asp:Label ID="packageid" runat="server"></asp:Label></td>        
                                  <td>供應商</td>
                                <td >
                                    <asp:DropDownList ID="supplierid" runat="server" >
                                    </asp:DropDownList>                             
                                </td>   
                            </tr>
                            <tr>
                                <td>組合名稱</td>
                                <td colspan="3"><asp:TextBox ID="packagename" runat="server" Width="350px"></asp:TextBox></td>                                                                          
                                                    
                            </tr>
                                               
                  
                            <tr>
                                <td>運費</td>
                                <td>    
                                    <asp:TextBox ID="shippingfee" runat="server" TextMode="Number"></asp:TextBox>
                                	
                                    </td> 
                                <td>免運費金額</td>
                                <td> <asp:TextBox ID="freeship" runat="server" TextMode="Number"></asp:TextBox></td>
                          
                            </tr>      
                            <tr>
                                      <td>排序</td>
                                <td>
                                    <asp:TextBox ID="sort" runat="server"></asp:TextBox></td>
                                 <td>運送方式</td>
                                <td> <asp:DropDownList ID="shippingKind" runat="server">
                                    </asp:DropDownList>        
                                  </td>  
                            </tr>    
                            <tr>
                                <td>
                                    選擇商品
                                </td>
                                <td colspan ="3">
                                    <table>
                                        <tr>
                                            <td>可銷售</td>
                                            <td>商品</td>
                                             <td>品名</td>
                                            <td>售價</td>
                                            <td>數量</td>
                                        </tr>
                                   
                                    <asp:Repeater ID="Repeater1" runat="server">
                                        <ItemTemplate>
                                        <tr>
                                            <td>
                                             <asp:CheckBox ID="CheckBox1" runat="server" />
                                            </td>
                                          <td>
                                              <asp:HiddenField ID="HiddenField1" runat="server"  Value ='<%#Eval("p_id") %>' />
                                                 <img src="/upload/<%#Eval("logo") %>"  width ="100"/>

                                          </td>
                                            <td>
                                                <%#Eval("productname") %>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="price" runat="server" TextMode="Number"></asp:TextBox></td>
                                          <td>
                                              <asp:TextBox ID="storage" runat="server" TextMode="Number">></asp:TextBox>
                                          </td>
                                        </tr>
                                        </ItemTemplate>
                                      
                                    </asp:Repeater>
                                         </table>
                                </td>
                            </tr>
                            <tr>
                                <td>商品介紹</td>
                                <td  colspan="3">                                   
                                     <asp:TextBox ID="description" runat="server" TextMode="MultiLine" Height="800px" Width="750px"></asp:TextBox>
                                        <script>
                                            CKEDITOR.replace('<%=description.ClientID  %>');
                                        </script>   

                                </td>
                            </tr>
                            <tr>
                                <td>注意事項</td>
                                <td colspan="3">
                                    <asp:TextBox ID="ReMark" runat="server" TextMode="MultiLine" Width ="500" Height ="100"></asp:TextBox></td>
                           
                            </tr>
                            <tr>
                                <td>退換貨規則</td>
                                 <td colspan="3">
                                    <asp:TextBox ID="Refunds" runat="server" TextMode="MultiLine" Width ="500" Height ="100"></asp:TextBox></td>
                            </tr>
                           
                  
                            <tr>
                                  <td>狀態</td>
                                <td>
                                    <asp:DropDownList ID="status" runat="server">
                                        <asp:ListItem Value="Y">上架</asp:ListItem>
                                        <asp:ListItem Value="N">下架</asp:ListItem>
                                        <asp:ListItem Value="D">刪除</asp:ListItem>
                                    </asp:DropDownList></td>
                                   <td>流覽數</td>  
                                <td>	<a href="#" id="id-btn-dialog1" class="btn btn-purple btn-sm">測試按紐</a>
                                        <div id="dialog-message" class="hide">
                                        <table>
                                  
							                <tr>
                                                <td>主圖片</td>
                                                    <td colspan="3"> 
                                                    <asp:FileUpload ID="FileUploadlogo" runat="server" />
                                                    <asp:Image ID="Imagelogo" runat="server" />
                                                    </td> 
                                            </tr>
                                    
                                        
                                        </table>
										<div class="hr hr-12 hr-double"></div>											
										</div><!-- #dialog-message -->

                                </td>
                                </tr>
                          
                            
                          
                        </table>
                        	
  <script>
    
            function checkinput() {
                var obj = "ContentPlaceHolder1_";
              
                if ($("#<%=packagename.ClientID %>").val() == '') {
                    alert('商品名稱未輸入');
                    return false;
                }      
           
                   
             
                                   
            }

        </script>

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
         $(document).ready(function () {
             $("#id-btn-dialog1").on('click', function (e) {
              
					e.preventDefault();
			
					var dialog = $( "#dialog-message" ).removeClass('hide').dialog({
						modal: true,
						title: " jQuery UI Dialog",
						title_html: true,
						buttons: [ 
							{
								text: "Cancel",
								"class" : "btn btn-xs",
								click: function() {
									$( this ).dialog( "close" ); 
								} 
							},
							{
								text: "OK",
								"class" : "btn btn-primary btn-xs",
								click: function() {
									$( this ).dialog( "close" ); 
								} 
							}
						]
					});
			
					
				});
			

	});
         $(function () {
            

        var availableTags = [''];
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
    <asp:HiddenField ID="Selected_id" runat="server" />
</asp:Content>

