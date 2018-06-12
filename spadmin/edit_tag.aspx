<%@ Page Title="" Language="C#"   AutoEventWireup="true" CodeFile="edit_tag.aspx.cs" Inherits="spadmin_edit_tag" %>

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
        <style>

 .pagenavi a, .pagenavi span
{
  min-width:50px;
  min-height:20px;
  line-height:100%;
  text-decoration:none;
  text-align:center;
  margin:0 3px;
  padding:4px 0 0;
  vertical-align:middle;
  display:inline-block;
  zoom:1;*display:inline;
  -webkit-border-radius:10em;
  -moz-border-radius:10em;
  border-radius:10em
}
.pagenavi a
{
  background:#666;
  color:#fff;
  text-decoration:none
}
.pagenavi a:hover
{
  background-color:#333;
  text-decoration:none;
}
.pagenavi .current
{
  color:#666;
  text-decoration:none
}
.post-nav
{
  margin:0 0 30px;
  padding:15px 0;
  clear:both;
  font-size:14px;
}
.pagenavi
{
  padding:0;
  text-align:right;
  margin:0;
  float:right;
  width:100%;
}
 

    </style>

    </head>
<body>
     <form id="form1" runat="server">
         		

					<div class="page-content">
					

						<div class="row">
                            <div class="col-xs-12">
                                <!-- PAGE CONTENT BEGINS -->
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <div class="box-header well" data-original-title>
                 <h2><%=unitname %></h2>
                   <asp:LinkButton ID="Btn_add" runat="server" Text="" class="btn btn-large" OnClick="Btn_add_Click"><i class="icon-plus"></i>新增資料</asp:LinkButton>
              
            </div>
            <div class="box-content">
                <asp:ListView ID="ListView1" runat="server" DataKeyNames="tagid" OnPagePropertiesChanging="ContactsListView_PagePropertiesChanging">
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
                                                <th runat="server">代號</th>                                       
                                                <th runat="server">名稱</th>                                             
                                                <th runat="server">狀態</th>
                                                <th runat="server">刪除</th>
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
                    <ItemTemplate>
                        <tr>
                            <td style="text-align: center">
                                <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-info" CommandArgument='<%# Eval("tagid")%>' OnClick="link_edit" Text=""><i class="icon-edit icon-white"></i>編輯</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-danger" CommandArgument='<%# Eval("tagid").ToString()%>' OnClick="link_delete" OnClientClick="return confirm('你確定要刪除嗎?')" Text="" Visible="False"><i class="icon-trash icon-white"></i>刪除</asp:LinkButton>
                            </td>
                            <td><%#Eval("tagid")%></td>
                            <td><%#Eval("tagname")%></td>                          
                          
                             <td><%#( Eval("status").ToString() == "Y") ? "啟用": "停用"%></td>          
                              <td style="text-align: center"><asp:Button ID="Button1" runat="server" Text="刪除"
                                   OnClick ="Button1_Click"    CommandName="delete" CommandArgument='<%# Eval("tagid")%>'  
                                   OnClientClick="return  confirm('你確定嗎?')"  Visible= <%# Eval("status").ToString()=="0" ? true:false  %> /></td>
                        </tr>
                    </ItemTemplate>
                    
                </asp:ListView>
            </div>



        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:HiddenField ID="Selected_id" runat="server" />         
                    <div class="box-header well" data-original-title>
                        <h2><%=unitname %>設定</h2>
                    </div>  
                    <div class="box-content"> <asp:HiddenField ID="classid" runat="server" />                       
                            <table  class="table table-striped table-bordered bootstrap-datatable datatable">  
                                <tr>
                                    <td>
                                        名稱</td>
                                    <td>
                                        <asp:TextBox ID="tagname" runat="server"  required></asp:TextBox>
                                    </td>
                                </tr>        
                               <tr>
                                   <td>圖片</td>
                                   <td>
                                       <asp:HiddenField ID="HiddenField1" runat="server" />
                                       <asp:FileUpload ID="FileUpload1" runat="server" /><asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                   </td>
                               </tr>
                                <tr>
                                    <td>說明</td>
                                    <td>
                                        <asp:TextBox ID="contents" runat="server" TextMode="MultiLine" Width="200"></asp:TextBox></td> 
                                </tr>
                                <tr>
                                    <td>
                                        狀態</td>
                                    <td>
                                        <asp:DropDownList ID="status" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Y">開啟</asp:ListItem>
                                            <asp:ListItem Value="N">關閉</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan ="2">
                                    <asp:Button ID="Btn_save" runat="server" class="btn btn-primary" Text="存 檔" OnClick="Btn_save_Click" />
                                    <button onclick ="history.back();"  class="btn">取消</button>
                                   <asp:Button ID="Btn_cancel" runat="server" class="btn btn-primary" Text="取 消" OnClick="Btn_cancel_Click" />
                                  </td>
                                </tr>
                            </table>
                       
                    </div>
               
        </asp:View>

    </asp:MultiView>
                       
                                <!-- PAGE CONTENT ENDS -->
                            </div><!-- /.col -->
						</div><!-- /.row -->
					</div><!-- /.page-content -->
			
			
    </form>
</body>
</html>
