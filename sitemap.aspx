<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="sitemap.aspx.cs" Inherits="sitemap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
          <div class="breadArea">
                    <div class="container">
                        <ol class="breadcrumb">
                            <li><a href="/">HOME</a></li>
                            <li class="active">網站導覽</li>
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

                                <ul >
                                                    <li><a href="/1/catalog">最新消息</a>
                                                        <ul class="sub-menu">
                                                            <li class="menu-item"><a href="/7/catalog">產業動態</a></li>
                                                            <li class="menu-item"><a href="/8/catalog">文化政策</a></li>
                                                            <li class="menu-item"><a href="/9/catalog">民間文藝</a></li>
                                                        </ul>
                                                    </li>
                                                    <li ><a href="/2/catalog">活動</a>
                                                        <ul class="sub-menu">
                                                            <li class="menu-item"><a href="/10/catalog">展覽</a></li>
                                                            <li class="menu-item"><a href="/11/catalog">表演</a></li>
                                                            <li class="menu-item"><a href="/12/catalog">體驗</a></li>
                                                        </ul>
                                                    </li>
                                                    <li ><a href="/3/catalog">藝MBA</a>
                                                        <ul class="sub-menu">
                                                            <li class="menu-item"><a href="/13/catalog">產業經營</a></li>
                                                            <li class="menu-item"><a href="/14/catalog">設計</a></li>
                                                            <li class="menu-item"><a href="/15/catalog">跨界創新</a></li>
                                                            <li class="menu-item"><a href="/16/catalog">在地創生</a></li>
                                                        </ul>
                                                    </li>
                                                    <li ><a href="/4/catalog">專題報導</a></li>
                                                    <li ><a href="/5/catalog">人物</a></li>
                                                    <li ><a href="/6/catalog">跨界媒合</a>
                                                        <ul class="sub-menu">
                                                            <li class="menu-item"><a href="/17/catalog">文創人才</a></li>
                                                            <li class="menu-item"><a href="/18/catalog">群眾募資</a></li>
                                                        </ul>
                                                    </li>
                                                </ul>


                                <div class=clearfix></div>

                            </div><!-- main-content-inner END -->

                        </div><!-- col-md-8 td-main-content END -->


                    </div><!-- row END -->

                </div><!-- container END -->

                           
                                
                          

   

</asp:Content>

