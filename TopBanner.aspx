<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TopBanner.aspx.cs" Inherits="TopBanner" %>

 <asp:Repeater ID="Repeater1" runat="server" EnableViewState ="false">
        <ItemTemplate>
        <div class="swiper-slide item">
        <div class="image" style="background-image: url('/webimages/banner/<%#Eval("pic") %>');">
            <div class="carousel-caption">
                <div class="container">
                    <h3><a href="<%#Eval("url") %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                    <p><%#Eval("contents") %></p>
                </div>
            </div>
            <a href="<%#Eval("url") %>" class="view-more" title="了解更多">我想了解</a>
        </div>
    </div>
        </ItemTemplate>
    </asp:Repeater>

