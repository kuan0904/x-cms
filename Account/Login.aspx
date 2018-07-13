<%@ Page Title="登入" Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Account_Login" Async="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css?v=1">
	<link rel="stylesheet" type="text/css" href="css/main.css?v=1">
<!--===============================================================================================-->
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
    <div class="limiter">
		<div class="container-login100" style="background-image: url('images/bg-01.jpg');">
			<div class="wrap-login100 p-t-30 p-b-50">
				<span class="login100-form-title p-b-41">
					<%=Session["companyName"].ToString () %>
				</span>
    <form id="form1" runat="server" class="login100-form validate-form p-b-33 p-t-5">



        	<div class="wrap-input100 validate-input" data-validate = "Enter username">
					
                   <asp:TextBox ID="UserName" runat="server" name="username" class="input100" placeholder="User name" required></asp:TextBox>
						<span class="focus-input100" data-placeholder="&#xe82a;"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Enter password">
	
                            <asp:TextBox ID="Password" runat="server" TextMode="Password" placeholder="Password" class="input100" required></asp:TextBox>
						<span class="focus-input100" data-placeholder="&#xe80f;"></span>
					</div>
        	        <div class="wrap-input100 validate-input" data-validate="Enter password">
	                        <img id="imgverifycode" style="vertical-align: bottom; cursor: pointer;" src="/lib/Captcha.ashx" alt="驗證碼" title="">
                            <asp:TextBox ID="VERIFYCODE" runat="server" placeholder="輸入驗証碼"></asp:TextBox>

					</div>
					<div class="container-login100-form-btn m-t-32">
                        
                                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>

                                            <asp:Button ID="LoginButton" runat="server" CommandName="Login"
                                               class="login100-form-btn"
                                                Text="登入" ValidationGroup="Login1" OnClick="LogIn" />
					 
					</div>

		</form>
			</div>
		</div>
	</div>
	

	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>