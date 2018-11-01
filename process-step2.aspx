<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="process-step2.aspx.cs" Inherits="process_step2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
$(document).ready(function() {
   
    $("a.btn.btn-green").click(function () {
       
         if ($("#cname").val() == "") {
             alert('請輸入聯絡人姓名!');

         }
         else if ($("#cemail").val() == "") {
             alert('請輸入聯絡人email!');
         }
         else if ($("#cphone").val() == "") {
             alert('請輸入聯絡人聯絡電話!');
         }
         else {
             var flag = true;
             for (index = 0; index < $('input[name="cr"]').length; index++){    
               
                    var t1 = $('input[name="name"]:eq('+ index + ')');
                    var t2 = $('input[name="email"]:eq('+ index + ')');
                    var t3 = $('input[name="phone"]:eq(' + index + ')');
                    var i = index + 1;
                    if (t1.val() == "") {
                        alert('請輸入第' + i + '姓名!');
                        flag = false;
                        break;
                     }
                     else if (t2.val() == "") {
                        alert('請輸入' + i + 'email!');
                        flag = false;
                        break;
                     }
                     else if (t3.val() == "") {
                        alert('請輸入' + i + '聯絡電話!');
                        flag = false;
                        break;
                     }
             }
             if (flag) {
                 $("#form1").attr("action", "/process-step3");
                 $("#form1").submit();
             }
         }         
              
                  
                
             })

    $('input[name="cr"]').change(function () {
        var index = $('input[name="cr"]').index( this );
        var t1 = $('input[name="name"]:eq('+ index + ')');
        var t2 = $('input[name="email"]:eq('+ index + ')');
        var t3 = $('input[name="phone"]:eq(' + index + ')');

        if(this.checked) {
            var cname = $("#cname").val();
            var cphone = $("#cphone").val();
            var cemail = $("#cemail").val();
          
            t1.val(cname);
            t2.val(cemail);
            t3.val(cphone);
          //  $(this).prop("checked", returnVal);
        }
          
    });
});
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main-content">


        <div class="breadArea">
            <div class="container">
                <ol class="breadcrumb">
                    <li>
                        <a href="/">HOME</a>
                    </li>
                    <%=pageunit %>
                </ol>
            </div>
        </div>
        <!-- breadArea END -->

        <div class="container">
            <div class="row">
                <div class="col-xs-12">
                    <article class="post-layout post">
                        <div class="post-header">
                            <div class="post-information">
                                <h1>Step2.填寫資料</h1>
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
              
                            <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>
                                <tr>
                                    <td><%#Eval("Description") %></td>
                                    <td class="text-right">NT$<%#Eval("sellprice") %> x <%# Eval("Limitnum") %></td>
                                    <td class="text-right">NT$<%#(int)Eval("sellprice")*(int)Eval("Limitnum") %></td>
                                </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                         

                            <tr class="total">
                                <td colspan="2">總計</td>
                                <td class="text-right">NT$<%=totalprice  %></td>
                            </tr>
                        </table>
                        <div class="divide10"></div>
                        <div class="text-center">
                            <a href="#" onclick ="history.back();" class="btn btn-gray ">重選票券
                            </a>
                        </div>

                    </div>
                </div>
            </div>
            <!-- row END --><a id="join"></a>
            <div class="row">
                    <div class="col-md-10 col-md-offset-1 col-sm-9 col-xs-12">
                        <div class="divide20"></div>
                        <section class="form-white-style">
                            <div class="page-header-blue">
                                <h3>聯絡人資訊</h3>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                  
                                        <div class="form-group has-error">
                                            <label class="control-label title">* 姓名</label>
                                            <input class="form-control" id="cname" name="cname">
                                            <label class="control-label">*錯誤訊息</label>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label title">* e-mail</label>
                                            <input class="form-control" id="cemail" name="cemail">
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label title" >* 聯絡電話</label>
                                            <input class="form-control" id="cphone" name="cphone">
                                        </div>
                             
                                </div>

                            </div>
                        </section>
                        <section class="form-white-style">
                            <div class="page-header-blue">
                                <h3>報名人資訊</h3>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <asp:Repeater ID="Repeater2" runat="server">
                                        <ItemTemplate>
                                            <div class ="Signup">
                                         <div class="form-group">
                                            <!-- Default checkbox -->
                                            <div class="checkbox">
                                                <label class="control-label title">
                                                    <input type="checkbox" name="cr" value="">
                                                    <span class="cr">
                                                        <i class="cr-icon glyphicon glyphicon-ok"></i>
                                                    </span>
                                                    報名人同聯絡人資訊
                                                </label>
                                            </div>
                                        </div>
                                        <div class="form-group has-error">
                                            <label class="control-label title">* 姓名</label>
                                            <input class="form-control" name="name">
                                            <label class="control-label">*錯誤訊息</label>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label title">* e-mail</label>
                                            <input class="form-control" name="email">
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label title">* 聯絡電話</label>
                                            <input class="form-control" name="phone">
                                        </div>

                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                            
                                
                                </div>

                            </div>
                        </section>
                        <div class="text-center">
                            <!--a連結class新增disabled即可禁用，按鈕方式則為disabled="disabled"-->
                            <a href="#join" class="btn btn-green ">下一步
                                    <i class="fa fa-angle-right" aria-hidden="true"></i>
                            </a>
                            <div class="divide40"></div>
                        </div>


                        <!-- col-md-4 col-sm-6 col-xs-6 END -->
                    </div>
                  
                </div>

            
        </div>
            </div>
        <!-- container END -->

        <input type="hidden" name="joinnum" value ="<%=Request ["joinnum"] %>" />
        <input type="hidden" name="lessonid" value ="<%=Request ["lessonid"] %>" />
        <input type="hidden" name="sellprice" value ="<%=Request ["sellprice"] %>" />
      
    </div>
</asp:Content>

