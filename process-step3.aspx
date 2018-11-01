<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="process-step3.aspx.cs" Inherits="process_step3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
            <script>
$(document).ready(function() {
   
    $("a.btn.btn-green").click(function () {
       
         var dataValue = { "kind": "list" };
   
          
        $("#form1").attr("action", "/process-step4");
        $("#form1").submit();
           
      
                  
                
    })

   
});
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
                <div class="row">
                    <div class="col-xs-12">
                        <article class="post-layout post">
                            <div class="post-header">
                                <div class="post-information">
                                    <h1>Step3.選擇付款方式</h1>
                                </div>
                                <!-- post-information END -->
                            </div>
                            <!-- post-header END -->
                        </article>
                        <div class="row">
                            <div class="col-md-6 col-sm-12 col-xs-12">
                                <img src="<%=pic  %>" alt="" title="<%=subject %>">
                            </div>
                            <div class="col-md-6 col-sm-12 col-xs-12">
                                <div class="member-course-info">
                                    <div class="member-order-detail-title">
                                        <%=subject %>
                                    </div>
                                    <div class="member-course-date">
                                        <p>
                                            <i class="fa fa-calendar margin-R-5"></i><%= startday %><%=endday  %>
                                        </p>
                                        <p>
                                                <a href="https://www.google.com.tw/maps?q=<%=address %>" class="link" target="_blank"><i class="fa fa-map-marker margin-R-5"></i><%=address %></a>

                                        </p>
                                    </div>
                                    <div class="notice">
                                        <h4>注意事項</h4>
                                        退票須知：委託藝時代退款<br/>
                                        票券有效日期開始8天前可申請退票，酌收10%手續費，請詳閱
                                        <a href="cp.html" target="_blank">退款操作說明</a>
                                    </div>
                                    <!-- meta-info END -->
                                </div>
                            </div>
                            <div class="col-xs-12">
                                <hr>
                                <!--票券詳細資訊-->
                                
                                <table class="table process-tab">
                                    <tbody>
                                  
              
                            <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>
                                <tr>
                                    <%# Container.ItemIndex  ==0  ?     "<td  rowspan=\""+ num  +"\">票券</td>" :""%>
                                    <td><%#Eval("Description") %></td>
                                    <td class="text-right">NT$<%#Eval("sellprice") %> x <%# Eval("Limitnum") %></td>
                                    <td class="text-right">NT$<%#(int)Eval("sellprice")*(int)Eval("Limitnum") %></td>
                                </tr>
                                </ItemTemplate>
                            </asp:Repeater>`
                                    <tr class="underline">
                                        <td>取票方式</td>
                                        <td colspan="3">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="kind"  value="1" class="chk">
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-circle"></i>
                                                        </span>
                                                        電子票券
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="kind"  value="2" class="chk">
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-circle"></i>
                                                        </span>
                                                        郵寄取票
                                                    </label>
                                                </div>
                                                <!--點選郵寄取票，才會顯示-->
                                                <div class="panel panel-default" id="form2" style="display: none;">
                                                    <div class="panel-body">
                                                        <div class="row">
                                                            <div class="col-xs-12">
                                                                    <div class="form-group">
                                                                        <label class="control-label title">郵寄用費為NT$XX，僅限台灣地址,約5~7個工作天寄出。</label>
                                                                    </div>
                                                                    <div class="form-group has-error">
                                                                        <label class="control-label title">姓名</label>
                                                                        <input class="form-control">
                                                                        <label class="control-label">*錯誤訊息</label>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="control-label title">手機</label>
                                                                        <input class="form-control">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="control-label title">地址</label>
                                                                        <input class="form-control">
                                                                    </div>
                                                                   
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="kind"  value="3" class="chk"> 
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-circle"></i>
                                                        </span>
                                                        現場取票
                                                    </label>
                                                </div>

                                                <!--點選現場取票，才會顯示-->
                                                <div class="panel panel-default" id="form3" style="display: none;">
                                                    <div class="panel-body">
                                                        <div class="row">
                                                            <div class="col-xs-12">
                                                                    <div class="form-group">
                                                                        <label class="control-label title">現場取票需出示訂單編號與身分證。</label>
                                                                    </div>
                                                                    <div class="form-group has-error">
                                                                        <label class="control-label title">身分證字號</label>
                                                                        <input class="form-control">
                                                                        <label class="control-label">*錯誤訊息</label>
                                                                    </div>
                                                             
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                             
                                        </td>
                                    </tr>
                                    <tr class="underline">
                                        <td>付款方式</td>
                                        <td colspan="3">
                                           
                                                <!--此為禁用狀態範例-->
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="paymode" id="optionsRadios1" value="1">
                                                        <span class="cr">
                                                                <i class="cr-icon fa fa-circle"></i>
                                                            </span>
                                                            ATM轉帳
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="paymode" id="optionsRadios2" value="2">
                                                        <span class="cr">
                                                                <i class="cr-icon fa fa-circle"></i>
                                                            </span>
                                                            銀行匯款
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="paymode" id="optionsRadios3" value="3"> 
                                                        <span class="cr">
                                                                <i class="cr-icon fa fa-circle"></i>
                                                            </span>
                                                            現場付款
                                                    </label>
                                                </div>
                                              
                                        </td>
                                    </tr>
                                    <tr class="underline">
                                        <td colspan="3">取票手續費</td>
                                        <td class="text-right">NT$60</td>
                                    </tr>
                                    <tr class="total underline">
                                        <td colspan="3">總計</td>
                                        <td class="text-right">NT$NT$<%=totalprice  %></td>
                                    </tr>
                                </tbody>
                            </table>
                                <div class="divide10"></div>
                                <div class="text-center">
                                        <a href="process-step2.html" class="btn btn-gray margin-R-5">重填資訊
                                            </a>
                                    <a href="#" class="btn btn-green">確認報名
                                            <i class="fa fa-angle-right" aria-hidden="true"></i>
                                        </a>
                                </div>
                                <div class="divide20"></div>

                            </div>
                        </div>

                        <!-- col-md-4 col-sm-6 col-xs-6 END -->
                    </div>
                    <!-- col-md-4 END -->


                </div>
                <!-- row END -->

            </div>
    <input type="hidden" name ="Articleid" value ="<%=Articleid %>" />
        <input type="hidden" name="joinnum" value ="<%=Request ["joinnum"] %>" />
        <input type="hidden" name="lessonid" value ="<%=Request ["lessonid"] %>" />
        <input type="hidden" name="sellprice" value ="<%=Request ["sellprice"] %>" />
        <input type="hidden" name="name" value ="<%=Request ["name"] %>" />
        <input type="hidden" name="email" value ="<%=Request ["email"] %>" />
        <input type="hidden" name="phone" value ="<%=Request ["phone"] %>" />
        <input type="hidden" name="cname" value ="<%=Request ["cname"] %>" />
        <input type="hidden" name="cemail" value ="<%=Request ["cemail"] %>" />
        <input type="hidden" name="cphone" value ="<%=Request ["cphone"] %>" />
</asp:Content>

