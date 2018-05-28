<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="Edit_banner.aspx.cs" Inherits="spadmin_Edit_banner" %>

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
     <asp:SqlDataSource ID="viewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>" SelectCommand=""></asp:SqlDataSource>
    <asp:MultiView ID="MultiView1" runat="server">

        <asp:View ID="View1" runat="server">	        
      
                    <div class="box-header well" data-original-title>   <%=unitname %>
                          <asp:DropDownList ID="DropDownList1" runat="server"  DataTextField="title" DataValueField="classId" AutoPostBack="True" OnSelectedIndexChanged ="id_change">
                          </asp:DropDownList>     
                            <asp:LinkButton ID="Btn_add" runat="server" Text="" class="btn btn-large" OnClick ="Btn_add_Click" ><i class="icon-plus"></i>新增資料</asp:LinkButton>                                                                                                 
                       
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
                <td><%#Eval("url")%></td>
                <td><%#Eval("targetblank")%></td>
                <td><%#Eval("sort")%></td>
                <td><%# Eval("enabledate").ToString ()%></td>
                <td><%#  Eval("disabledate") %></td>
                <td><%#( Eval("status").ToString() == "Y") ? "啟用": "停用"%></td>                                        
                <td><%#Eval("title")%></td>
                                          
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
                                    
                                    <th runat="server">圖檔
                                    </th>
                                    <th runat="server">連結網址
                                    </th>
                                    <th runat="server">開新<br />視窗
                                    </th>
                                       <th runat="server">優先<br/>順序
                                    </th>
                                        <th runat="server"><asp:LinkButton ID="LinkButton3" runat="server" CommandArgument="desc" CommandName="enabledate" onclick ="sortdata">啟用時間</asp:LinkButton></th>
                                    <th runat="server"><asp:LinkButton ID="LinkButton4" runat="server" CommandArgument="desc" CommandName="disabledate" onclick ="sortdata">停用時間</asp:LinkButton></th>
                                 <th runat="server"><asp:LinkButton ID="LinkButton5" runat="server" CommandArgument="desc" CommandName="status" onclick ="sortdata">狀態</asp:LinkButton></th>
                                 <th runat="server">標題
                                    </th>
                                                                          
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
                        <h2><%=DropDownList1.SelectedItem.Text   %>管理</h2>
                    </div>
                    <div class="box-content">
                  
                            <table class="table table-striped table-bordered bootstrap-datatable datatable">
                                    <tr>
                                    <td>
                                        圖檔</td>
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
        
    </asp:MultiView>
    
                          
</asp:Content>
