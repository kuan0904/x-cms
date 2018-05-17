<%@ Page Title="登入" Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Account_Login" Async="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title><%=Session["companyName"].ToString () %></title>  
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" /> 
    <link rel="stylesheet" href="assets/css/ace.min.css" />
    <script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#imgverifycode").click(function () {
                $("#imgverifycode").attr("src", "/lib/Captcha.ashx" + "?=_" + new Date().getTime().toString());
            });
        });

    </script>
</head>

<body class="login-layout">
    <form id="form1" runat="server">
        <div class="main-container">
            <div class="main-content">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <div class="login-container">
                            <div class="center">
                                <h1>
                                    <span class="white"><%=Session["companyName"].ToString () %></span>
                                </h1>
                                <h4 class="blue"><%=Session["systemName"].ToString () %></h4>
                            </div>

                            <div class="space-6"></div>

                            <div class="position-relative">
                                <div id="login-box" class="login-box visible widget-box no-border">
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <h4 class="header blue lighter bigger">
                                                <i class="icon-coffee green"></i>
                                                Please Enter Your Information
                                            </h4>

                                            <div class="space-6"></div>


                                            <fieldset>
                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <asp:TextBox ID="UserName" runat="server" class="form-control" placeholder="Username" required></asp:TextBox>
                                                        <i class="icon-key"></i>
                                                    </span>
                                                </label>

                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" placeholder="Password" class="form-control" required></asp:TextBox>
                                                        <i class="icon-lock"></i>
                                                    </span>
                                                </label>
                                                <label class="block clearfix">

                                                    <img id="imgverifycode" style="vertical-align: bottom; cursor: pointer;" src="/lib/Captcha.ashx" alt="驗證碼" title="">
                                                    <asp:TextBox ID="VERIFYCODE" runat="server" placeholder="輸入驗証碼"></asp:TextBox>


                                                </label>
                                                <div class="space"></div>



                                            </fieldset>



                                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>

                                            <asp:Button ID="LoginButton" runat="server" CommandName="Login"
                                                class="width-35 pull-right btn btn-sm btn-primary"
                                                Text="登入" ValidationGroup="Login1" Width="100%" OnClick="LogIn" />

                                        </div>
                                        <!-- /widget-main -->


                                    </div>
                                    <!-- /widget-body -->
                                </div>
                                <!-- /login-box -->

                            </div>
                            <!-- /position-relative -->
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
        </div>





    </form>

</body>

</html>
