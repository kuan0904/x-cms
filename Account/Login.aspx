<%@ Page Title="登入" Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Account_Login" Async="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title><%=Session["companyName"].ToString () %></title>
    <!-- basic styles -->
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="/assets/css/font-awesome.min.css" />

    <!--[if IE 7]>
		  <link rel="stylesheet" href="/assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

    <!-- page specific plugin styles -->

    <!-- fonts -->

    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />

    <!-- ace styles -->

    <link rel="stylesheet" href="/assets/css/ace.min.css" />
    <link rel="stylesheet" href="/assets/css/ace-rtl.min.css" />

    <!--[if lte IE 8]>
		  <link rel="stylesheet" href="/assets/css/ace-ie.min.css" />
		<![endif]-->

    <!-- inline styles related to this page -->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <!--[if lt IE 9]>
		<script src="/assets/js/html5shiv.js"></script>
		<script src="/assets/js/respond.min.js"></script>
		<![endif]-->
     <script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
    <script >
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
                                                           
                                                              <img id="imgverifycode" style="vertical-align: bottom; cursor: pointer;" src="/lib/Captcha.ashx" alt="驗證碼" title=""> <asp:TextBox ID="VERIFYCODE" runat="server" placeholder="輸入驗証碼"></asp:TextBox>   
                                                               
                                                         
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
            <!-- /.main-container -->

            <!-- basic scripts -->

            <!--[if !IE]> -->

            <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

            <!-- <![endif]-->

            <!--[if IE]>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->

            <!--[if !IE]> -->

            <script type="text/javascript">
                window.jQuery || document.write("<script src='/assets/js/jquery-2.0.3.min.js'>" + "<" + "/script>");
            </script>

            <!-- <![endif]-->

            <!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='/assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

            <script type="text/javascript">
                if ("ontouchend" in document) document.write("<script src='/assets/js/jquery.mobile.custom.min.js'>" + "<" + "/script>");
            </script>

            <!-- inline scripts related to this page -->

            <script type="text/javascript">
                function show_box(id) {
                    jQuery('.widget-box.visible').removeClass('visible');
                    jQuery('#' + id).addClass('visible');
                }
            </script>



        </form>

    </body>

</html>
