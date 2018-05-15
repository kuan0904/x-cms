<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="memberList.aspx.cs" Inherits="spadmin_memberList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script>
        $(document).ready(function(){ 
          $("#<%=birthday .ClientID %>").datepicker();
          $("#<%=birthday.ClientID %>").datepicker("option", "dateFormat", "yy/mm/dd");
      
      });
    </script>
</asp:Content>
 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
    <div class="box-header well" data-original-title>
                        <h2>會員管理      <asp:TextBox ID="keyword" runat="server" Width="300px"></asp:TextBox>
                   <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click1" class="btn btn-success" />
                            </h2> 
      </div>

        
           <div class="box-content">     
               <asp:SqlDataSource ID="citydatasource" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>" SelectCommand="SELECT * FROM [city]"></asp:SqlDataSource>
               <asp:SqlDataSource ID="countydatasource" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>" SelectCommand="SELECT * FROM [county]"></asp:SqlDataSource>
               <asp:MultiView ID="MultiView1" runat="server">  <asp:View ID="View1" runat="server">              
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="memberid"  OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging">
        <EmptyDataTemplate>
            <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>未傳回資料。</td>
                </tr>
            </table>
        </EmptyDataTemplate>        
        <ItemTemplate>
            <tr >
                <td><asp:LinkButton ID="EditButton" runat="server" Text="" OnClick="link_edit"   CommandName="Edit1" CommandArgument='<%# Eval("memberid")%>'
                       class="btn btn-info"><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                </td>
                <td>
                    <%# Eval("memberid") %>
                </td>
            
               <td>
                    <%# Eval("email") %>
                </td>
                <td>
                    <%# Eval("username") %>
                </td>
                         <td>
                    <%# Eval("gender") %>
                </td>
                    <td>
                    <%# Eval("phone") %>
                </td>
              
      
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server" >
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" class="table table-striped table-bordered bootstrap-datatable datatable">
                              <thead>
                            <tr runat="server" >
                                <th runat="server"></th>
                                <th runat="server"><asp:LinkButton ID="sort1" runat="server" CommandArgument="desc" CommandName="memberid" onclick ="sortdata">會員編號</asp:LinkButton></th>
                                  <th runat="server"><asp:LinkButton ID="LinkButton2" runat="server" CommandArgument="desc" CommandName="email" onclick ="sortdata">Email</asp:LinkButton></th>               
                                <th runat="server"><asp:LinkButton ID="LinkButton3" runat="server" CommandArgument="desc" CommandName="username" onclick ="sortdata">姓名</asp:LinkButton></th>                                                        
                                <th runat="server">性別</th>   
                                <th runat="server">電話</th>   
                         </tr>
                                  </thead> 
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" >
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
        
    </asp:ListView>

              <asp:HiddenField runat="server" ID="Selected_id"></asp:HiddenField>
</asp:View>
                   
                  
                   <asp:View ID="View2" runat="server">
                   <script >

                      //  $("input").prop('required', true);
                      
                      function checkinput(){
                         element.required = true;
                           if ($("#ContentPlaceHolder1_email").val() == '') {
                          //     alert('不可空白');
                           //    return false; 
                           }

                       }

                   </script>
                         
                            <table width="100%" border="0" class="table table-striped table-bordered bootstrap-datatable datatable">
                            <tr>
                               <td>ID</td>
                               <td> <%=memberid %></td>

                           </tr>
                             <tr>
                               <td>Email</td>
                               <td>
                                   <asp:TextBox ID="Email" runat="server"   ></asp:TextBox></td>

                           </tr>
                           <tr>
                               <td>密碼</td>
                               <td>
                                   <asp:Label ID="passwd" runat="server" Text=""></asp:Label></td>

                           </tr>
                           <tr>
                               <td>姓名</td>
                               <td>
                                   <asp:TextBox ID="username" runat="server"  ></asp:TextBox></td>
                           </tr>
                                           
                           <tr>
                               <td>行動電話</td>
                               <td>
                                <asp:TextBox ID="phone" runat="server"></asp:TextBox></td>
                           </tr>
                       
                           <tr>
                               <td>性別</td>
                               <td>
                                   <asp:RadioButtonList ID="gender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                     <asp:ListItem Value="男"></asp:ListItem>
                                       <asp:ListItem Value="女"></asp:ListItem>
                                   </asp:RadioButtonList>
                                  </td>

                           </tr>
                                <tr>
                                    <td>生日</td>
                                    <td>
                                        <asp:TextBox ID="birthday" runat="server"></asp:TextBox></td> 
                                    </tr> 
                     
                           <tr>
                               <td>地址</td>
                               <td>
                                   <asp:TextBox ID="zip" runat="server"></asp:TextBox>
                                   <asp:DropDownList ID="countyid" runat="server" OnSelectedIndexChanged="countyid_SelectedIndexChanged" AutoPostBack="True">
                                   </asp:DropDownList>
                                   <asp:DropDownList ID="cityid" runat="server" AutoPostBack="True" OnSelectedIndexChanged="cityid_SelectedIndexChanged">
                                   </asp:DropDownList>
                                   <asp:HiddenField ID="Hiddencity" runat="server" />
                                    <asp:HiddenField ID="Hiddencounty" runat="server" />
                                   <asp:TextBox ID="address" runat="server"></asp:TextBox>
                               </td>

                           </tr>
                         
                    
                           <tr>
                               <td>最後登入日期</td>
                               <td>
                                   <asp:Label ID="lastlogin" runat="server" Text="Label"></asp:Label></td>
                           </tr>
                           <tr>
                               <td>註冊日期</td>
                               <td>
                                   <asp:Label ID="registdate" runat="server" Text="Label"></asp:Label></td>
                           </tr>
                           <tr>
                               <td  colspan ="2" align="center"> 
                                      <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔"   OnClientClick="return checkinput();"  OnClick ="Btn_save_Click" />
                                    <asp:Button ID="Btn_cancel" runat="server" class="btn" Text="取 消" OnClick ="Btn_cancel_Click" />
                               </td>

                           </tr>
                       </table>

                        
    	<div class="history-title">消費記錄</div>
   
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                        <table >
                <tr>
        		<td>
                	訂購時間：<%#DateTime.Parse ( Eval("crtdat").ToString ()).ToString ("yyy-MM-dd hh:mm")  %>
                    <span>訂單編號：<%#Eval("ord_code") %></span>
				</td>
                </tr>
            	<tr><td>
                        	訂購商品： <%#unity.classlib .get_pd  (Eval ("ord_id").ToString ()) %>
            		付款方式：<%# unity.classlib .getPaymode (Eval("paymode").ToString ()) %><br>
            		取貨方式，宅配到府<br>
            		應付金額：<%#Eval("totalprice") %>元<br>
            		發　　票：<%# unity.classlib .getInvoice  (Eval("Invoice").ToString ()) %><br>
            		處理進度：<%# unity.classlib .getPaymode (Eval("paymode").ToString ()) %><br>
                    </td> 
				</tr>
		     </table>
                    <hr />
                </ItemTemplate>
            </asp:Repeater>
        	
   
            
        
        

                   </asp:View>

               </asp:MultiView>

               </div> 
                
</asp:Content>

