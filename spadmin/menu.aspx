<%@ Page Language="C#" AutoEventWireup="true" CodeFile="menu.aspx.cs" Inherits="spadmin_menu" %>
  
            <!-- left menu starts -->
           <table >
             
                       <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1"  OnItemDataBound="R1_ItemDataBound">
                            <ItemTemplate>
                                <%# Container.ItemIndex % 5 == 0 ? "<tr>":""%>
                               
                                    <td style="vertical-align: top; width: 300px;">
                                <ul class="nav nav-tabs nav-stacked main-menu">
                     
                                <li style="border-style: outset; border-width: 1px; font-family: 微軟正黑體; font-size: 14px; font-weight: bold; line-height: 45px; text-align: center;">
                                   <%# Eval("unitname") %> </li>
                          
                                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                                    <ItemTemplate>
                                        <li><a class="ajax-link" href='<%# Eval("adminpage") %><%# Eval("adminpage").ToString().IndexOf("?") > 0 ? "&":"?"  %>unitid=<%# Eval("unitid") %>'
                                            <%# Eval("adminpage").ToString().IndexOf("http") > 0  ? " target=_blank ": "" %> >
                                            <i class="icon icon-bullet-on"></i><span class="hidden-tablet">
                                                <%# Eval("unitname") %></span></a></li>
                                    </ItemTemplate>
                                </asp:Repeater> 

                                </ul>
                                        </td> 
                                      <%# Container.ItemIndex % 5 == 4? "</tr>":""%>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>"
                                    SelectCommand="" ></asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:Repeater>
                 
            
              </table>
           
            <!-- left menu ends -->
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:dbconnConnection %>"
              
                 SelectCommand="" ></asp:SqlDataSource>
          
