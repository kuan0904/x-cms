<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="member-class-detail.aspx.cs" Inherits="member_class_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="main-content">

        <div class="breadArea">
            <div class="container">
                <ol class="breadcrumb">
                    <li>
                        <a href="/">HOME</a>
                    </li>
                    <li class="active">會員中心</li>
                    <li class="active">我的課程</li>
                </ol>
            </div>
        </div>
        <!-- breadArea END -->

        <div class="container">
            <div class="row">
                <div class="col-md-2 col-sm-3 col-xs-12 hidden-sm hidden-xs">
                    <div class="member-subnav">
                        <div class="subnav-title">我的藝時代</div>
                        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingOne">
                                    <h4 class="panel-title">
                                        <a href="member-order.html" class="active">查詢訂單</a>
                                    </h4>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                        <a href="member-collection.html">我的收藏</a>
                                    </h4>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingFour">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false"
                                            aria-controls="collapseFour">會員設定
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                                    <ul class="list-group">
                                        <a href="/member-edit" class="list-group-item">修改個人資料</a>
                                        <a href="/member-password" class="list-group-item">變更密碼</a>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-10 col-sm-9 col-xs-12">
          
                    <%=htmlstr  %>

                 
                </div>
              
            </div>
    
    </div>
          
  
    </div>

        

</asp:Content>

