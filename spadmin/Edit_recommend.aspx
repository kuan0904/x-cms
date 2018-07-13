<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="Edit_recommend.aspx.cs" Inherits="spadmin_Edit_recommend" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
       
<script>
      $(function () {
          $("#<%=sdate.ClientID %>").datepicker();
          $("#<%=sdate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");
          $("#<%=edate.ClientID %>").datepicker();
          $("#<%=edate.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");
      });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">    
      <asp:MultiView ID="MultiView1" runat="server">

    <asp:View ID="View1" runat="server">	        
      <script>
          function preview() {

              window.open( "/index?kind=preview", '_blank');
              window.open( "/7/catalog?kind=preview", '_blank');
          
            
          }
              
      </script>
                    <div class="box-header well" data-original-title>   <%=unitname %>
  
                    <asp:LinkButton ID="Btn_add" runat="server" Text="" class="btn btn-large" OnClick ="Btn_add_Click" ><i class="icon-plus"></i>新增資料</asp:LinkButton>                                                                                                 
                      <button onclick ="preview();"><i class="icon-eye-open"></i>預覽</button>
                        <asp:LinkButton ID="LinkButton6" runat="server" OnClick ="LinkButton6_Click" CssClass ="btn-warning btn-lg"><i class="icon-exchange"></i>排序</asp:LinkButton>
                    </div>
                    <div class="box-content">                            
                  

                          <asp:ListView ID="ListView1" runat="server" DataKeyNames="bannerid"   OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging">
        
        
        <EmptyDataTemplate>
            <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>未傳回資料。</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <ItemTemplate>
        <tr>
            <td  style="text-align: center">
                <asp:LinkButton ID="LinkButton1" runat="server" Text="" OnClick="link_edit" CommandArgument='<%# Eval("bannerid")%>'
                    class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                <asp:LinkButton ID="LinkButton2" runat="server" Text="" OnClick="link_delete" OnClientClick="return confirm('你確定要刪除嗎?')"
                    CommandArgument='<%# Eval("bannerid").ToString()%>' class="btn btn-danger"><i class="icon-trash icon-white"></i>刪除</asp:LinkButton>                                                    
            </td>
            <td> <%#Eval("bannerid")%></td>                                            
            <td><a href='../webimages/banner/<%#Eval("filename")%>' target="_blank" ><img src='../webimages/banner/<%#Eval("filename")%>' height ="100" /></a> </td>
             <td><%#Eval("title")%></td>    <td><%#Eval("url")%></td>
               
                <td><%#Eval("sort")%></td>
                <td><%# Eval("enabledate").ToString ()%></td>
                <td><%#  Eval("disabledate") %></td>
                <td><%#( Eval("status").ToString() == "Y") ? "啟用": "停用"%></td>    
        </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server" >
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" class="table table-striped table-bordered bootstrap-datatable datatable">
                              <thead>
                            <tr runat="server" >
                                <th runat="server" >
                                    </th>
                                      <th runat="server" ><asp:LinkButton ID="sort1" runat="server" CommandArgument="desc" CommandName="bannerid" onclick ="sortdata">ID</asp:LinkButton></th>
                                    
                                    <th runat="server">圖檔</th>  <th runat="server">標題</th>
                                    <th runat="server">連結網址
                                    </th>                                   
                                       <th runat="server">優先<br/>順序
                                    </th>
                                        <th runat="server"><asp:LinkButton ID="LinkButton3" runat="server" CommandArgument="desc" CommandName="enabledate" onclick ="sortdata">啟用時間</asp:LinkButton></th>
                                    <th runat="server"><asp:LinkButton ID="LinkButton4" runat="server" CommandArgument="desc" CommandName="disabledate" onclick ="sortdata">停用時間</asp:LinkButton></th>
                                 <th runat="server"><asp:LinkButton ID="LinkButton5" runat="server" CommandArgument="desc" CommandName="status" onclick ="sortdata">狀態</asp:LinkButton></th>
                               
                                                                          
                            </tr>
                                  </thead> 
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" >  
                         

                   
                        <asp:DataPager ID="DataPager1" runat="server" class="pagenavi">

                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                <asp:NumericPagerField ButtonCount="10" NextPageText="下十頁" PreviousPageText="上十頁"  NumericButtonCssClass="accordion" />
                                <asp:NextPreviousPagerField ButtonType="Link" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                            </Fields>
                        </asp:DataPager>
                      
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        
    </asp:ListView>
                          </div>          
          
            	 
        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:HiddenField ID="Selected_id" runat="server" />
       
                    <div class="box-header well" data-original-title>
                        <h2>推薦管理</h2>
                    </div>
                    <div class="box-content">
                  
                            <table class="table table-striped table-bordered bootstrap-datatable datatable">
                                    <tr>
                                    <td> 圖檔</td>
                                    <td>
                                        <asp:FileUpload ID="FileUpload1" runat="server" />
                                        <br />
                                        <asp:Literal ID="Literal1" runat="server"></asp:Literal><asp:HiddenField ID="HiddenField1" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        連結網址</td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList2" runat="server" DataTextField="title" DataValueField="categoryid" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"></asp:DropDownList>
                                        <asp:DropDownList ID="DropDownList3" runat="server" ></asp:DropDownList>
                                       <br />
                                        <asp:TextBox ID="t_url" runat="server" Width="500px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        優先順序</td>
                                    <td>
                                        <asp:TextBox ID="t_sort" runat="server" size="1" TextMode="Number"></asp:TextBox>
                                    </td>
                                </tr>
                          
                                <tr>
                                    <td>
                                        啟用時間</td>
                                    <td>
                                        <asp:TextBox ID="sdate" runat="server" size="10"  required></asp:TextBox>                                   
                                         <asp:DropDownList ID="stime" runat="server">        
                                        </asp:DropDownList> 
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        停用時間</td>
                                    <td>
                                          <asp:TextBox ID="edate" runat="server"  size="10" ></asp:TextBox>                                        
                                         <asp:DropDownList ID="etime" runat="server">
                                        </asp:DropDownList> 
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        標題</td>
                                    <td> <asp:TextBox  runat="server" ID="t_title"  required Width="300px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        說明</td>
                                    <td> <asp:TextBox  runat="server" ID="contents"  Width="700px" ></asp:TextBox>
                                    </td>
                                </tr>            
                                <tr>
                                    <td>
                                        開新視窗</td>
                                    <td>
                                        <asp:dropdownlist ID="t_targetblank" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="N">N</asp:ListItem>
                                             <asp:ListItem Value="Y">Y</asp:ListItem>
                                        </asp:dropdownlist>
                                    </td>
                                      </tr> 
                            
                                 <tr>
                                    <td>
                                        狀態</td>
                                    <td>
                                        <asp:dropdownlist ID="t_status" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Y">Y</asp:ListItem>
                                            <asp:ListItem Value="N">N</asp:ListItem>
                                        </asp:dropdownlist>
                                    </td>
                                      </tr> 
                                <tr>
                                    <td>版位</td>
                                    <td>
                                        <asp:CheckBoxList ID="classid" runat="server" DataTextField="title"  style ="zoom:150%;"  DataValueField="classid" Font-Bold="True" Font-Size="X-Large"></asp:CheckBoxList></td>
                                        
                                    </tr>
                                   <tr>
                                  <td></td>
                                       <td>
                                    <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔"   OnClick ="Btn_save_Click" />
                                    <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" OnClick ="Btn_cancel_Click" />
                                    <asp:Button ID="btn_del" runat="server" class="btn btn-danger" OnClientClick="return confirm('你確定要刪除嗎?')" OnClick ="btn_del_Click" 

                                        Text="刪除"  /></td>
                                </tr>
                            </table>
                        </div>
                   
              
        </asp:View>
                    <asp:View ID="View3" runat="server">
                        <style>
                          #sortable { list-style-type: none; margin: 0; padding: 0; width: 700px; }
                          #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: 110px; height: 110px;}
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
                          <ul id="sortable" class="gridSort">
                              <asp:Repeater ID="Repeater1" runat="server">
                                  <ItemTemplate>
                                 <li class="ui-state-default">
                              <img src='../webimages/banner/<%#Eval("filename")%>' width ="100" /><br />
                                     <%# Eval("title")%>
                                      <input type="hidden" name ="bannerid" value ="<%#Eval("bannerid") %>"/>
                                     <input type="hidden" name ="sort" value ="<%#Eval("sort") %>"/>
                                </li>
                                  </ItemTemplate>
                              </asp:Repeater>
                               
                                   
                              </ul>   
                    
                        <asp:LinkButton ID="LinkButton7" runat="server"  OnClick ="LinkButton7_Click" CssClass ="btn-warning btn-lg"><i class="icon-bolt"></i>更新排序</asp:LinkButton>
        
                    </asp:View>
        
    </asp:MultiView>
    
                          
</asp:Content>
