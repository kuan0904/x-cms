﻿<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="product.aspx.cs" Inherits="spadmin_product" validateRequest="False"%>
<%@ Register Assembly="CKFinder" Namespace="CKFinder" TagPrefix="CKFinder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

      
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="DataOrderDataDataContext" EnableInsert="True" EnableUpdate="True" EntityTypeName="" TableName="OrderData">
    </asp:LinqDataSource>
    <div class="box-header well" data-original-title>
                        <h2>產品管理  </h2>
        <asp:LinkButton ID="Btn_add" runat="server" Text="" class="btn btn-large" OnClick ="Btn_add_Click" ><i class="icon-plus"></i>新增資料</asp:LinkButton>
                        類別:<asp:DropDownList ID="DropDownList1" runat="server" DataTextField="title" DataValueField="categoryid">
                        </asp:DropDownList>
                        <asp:TextBox ID="search_txt" runat="server"></asp:TextBox>
                        <asp:Button ID="btn_search" runat="server" Text=" 查 詢 " OnClick="btn_search_click" class="btn btn-success" /></h2>
          </div>
            <div class="box-content">

        
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
                                        <asp:LinkButton ID="EditButton" runat="server" Text="" OnClick="link_edit"  CommandArgument='<%# Eval("p_id")%>'
                                            class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                                          <asp:LinkButton ID="LinkButton1" runat="server" Text="" OnClick="link_edit" CommandName="copy" CommandArgument='<%# Eval("p_id")%>'
                                            class="btn btn-success">複製</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-danger" CommandArgument='<%# Eval("p_id").ToString()%>' OnClick="link_delete" OnClientClick="return confirm('你確定要刪除嗎?')" Text=""  ><i class="icon-trash icon-white"></i>刪除</asp:LinkButton>
                                    </td>
                                    <td><%# Eval("p_id") %></td>
                                    <td><img src='../upload/<%#  Eval("pic1")  %>?<%=DateTime.Now.ToString ("yyyyMMddhhmmss") %>' width ="100" /></td>
                                      <td><%# Eval("title") %></td>
                                    <td><%# Eval("productname")  %></td>                                
                                    <td><%# Eval("price") %></td>                             
                                    <td>
                                        <%# (Eval("status").ToString()  == "Y") ? "上架" : "下架"  %>
                                    </td>
                                    <td><%#Eval("viewcount") %></td>
                                    <td><%#Eval("sort") %></td>
                                    <td>
                                        <a href="/market?p_ID=<%#Eval("p_id") %>" target="_blank">預覽</a>
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
                                                        <th runat="server">圖片</th>
                                                         <th runat="server">分類</th>
                                                        <th runat="server"><asp:LinkButton ID="LinkButton3" runat="server" CommandArgument="desc" CommandName="productname" onclick ="sortdata">商品名稱</asp:LinkButton></th>                                                                                             
                                                        <th runat="server"><asp:LinkButton ID="LinkButton8" runat="server" CommandArgument="desc" CommandName="price" onclick ="sortdata">售價</asp:LinkButton></th>                                                                                                        
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
                                <td>商品序號</td>
                                <td><asp:Label ID="p_id" runat="server"></asp:Label></td>        
                                <td>商品代碼</td>                                                   
                                <td >
                                    <asp:TextBox ID="productcode" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>商品名稱</td>
                                <td><asp:TextBox ID="productname" runat="server" Width="350px"></asp:TextBox></td>                                                                          
                                <td>商品分類</td>
                                <td >
                                    <asp:DropDownList ID="categoryid" runat="server">
                                    </asp:DropDownList>                             
                                </td>                              
                            </tr>
                       
                     <tr>
                         <td>影片url</td>
                         <td colspan="3">
                             <asp:TextBox ID="videourl" runat="server" Width ="500"></asp:TextBox></td>
                         </tr>
                           
                        <tr>
                                <td>圖片1</td>
                                    <td colspan="3"> 
                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                    <asp:Image ID="Image1" runat="server" />W360*H360
                                    </td> 
                            </tr>
                               
                         
                            <tr>
                                <td >價格</td>
                            <td>
                                    <asp:TextBox ID="price" runat="server"></asp:TextBox>
                            
                               </td> 
                                <td >可售數量</td>
                            <td>
                                    <asp:TextBox ID="storage" runat="server"  TextMode="Number"></asp:TextBox>                               
                               </td> 
                            </tr>   
                  
                            <tr>
                                <td>運費</td>
                                <td>    
                                    <asp:TextBox ID="shippingfee" runat="server" TextMode="Number"></asp:TextBox>
                                    
                                    </td> 
                                <td>運送方式</td>
                                <td> <asp:DropDownList ID="shippingKind" runat="server">
                                    </asp:DropDownList>        
                                  </td> 
                            </tr>      
                            <tr>
                                <td>免運費金額</td>
                                <td> <asp:TextBox ID="freeship" runat="server" TextMode="Number"></asp:TextBox></td>
                                 <td>排序</td>
                                <td>
                                    <asp:TextBox ID="sort" runat="server"></asp:TextBox></td>
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
                                <td>商品文字簡述</td>
                                <td colspan="3">
                                    <asp:TextBox ID="memo" runat="server"  Width ="500"   TextMode="MultiLine"></asp:TextBox></td>
                            </tr>
                  
                            <tr>
                                  <td>狀態</td>
                                <td>
                                    <asp:DropDownList ID="status" runat="server">
                                        <asp:ListItem Value="Y">上架</asp:ListItem>
                                        <asp:ListItem Value="N">下架</asp:ListItem>
                                        <asp:ListItem Value="D">刪減</asp:ListItem>
                                    </asp:DropDownList></td>
                                   <td>流覽數</td>
                                <td>
                                    <asp:Label ID="viewcount" runat="server" Text=""></asp:Label></td>
                            </tr>
                            
                          
                        </table>

  <script>
    
            function checkinput() {
                var obj = "ContentPlaceHolder1_";
                var kindid = $("#<% =categoryid.ClientID %>").val();                                   
                                    
                if ($("#<% =price.ClientID %>").val() == '' ) {
                    alert('售價未輸入');
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
             
                     if ($("#<%=categoryid.ClientID  %>").val() == '') {
                    alert('請選擇產品類別');
                    return false;
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
    <asp:HiddenField ID="Selected_id" runat="server" />
</asp:Content>
