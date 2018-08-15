<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="list-search.aspx.cs" Inherits="list_search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script>
           
        $(document).ready(function () {     
            var dataValue = {"kind":"list"};             
            $.post('/hot_list', dataValue, function (result) { $("#hot_list").html(result); });
            dataValue = {"classid":"2"};             
            $.post('/AdBanner', dataValue, function (result) { $("#ad_banner").html(result); });
              dataValue = {"classid":"1"};             
            $.post('/topBanner', dataValue, function (result) { $("#top_banner").html(result); });
            document.body.classList.add("list");
        });
    
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="main-content">

          <div class="breadArea">
                    <div class="container">
                        <ol class="breadcrumb">
                            <li><a href="/">HOME</a></li>
                            <li class="active">搜尋結果</li>
                        </ol>
                    </div>
                </div><!-- breadArea END -->

                <div class="container">
                    <h1 class="site-title"><%=Application["site_name"]%></h1>

                    <div class="titlePic">
                        <div class="jumbotron">
                            <div class="container">
                                <h2>搜尋結果</h2>
                            </div>
                        </div>
                    </div><!-- titlePic END -->

                    <div class="row">

                        <div class="col-md-8 col-sm-8 main-content">
                            <div class=main-content-inner>

                                <div class="page-header">
                                    <h2 class="search-title">
                                        <span class="search-query"><%=keyword  %></span> - <span> 搜尋結果</span>
                                    </h2>

                                    <div class="search-wrap">
                                        <div class="form-group">
                                            <input class="form-control" type="text" value="<%=keyword  %>" name="s1"  >
                                            <input class="btn btn-search" type="submit"   name ="header-search" value="Search">
                                        </div>
                                        <p>若沒有找到您需要的文章或資訊，麻煩您再下一次關鍵字重新搜尋</p>
                                    </div><!-- search-wrap END -->

                                </div><!-- page-header END -->

                                <div class="row news-grid">

                                    <asp:Repeater ID="list_detail" runat="server">
                                        <ItemTemplate>
                                    <div class="col-xs-6">
                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="<%#Eval("pic") %>" alt="" title="<%#Eval("subject") %>">
                                                <a class="view-more" href="/Article/<%#Eval("id") %>" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <div class="meta-info">
                                                    <%# article.Web.Get_category_link  ((int) Eval("id"))%>

                                                    <span class="post-date"><time datetime="<%#Eval("PostDay") %>"><%# DateTime.Parse( Eval("PostDay").ToString ()).ToString ("MM/dd") %></time></span>
                                                </div><!-- meta-info END -->

                                                <h3 class="title"><a href="/Article/<%#Eval("id") %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                            </div>
                                        </div>
                                    </div><!-- col-xs-6 END -->

                                    </ItemTemplate>
                                    </asp:Repeater>

                                </div><!-- news-grid END -->
                         <ul class="pagination">
                        <%=PagePaging () %>
                        </ul>

                                <div class=clearfix></div>

                            </div><!-- main-content-inner END -->

                        </div><!-- col-md-8 td-main-content END -->

                        <div class="col-md-4 col-sm-4 main-sidebar">
                            <!-- <div class=main-sidebar-inner> -->

                                 <div class="block-wrap" id="ad_banner"></div>   

                                  <div class="block-wrap"  id="hot_list"></div>

                                <div class="block-wrap">
                                    <iframe src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2F%E6%99%BA%E5%AA%92%E6%99%82%E4%BB%A3-1880890488818139%2F&tabs=timeline&width=300&height=500&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=1355515061131043" width="300" height="500" scrolling="no" frameborder="0" allowTransparency="true" style="display: block; width: 300px; margin: auto;"></iframe>
                                </div>

                            <!-- </div> --><!-- main-sidebar-inner END -->
                        </div><!-- col-md-4 END -->

                    </div><!-- row END -->

                </div><!-- container END -->
        </div> 
</asp:Content>

