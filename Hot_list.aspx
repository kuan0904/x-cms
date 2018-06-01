<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Hot_list.aspx.cs" Inherits="Hot_list" %>

                                    <div class=block-title>熱門排行榜</div>
                                    <div class="news-wrap news-list">
                                        <asp:Repeater ID="news_hotlist" runat="server" EnableViewState ="false" >
                                            <ItemTemplate>
                                            <div class="thumbnail">
                                                <div class="pic effect">
                                                    <img src="/webimages/article/<%#Eval("pic") %>" alt="" title="<%#Eval("subject") %>">
                                                    <a class="view-more" href="/Article/<%#Eval("id") %>" title="了解更多"><span>more</span></a>
                                                </div>

                                                <div class="caption">
                                                    <h3 class="title"><a href="/Article/<%#Eval("id") %>" title="<%#Eval("subject") %>"><%#Eval("subject") %></a></h3>
                                                </div>
                                            </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div><!-- news-list END -->
                         
