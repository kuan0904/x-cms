<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="process-step2.aspx.cs" Inherits="process_step2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
    $(document).ready(function() {
    re = /^[09]{2}[0-9]{8}$/;   
    $("a.btn.btn-green").click(function () {
        $('#POC').children().eq(2).removeClass("has-error");
        $('#POC').children().eq(1).removeClass("has-error");
        $('#POC').children().eq(0).removeClass("has-error");
        if ($("#cname").val() == "") {
            alert('請輸入聯絡人姓名!');
            $('#POC').children().eq(0).addClass('has-error');
            return false;
        }
    
        else if ($("#cemail").val() == "") {
            alert('請輸入聯絡人email!');          
            $('#POC').children().eq(1).addClass('has-error');
         }
         else if (validEmail($("#cemail").val()) == false) {
            $('#POC').children().eq(1).addClass('has-error');
            alert('聯絡人email錯誤!');
            return false;
        }
         else if ($("#cphone").val() == "") {
            alert('請輸入聯絡人聯絡電話!');           
            $('#POC').children().eq(2).addClass('has-error');
         }
         else if (!re.test($("#cphone").val())) {
            $('#POC').children().eq(2).addClass('has-error');
            alert('聯絡人手機格式錯誤!');
            return false;
        }
        else if ($("#unitname").val() == "") {
            alert('請輸入公司名稱!');           
          return false;
         }
        else {
          
             var flag = true;
             //for (index = 0; index < $('input[name="cr"]').length; index++){                   
             //   var t1 = $('input[name="name"]:eq('+ index + ')');
             //   var t2 = $('input[name="email"]:eq('+ index + ')');
             //   var t3 = $('input[name="phone"]:eq(' + index + ')');
             //   var i = index + 1;
             //   if (t1.val() == "") {
             //        alert('請輸入第' + i + '位姓名!');
             //        flag = false;
                     
             //        break;
             //    }
             //    else if (t2.val() == "") {
             //        alert('請輸入' + i + '位email!');
             //        flag = false;
             //        break;
             //    }
             //    else if (t3.val() == "") {
             //        alert('請輸入' + i + '位聯絡電話!');
             //        flag = false;
             //        break;
             //    }
             //    else if (validEmail(t2.val()) == false) {
             //        alert('第' + (index + 1) + '位Email有錯!');
             //        return false;
             //    }
             //    else if (!re.test(t3.val())) {
             //        alert('第' + (index + 1) + '位手機格式錯誤!');
             //        return false;
             //    }
                          
             //}
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
                                    <i class="fa fa-calendar margin-R-5"></i><%= startday %>至<%=endday  %>
                                </p>
                                <p>
                                    <a href="https://www.google.com.tw/maps?q=<%=address %>" class="link" target="_blank"><i class="fa fa-map-marker margin-R-5"></i><%=address %></a>

                                </p>
                            </div>
                            <div class="notice">
                                <h4>注意事項</h4>
                              
                              
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
                                <div class="col-xs-12" id="POC">
                                  
                                        <div class="form-group">
                                            <label class="control-label title">* 姓名</label>
                                            <input class="form-control" id="cname" name="cname">
                                            <label class="control-label"></label>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label title">* e-mail</label>
                                            <input class="form-control" id="cemail" name="cemail">
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label title" >* 聯絡電話</label>
                                            <input class="form-control" id="cphone" name="cphone">
                                        </div>
                                            <div class="form-group">
                                            <label class="control-label title" >* 公司名稱</label>
                                            <input class="form-control" id="unitname" name="unitname">
                                        </div>
                                          <div class="form-group">
                                            <label class="control-label title" >職稱</label>
                                            <input class="form-control" id="postion" name="postion">
                                        </div>
                                </div>

                            </div>
                        </section>
                        <!--
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
                                            <div class="form-group">
                                                <label class="control-label title">* 姓名</label>
                                                <input class="form-control" name="name">
                                                <label class="control-label"></label>
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
        -->
                        <div class="text-center">
                            <!--a連結class新增disabled即可禁用，按鈕方式則為disabled="disabled"-->
                                        <a href="#join" class="btn btn-green">確認報名
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
       <input type="hidden" name="paymode"  value="3"  > 
         <input type="hidden" name="kind"    value="1" class="chk">
    </div>
</asp:Content>

