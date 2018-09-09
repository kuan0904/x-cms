<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="process-step2.aspx.cs" Inherits="process_step2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
$(document).ready(function() {
   
 

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
                    <div class="col-xs-12">
                        <hr>
                        <!--票券詳細資訊-->

                        <table class="table process-tab">
              
                            <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>
                                <tr>
                                    <td><%#Eval("Description") %></td>
                                    <td class="text-right">NT$<%#Eval("sellprice") %> x <%# Eval("num") %></td>
                                    <td class="text-right">NT$<%#(int)Eval("sellprice")*(int)Eval("num") %></td>
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
            <!-- row END -->
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
                                            <input class="form-control" id="cname">
                                            <label class="control-label">*錯誤訊息</label>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label title">* e-mail</label>
                                            <input class="form-control" id="cemail">
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label title" >* 聯絡電話</label>
                                            <input class="form-control" id="cphone">
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
                            <a href="/process-step3" class="btn btn-green ">下一步
                                    <i class="fa fa-angle-right" aria-hidden="true"></i>
                            </a>
                            <div class="divide40"></div>
                        </div>


                        <!-- col-md-4 col-sm-6 col-xs-6 END -->
                    </div>
                  
                </div>

            <div class="col-xs-12">
                                <hr>
                                <!--票券詳細資訊-->
                                
                                <table class="table process-tab">
                                    <tbody>
                                        <tr>
                                            <td width="20%" rowspan="2">票券</td>
                                            <td width="40%">早鳥票</td>
                                            <td width="20%">NT$500 x 2</td>
                                            <td width="20%" class="text-right">NT$1,000</td>
                                        </tr>
                                        <tr>
                                            <td>VIP套票</td>
                                            <td>NT$1,000 x 1</td>
                                            <td class="text-right">NT$2,000</td>
                                        </tr>
                                        <tr class="underline">
                                            <td>取票方式</td>
                                            <td colspan="3">
                                                <form class="form-fill form-horizontal">
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup1" id="optionsRadios1" value="1" class="chk">
                                                            <span class="cr">
                                                                <i class="cr-icon fa fa-circle"></i>
                                                            </span>
                                                            電子票券
                                                        </label>
                                                    </div>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup1" id="optionsRadios2" value="2" class="chk">
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
                                                                    <form class="form-ticket form-horizontal form-fill">
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
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup1" id="optionsRadios3" value="3" class="chk"> 
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
                                                                    <form class="form-ticket form-horizontal form-fill">
                                                                        <div class="form-group">
                                                                            <label class="control-label title">現場取票需出示訂單編號與身分證。</label>
                                                                        </div>
                                                                        <div class="form-group has-error">
                                                                            <label class="control-label title">身分證字號</label>
                                                                            <input class="form-control">
                                                                            <label class="control-label">*錯誤訊息</label>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </td>
                                        </tr>
                                        <tr class="underline">
                                            <td>付款方式</td>
                                            <td colspan="3">
                                                <form class="form-fill form-horizontal">
                                                    <!--此為禁用狀態範例-->
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup2" id="optionsRadios1" value="1">
                                                            <span class="cr">
                                                                    <i class="cr-icon fa fa-circle"></i>
                                                                </span>
                                                                ATM轉帳
                                                        </label>
                                                    </div>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup2" id="optionsRadios2" value="2">
                                                            <span class="cr">
                                                                    <i class="cr-icon fa fa-circle"></i>
                                                                </span>
                                                                銀行匯款
                                                        </label>
                                                    </div>
                                                    <div class="radio">
                                                        <label>
                                                            <input type="radio" name="RadioGroup2" id="optionsRadios3" value="3"> 
                                                            <span class="cr">
                                                                    <i class="cr-icon fa fa-circle"></i>
                                                                </span>
                                                                現場付款
                                                        </label>
                                                    </div>
                                                </form>
                                            </td>
                                        </tr>
                                        <tr class="underline">
                                            <td colspan="3">取票手續費</td>
                                            <td class="text-right">NT$60</td>
                                        </tr>
                                        <tr class="total underline">
                                            <td colspan="3">總計</td>
                                            <td class="text-right">NT$2,060</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="divide10"></div>
                                <div class="text-center">
                                        <a href="process-step2.html" class="btn btn-gray margin-R-5">重填資訊
                                            </a>
                                    <a href="process-step4.html" class="btn btn-green ">確認報名
                                            <i class="fa fa-angle-right" aria-hidden="true"></i>
                                        </a>
                                </div>
                                <div class="divide20"></div>

                            </div>
        </div>
        <!-- container END -->


    </div>
</asp:Content>

