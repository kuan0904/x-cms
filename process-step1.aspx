<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="process-step1.aspx.cs" Inherits="process_step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>

        var Articleid = '<%=Articleid%>';
        var lessonid = '<%=lessonid%>';
        var totalprice = 0;
        var totalnum = 0;
        var flag = "<%=status %>";
        re = /^[09]{2}[0-9]{8}$/;
        function cal() {
            totalprice = 0;
            $(".has-error").each(function () {
                var objSel = $(this);
                num = objSel.find($("select")).val();
                price = objSel.find("input[name='price']").val();
                totalprice += parseInt(price) * parseInt(num);
                $("#total1").html(totalprice);
                $("#total2").html('NT$'+ totalprice);
            });
            
              
        }

        $(document).ready(function () {
          
            $(document.body).on('change', 'select[name^="joinnum"]', function () {
               cal();
            });
           
            if (flag  != "") {
                $("a.btn.btn-green").hide();
                alert(flag);
                location.href = '/';
            }

            var price = '<%=lessondetail.Price   %>';
            $('select[name^="joinnum"]').find("option[value='1']").attr("selected", true);
            if (price == 0) {
                $('#payinfo').hide();

            } else {
                $('input[name="paymode"]').prop('checked', false);
                totalprice = price * 1;
            }
  
           
            $("#total1").html(totalprice);
            $("#total2").html('NT$'+ totalprice);
            $("a.btn.btn-green").click(function () {
                num =  $('select[name^="joinnum"]').val();
                var paymode = $('input[name="paymode"]:checked').val();
             
                cal();
                if (num == 0) {
                    alert('請選擇參加課程!');
                    $("#total1").scrollTop(300);
                }
                else {
                    var btn = "";
                  
                    $("#cemail").val($("#cemail").val().trim());
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
                    else if (typeof (paymode) == "undefined") {
                        alert('請選擇付款方式');
                       
                        return false;
                    }
                    else if (btn == "") {
                        btn = "Y";
                        var json = {
                            "Articleid": Articleid, "lessonid": lessonid, "TicketKind": "1",
                            "email": $("#cemail").val(), "phone": $("#cphone").val(),
                            "name": $("#cname").val(), "postion":$("#postion").val() ,
                            "unitname": $("#unitname").val() , "paymode": paymode, "joinnum": 1
                        };
                        $.post('/lib/joinclass.ashx', json, function (data) {
                            var result = JSON.parse(data);
                          
                                if (result.Id == '-1') {
                                    alert(result.Message);
                                }
                                else {
                                    if (totalprice == '0' || paymode =="3") {
                                         location.href = '/process-step4';
                                    } else {
                                        location.href = '/pay';
                                        
                                    }
                                 
                                }
                            });
                        
                    }
                }

            })

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
                                <h1>Step1.選擇票券&填寫資料</h1>
                            </div>
                            <!-- post-information END -->
                        </div>
                        <!-- post-header END -->
                    </article>
                    <div class="col-md-6 col-sm-12 col-xs-12">
                        <img src="<%=MainData.Pic  %>" alt="" title="<%=MainData.Subject %>">
                    </div>
                    <div class="col-md-6 col-sm-12 col-xs-12">
                        <div class="member-course-info">
                            <div class="member-order-detail-title">
                                <%=MainData.Subject %>
                            </div>
                            <div class="member-course-date">
                                <p>
                                    <i class="fa fa-calendar margin-R-5"></i><%= MainData.Lesson.StartDay.ToString("yyyy/MM/dd") %>
                                        至
                                        <%=MainData.Lesson.EndDay.ToString("yyyy/MM/dd")  %>
                                </p>
                                <p>
                                    <a href="https://www.google.com.tw/maps?q=<%=MainData.Lesson.Address  %>" class="link" target="_blank"><i class="fa fa-map-marker margin-R-5"></i><%=MainData.Lesson.Address  %></a>

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
                        <table class="table table-bordered process-tab">
                            <tbody>
                                <tr>
                                    <th width="70%">票種</th>
                                    <th width="15%">售價</th>
                                    <th width="15%">數量</th>
                                </tr>


                                <tr class="has-error">
                                    <td><%=lessondetail.Description %>
                                            （剩餘名額: <%Response.Write(num <= 0 ? "額滿" : num.ToString()); %>）
                                    </td>
                                    <td class="text-right">
                                        <label class="control-label">NT $<%=lessondetail.Price  %></label>
                                    </td>
                                    <td class="text-center">
                                        <!--清單最大值為剛票券數量上限-->
                                        <input type="hidden" value="<%=lessonid%>" name="lessonid" />
                                        <input type="hidden" value="<%=lessondetail.Price %>" name="price" />
                                        <select class="form-control" name="joinnum">
                                            <option value="0">0</option>
                                            <option value="<%Response.Write(num < 1 ? "0" : "1"); %>"><%Response.Write(num < 1 ? "額滿" : "1"); %></option>
                                        </select>

                                    </td>
                                </tr>


                                <tr>
                                    <td>合計</td>
                                    <td colspan="2" id="total1" class="text-right">
                                        <label class="control-label">0</label>
                                    </td>
                                </tr>
                            </tbody>
                        </table>



                        <section>
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
                                        <label class="control-label title">* 聯絡電話</label>
                                        <input class="form-control" id="cphone" name="cphone">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label title">* 公司名稱</label>
                                        <input class="form-control" id="unitname" name="unitname">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label title">職稱</label>
                                        <input class="form-control" id="postion" name="postion">
                                    </div>
                                </div>

                            </div>
                        </section>

                        <table class="table table-bordered process-tab" id="payinfo">
                            <tbody>
                                <tr class="underline" id="paytype">
                                    <td>付款方式</td>
                                    <td >
                                        <!--此為禁用狀態範例-->
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="paymode" id="optionsRadios1" value="1">
                                                <span class="cr">
                                                    <i class="cr-icon fa fa-circle"></i>
                                                </span>
                                                信用卡付款
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="paymode" id="optionsRadios2" value="2">
                                                <span class="cr">
                                                    <i class="cr-icon fa fa-circle"></i>
                                                </span>
                                                ATM轉帳
                                            </label>
                                        </div>
                                
                                        <div class="radio" style="display:none">
                                            <label>
                                                <input type="radio" name="paymode" id="optionsRadios3" value="5" checked>
                                                <span class="cr">
                                                    <i class="cr-icon fa fa-circle"></i>
                                                </span>
                                                現場付款
                                            </label>
                                        </div>
                                      
                                    </td>
                                </tr>
                                <tr class="total underline">
                                    <td >總計</td>
                                    <td class="text-right" id="total2">NT$0</td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="divide10"></div>
                        <div class="text-center">
                            <a href="#" class="btn btn-gray margin-R-5">重填資訊
                            </a>
                            <a href="#total" class="btn btn-green">確認報名
                                <i class="fa fa-angle-right" aria-hidden="true"></i>
                            </a>
                        </div>
                        <div class="divide20"></div>
                    </div>



                </div>




            </div>
        </div>

    </div>



</asp:Content>

