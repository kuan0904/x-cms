<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdBanner.aspx.cs" Inherits="AdBanner" %>
  
        <ul class="banner-group">
            <asp:Repeater ID="bannerlist" runat="server" EnableViewState ="false" >
                 <ItemTemplate>
                        <li class="col-md-12 col-sm-4 col-xs-4 thumbnail">
                            <a href="#" title="img-banner-300x200" target="_blank">
                                <img src="images/img-banner-300x200.jpg" alt="" title="">
                            </a>
                        </li>
                     </ItemTemplate> 
            </asp:repeater>        
        </ul>

