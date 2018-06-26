<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="join.aspx.cs" Inherits="join" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script>
         $(document).ready(function () {     
         
             $("#send").click(function () {
                var errmsg = "";
                var username= $("#username").val();
                var email = $("#email").val();
                var phone = $("#phone").val();
                var lesson = '<%=lessonid%>';
              
                if (username == '') {
                    errmsg += ('請輸入聯絡人\r\n');
                  }
                if (email == '') {
                    errmsg += ('請輸email\r\n');
                }
                if (phone == '') {
                    errmsg += ('請輸phone\r\n');
                }
           
                if (errmsg != "") {
                    alert(errmsg);
                } else {
                   
                    var dataValue = {kind:'joinlesson',
                        username: username, email: email, phone: phone
                        , lessonid: lesson
                    }                 
                        $.post('/lib/Handler.ashx', dataValue, function (result) {
                            if (result != "") {
                               
                                alert(result);
                   
                            }
                        });
       
                }
            })
              

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container">
   <label for="fname">  課程名稱: <%=subject %></label>
      
    <label for="fname">姓名</label>
    <input type="text" id="username" name="username" placeholder="請輸入你的姓名">

    <label for="lname">Email</label>
    <input type="text" id="email" name="Email" placeholder="請輸入你的Email">

    <label for="country">聯絡電話</label>
    <input type="text" id="phone" name="phone" placeholder="請輸入你的phone">
    
    


    <input type="button" id="send" value="報名">

</div>
</asp:Content>

