<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="unitdata.aspx.cs" Inherits="unitdata" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
            <div class="main-content">

                <div class="breadArea">
                    <div class="container">
                        <ol class="breadcrumb">
                            <li><a href="/">HOME</a></li>
                            <li class="active"><%= unitname %></li>
                        </ol>
                    </div>
                </div><!-- breadArea END -->

                <div class="container">

                    <div class="row">

                        <div class="col-md-8 main-content">
                            <div class="main-content-inner">

                                <article class="post-layout post">

                                    <div class="post-header">

                                        <div class="post-information">
                                            <h1><%= unitname %></h1>
                                            <div class="meta-info">
                                                <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00"></time></span>
                                            </div><!-- meta-info END -->
                                        </div><!-- post-information END -->

                                    </div><!-- post-header END -->

                                    <div class="post-content">
                                   <%=contents  %>

                                    </div><!-- post-content END -->

                                </article>

                            </div><!-- main-content-inner END -->

                        </div><!-- col-md-8 td-main-content END -->


                    </div><!-- row END -->

                </div><!-- container END -->

            </div><!-- main-content END -->

</asp:Content>

