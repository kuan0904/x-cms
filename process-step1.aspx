<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="process-step1.aspx.cs" Inherits="process_step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
        var islogin = "";
        var totalnum = 0;
        var totalprice = 0; 
        function cal() {
            totalprice = 0;
            $(".has-error").each(function () {
                var objSel = $(this);                    
                    
                num =objSel.find($("select")).val();
                price = objSel.find("input[name='sellprice']").val();
                totalprice +=  parseInt(price) *  parseInt(num);
                totalnum += parseInt( num);            
                $("#total").html(totalprice);
            });
        }

        $(document).ready(function () {    
        
            $(document.body).on('change', 'select[name^="joinnum"]', function () {
                cal();     
            });
             $("a.btn.btn-green").click(function () {
                 cal();              
         
             
                 if (totalnum == 0) {
                     alert('請至少選擇一個課程!');
                     $("#total").scrollTop(300);

                 } else {
                    $("#form1").attr("action", "/process-step2");
                    $("#form1" ).submit();
                 }
             })
          


        });
          
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
                                    <h1>Step1.選擇票券</h1>
                                </div>
                                <!-- post-information END -->
                            </div>
                            <!-- post-header END -->
                        </article>
                        <div class="row">
                            <div class="col-md-6 col-sm-12 col-xs-12">
                                <img src="<%=pic %>"  alt="" title="<%=subject  %>">
                                    <%=contents %> 
                            </div>
                            <div class="col-md-6 col-sm-12 col-xs-12">
                                
                                <div class="member-course-info">
                                      <ul class="category">
                                            <li class="entry-category"><%=tags%></li>
                                        </ul>
                                    <div class="member-order-detail-title">
                                       <%=subject  %>
                                    </div>
                                    <div class="member-course-date">
                                        <p>
                                            <i class="fa fa-calendar margin-R-5"></i>   <%=startday  %>至<%=endday  %> <%=lessontime  %>
                                        </p>
                                        <p>
                                            <a href="https://www.google.com.tw/maps?q=<%=address %>" target="_blank"><i class="fa fa-map-marker margin-R-5"></i><%=address %></a>
                                        </p>
                                    </div>
                                     <asp:Repeater ID="Repeater1" runat="server" EnableViewState="False">
                                <ItemTemplate>
                                <div class="block-wrap border">
                                    <div class="block-header">
                                        <div class="media">
                                            <img src="/webimages/people/<%#Eval("pic") %>" alt="" title="<%#Eval("Subject") %>">
                                        </div>
                                        <div class="desc">
                                            <a data-toggle="collapse" href="#desc-01">
                                                <span class="label">講師</span><span class="name"><%#Eval("Subject") %></span>
                                                <span class="note"><%#Eval("title") %></span>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="block-body box collapse in" id="desc-01">
                                      <div class="well">
                                       <%#Eval("contents") %>     </div>
                                    </div>
                                </div><!-- block-wrap END -->

                                </ItemTemplate>
                            </asp:Repeater>
                                    <div class="notice">
                                        <h4>注意事項</h4>
                                        退票須知：委託藝時代退款<br/>
                                        票券有效日期開始8天前可申請退票，酌收10%手續費，請詳閱
                                        <a href="cp.html" target="_blank">退款操作說明</a>
                                    </div>
                                 
                                    <!-- meta-info END -->
                                </div>
                                <div class="post-sharing">
                                        <div class="sharing-group">
                                              <a class="btn-share facebook" href="#" >
                                                    <div class="icon-elements facebook"></div>
                                                    <div class="social-text">Facebook</div>
                                                </a>

                                                 <a class="btn-share twitter" href="#"><div class="icon-elements twitter"></div><div class="social-text">Twitter</div></a>

                                                <a class="btn-share google" href="#" ><div class="icon-elements googleplus"></div></a>

                                                <a class="btn-share pinterest" href="#" ><div class="icon-elements pinterest"></div></a>

                                                <a class="btn-share whatsapp" href="#"><div class="icon-elements whatsapp"></div></a>

                                            <div class="clearfix"></div>
                                        </div><!-- sharing-group END -->
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
                                <asp:Repeater ID="Repeater2" runat="server">
                                <ItemTemplate>
                                        <tr class="has-error">
                                            <td><%#Eval("description") %>
                                               （剩餘名額:<%#Eval("limitnum") %>）
                                            </td>
                                            <td class="text-right"> <label class="control-label">NT $<%#Eval("sellprice") %></label> </td>
                                            <td class="text-center">
                                                <!--清單最大值為剛票券數量上限-->
                                                <input type="hidden" value ="<%#Eval("lessonid") %>" name="lessonid" />
                                                 <input type="hidden" value ="<%#Eval("limitnum") %>" name="limitnum" />
                                               <input type="hidden" value ="<%#Eval("sellprice") %>" name="sellprice" />
                                                <select class="form-control" name="joinnum" >
                                                    <%for (int i = 0; i < 10; i++)   { %>
                                                    <option value="<%=i %>"  ><%=i %></option>
                                                  <%} %>
                                                </select>

                                            </td>
                                        </tr>
                                  
                                </ItemTemplate>
                            </asp:Repeater>
                                        <tr>
                                            <td>合計</td>
                                            <td colspan ="2" id="total" class="text-right"><label class="control-label">0</label> </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="divide20"></div>
                                <div class="text-center">
                                    <!--a連結class新增disabled即可禁用，按鈕方式則為disabled="disabled"-->
                                    <a href="#total" class="btn btn-green">下一步
                                        <i class="fa fa-angle-right" aria-hidden="true"></i>
                                    </a>

                                    
                                </div>
                            </div>
                        </div>

                        <!-- col-md-4 col-sm-6 col-xs-6 END -->
                    </div>
                    <!-- col-md-4 END -->


                </div>
                <!-- row END -->

            </div>
            <!-- container END -->

        </div>
</asp:Content>

