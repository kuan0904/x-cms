<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="detail.aspx.cs" Inherits="detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <div class="breadArea">
                    <div class="container">
                        <ol class="breadcrumb">
                            <li><a href="hp.html">HOME</a></li>
                            <li class="active">最新消息</li>
                        </ol>
                    </div>
                </div><!-- breadArea END -->

                <div class="container">

                    <a href="javascript: history.go(-1)" class="btn btn-back">
                        <span class="fa fa-angle-left"></span>BACK
                    </a>

                    <div class="row">

                        <div class="col-md-8 col-sm-8 main-content">
                            <div class="main-content-inner">

                                <article class="post-layout post">

                                    <div class="post-header">

                                        <div class="post-featured-image">

                                            <!-- <a href="https://images.unsplash.com/photo-1505664194779-8beaceb93744?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=42a10871f610c84a108afd8c3750fbae&auto=format&fit=crop&w=1350&q=80">
                                                <img class="image-full modal-image size-full" src="https://images.unsplash.com/photo-1505664194779-8beaceb93744?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=42a10871f610c84a108afd8c3750fbae&auto=format&fit=crop&w=1350&q=80" width="1350" height="900" />
                                            </a> -->
                                            <a href="https://images.unsplash.com/photo-1518891244084-914c518195a6?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=3b36f0e7540ce34398cc7052a7e160ce&auto=format&fit=crop&w=1267&q=80">
                                                <img class="image-full modal-image size-full" src="https://images.unsplash.com/photo-1518891244084-914c518195a6?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=3b36f0e7540ce34398cc7052a7e160ce&auto=format&fit=crop&w=1267&q=80" width="1350" height="900" />
                                            </a>
                                        </div>


                                        <div class="post-information">
                                            <ul class="category">
                                                <li class="entry-category"><a href="#">人物/職場</a></li>
                                            </ul>
                                            <h1>新創團隊想成為搶手數位行銷人？學習寫程式讓你技能大加分！</h1>
                                            <div class="meta-info">
                                                <div class="post-author">
                                                    <span>By</span>
                                                    <a href="#/author/admin/">ALPHA Camp</a>
                                                    <span> - </span>
                                                </div>
                                                <span class="post-date"><time datetime="2017-07-26T14:17:05+00:00">2017/7/26</time></span>
                                                <div class="post-views">
                                                    <i class="fa fa-eye"></i>405</div>
                                                <div class="post-comments">
                                                    <a href="#respond"><i class="fa fa-comments"></i>0</a>
                                                </div>
                                                <div class="post-keywords">
                                                    <i class="fa fa-tags"></i>
                                                    <a href="#">搜尋引擎</a>
                                                    <a href="#">網站維護</a>
                                                    <a href="#">SEO</a>
                                                    <a href="#">CMS</a>
                                                </div>
                                            </div>
                                        </div><!-- meta-info END -->

                                        <div class="post-sharing">
                                            <span class="post-share-title">SHARE</span>
                                            <div class="sharing-group">
                                                <a class="btn-share facebook" href="#" onclick="window.open(this.href, 'mywin','left=50,top=50,width=600,height=350,toolbar=0'); return false;">
                                                    <div class="icon-elements facebook"></div>
                                                    <div class="social-text">Facebook</div>
                                                </a>

                                                <a class="btn-share twitter" href="#"><div class="icon-elements twitter"></div><div class="social-text">Twitter</div></a>

                                                <a class="btn-share google" href="#" onclick="window.open(this.href, 'mywin','left=50,top=50,width=600,height=350,toolbar=0'); return false;"><div class="icon-elements googleplus"></div></a>

                                                <a class="btn-share pinterest" href="#" onclick="window.open(this.href, 'mywin','left=50,top=50,width=600,height=350,toolbar=0'); return false;"><div class="icon-elements pinterest"></div></a>

                                                <a class="btn-share whatsapp" href="#"><div class="icon-elements whatsapp"></div></a>

                                                <div class="clearfix"></div>
                                            </div><!-- sharing-group END -->
                                        </div><!-- post-sharing END -->
                                    </div><!-- post-header END -->

                                    <div class="post-content">
                                        <p>是時候面對現實了！今日的數位行銷已演變成技術含量高、講求成果和數據的一門學問。各式各樣的數據分析工具正大行其道，也徹底改變了現今的行銷模式。想要搞懂並有效的使用這些工具的關鍵是什麼？ 其實答案就是——學習寫程式。</p>

                                        <blockquote><p>數位行銷已演變成技術含量高、講求成果和數據的一門學問。搞懂並有效的使用分析工具關鍵是—學習寫程式。</p></blockquote>

                                        <p>行銷人為什麼要學寫程式？雖然市面上的行銷工具介面看似簡單不難上手，但當你需要更深入地運用這些行銷工具，做更精準、客製化的調整時，常常會需要程式的輔助。以下將介紹六種需要「程式技能」的數位行銷領域：</p>

                                        <h2>1.SEO (搜尋引擎優化)管理</h2>
                                        <p>只是在網站的內容中塞滿正確的關鍵字並不足夠，你還需要學會將關鍵字分別放置在正確的位置: 網頁的 meta 標籤敘述 （meta description）、網頁標題（heading）、標籤 （tag）、圖片標籤（Alt Tag） 等等。 要這麼做，你至少要看得懂 HTML 格式，並懂得如何依據架構修改。更進階的 SEO ，甚至會需要你了解如何調校網站的速度，這牽涉到 CDN 的運用、壓縮載入檔案（CSS、JS）、Ajax 技術等等，你或許不需要知道如何執行（這是工程師的任務），但起碼要懂得相關的原理。</p>

                                        <figure style="width:1693" class="wp-caption alignleft">
                                            <a href="https://cdn3.tnwcdn.com/wp-content/blogs.dir/1/files/2015/05/seo.jpg">
                                            <img class="modal-image image-full" src="https://cdn3.tnwcdn.com/wp-content/blogs.dir/1/files/2015/05/seo.jpg" width="1693" height="889" /></a>
                                            <figcaption class="wp-caption-text">SEO (搜尋引擎優化)管理</figcaption>
                                        </figure>

                                        <h2>2.Google Tag Manager （代碼管理工具）</h2>

                                        <figure style="width:590" class="wp-caption image-left alignleft">
                                            <a href="https://s3.envato.com/files/153804724/Google%20Tag%20Manager%20Header.png">
                                            <img class="modal-image image-full" src="https://s3.envato.com/files/153804724/Google%20Tag%20Manager%20Header.png" width="300" height="176" /></a>
                                            <figcaption class="wp-caption-text">Google Tag Manager （代碼管理工具）</figcaption>
                                        </figure>

                                        <p>儘管 Google 已將它們的分析工具做到十分簡單易懂，行銷人員人然需要懂得如何根據數據隨時進行變更、埋追蹤碼以及從中看出使用者造訪哪些網頁。Google Tag Manager 可以讓行銷人員在網站上用代碼做出標記（Tag），比如追蹤和優化的代碼。這些代碼其實就是以極小段的 JavaScript 程式碼將特定資訊回傳給第三方。要理解代碼的概念核心，首先需要擁有對 JavaScript 和 HTML 基本的了解。</p>

                                        <h2>3.自動化 Google AdWord （關鍵字廣告）</h2>

                                        <p>Google 推出了關鍵字廣告的指令碼自動調整，用簡單的 JavaScript 和基於瀏覽器的 IDE 開發環境，透過撰寫指令碼來操作關鍵字廣告。好在對於行銷人員來說，只需要懂基本的 JavaScript 即可完成設定，並讓使用者可以建立更強大、有效的廣告。</p>

                                        <!-- <p><a href="https://dummyimage.com/827x1068/3498db/fff.jpg"><img class="modal-image image-left alignleft" src="https://dummyimage.com/280x362/3498db/fff.jpg" width=280 height=362 /></a></p> -->

                                        <h2>4. A/B 測試</h2>

                                        <p>為了能快速測試到達頁面，有時你需要能自己做出調整和變更，因此你需要知道如何寫簡單的程式碼。如果你的結帳流程更快速，是否可以提升轉換率？ 又或者，如果將「了解詳情」的按鈕移到網頁上方是否會帶來更多潛在客戶？ 雖然以上的變更都能夠請工程師直接完成，行銷人員若是會寫程式碼便可以更有效的溝通測試需求，甚至在工程師忙碌時提出協助。</p>

                                        <h2>5. 打造有效的 Landing Page</h2>
                                        <!-- <p><a href="https://dummyimage.com/827x1068/3498db/fff.jpg"><img class="modal-image image-right alignnone" src="https://dummyimage.com/280x419/3498db/fff.jpg" width=280 height=419 /></a></p> -->

                                        <p><a href="http://ericksondigital.com/wp-content/uploads/2012/11/perfect-landing-page-design.jpg"><img class="modal-image image-right alignnone" src="http://ericksondigital.com/wp-content/uploads/2012/11/perfect-landing-page-design.jpg" width="280" height="419" /></a></p>


                                        <p>擁有 CSS 和 HTML 的相關知識對於確保網頁排版、體驗流暢都是十分有用的。當然類似 WordPress 等內容管理系統 （CMS） 本身即有簡易上手的使用介面，可以透過拖拉按鈕調整網頁，但有時結果不盡理想，可能文字無法對齊、又或者圖片的大小不是你想要的樣子…說到底，真的值得你每次都麻煩工程團隊去完成這些小細節的調整嗎？ 當然不，還不如自己來，事情會完成得更加迅速。</p>

                                        <h2>6. 解決問題和溝通</h2>

                                        <p>了解網站如何運作，有助於行銷人員理解一個線上行銷活動哪裡可能會出錯。 是不是提供的連結有 bug？ 還是你的內容不流暢、缺乏邏輯性？ 訓練自己以寫程式的方式思考會有助你增進邏輯思考、找出 bug和解決問題的能力。更重要的是，這能夠有效地增進你跟工程師溝通的效率。</p>

                                        <h2>試著踏出第一步</h2>


                                        <figure style="width:1068px" class="wp-caption alignnone">
                                            <a href="http://acousticfacts.com/sites/default/files/styles/news_big/public/first_step.jpg?itok=FPoThENl">
                                                <img class="image-full modal-image size-full" src="http://acousticfacts.com/sites/default/files/styles/news_big/public/first_step.jpg?itok=FPoThENl" width="770" height="470" />
                                            </a>
                                            <figcaption class="wp-caption-text">試著踏出第一步</figcaption>
                                        </figure>

                                        <p>現在的數位行銷人可不比以往，從 SEO、SEM、內容行銷、電子郵件行銷、社群經營、行動行銷，到 Landing Page 優化，沒有一樣不需要追蹤成效，而這其中程式碼片段無所不在，與其劃清界線將一切都丟給工程師，看到程式碼就怕，不如試著踏出第一步去多瞭解接觸基本的程式技能和知識。在跨領域人才越來越被渴求的這個時代，學習程式不只能幫你的行銷專業大幅加值，也能讓你的數據分析能力更上層樓，因為你將了解如何客製化許多行銷工具甚至自己串接需要的 API， 並與工程師順暢的溝通，知道科技的局限性與可能性，才能提出合理的要求以及建立正確的期待值。</p>

                                        <p>如果你想要在相對短的時間內建立數位行銷相關的系統化知識，數據分析的思維，並成為一個有基礎程式能力的行銷人員， ALPHA Camp 的10週數位行銷實戰營 當然是很好的選擇，又或者如果你希望能自學進修，這裏是 HubSpot 為初學者提供的線上資源清單，相信也會對你有所幫助！</p>
                                    </div><!-- post-content END -->

                                    <div class="post-footer">
                                        <div class="post-sharing">
                                            <span class="post-share-title">SHARE</span>
                                            <div class="sharing-group">
                                                <a class="btn-share facebook" href="#" onclick="window.open(this.href, 'mywin','left=50,top=50,width=600,height=350,toolbar=0'); return false;">
                                                    <div class="icon-elements facebook"></div>
                                                    <div class="social-text">Facebook</div>
                                                </a>

                                                <a class="btn-share twitter" href="#"><div class="icon-elements twitter"></div><div class="social-text">Twitter</div></a>

                                                <a class="btn-share google" href="#" onclick="window.open(this.href, 'mywin','left=50,top=50,width=600,height=350,toolbar=0'); return false;"><div class="icon-elements googleplus"></div></a>

                                                <a class="btn-share pinterest" href="#" onclick="window.open(this.href, 'mywin','left=50,top=50,width=600,height=350,toolbar=0'); return false;"><div class="icon-elements pinterest"></div></a>

                                                <a class="btn-share whatsapp" href="#"><div class="icon-elements whatsapp"></div></a>

                                                <div class="clearfix"></div>
                                            </div><!-- sharing-group END -->
                                        </div><!-- post-sharing END -->
                                    </div><!-- post-footer END -->

                                </article>

                            </div><!-- main-content-inner END -->

                        </div><!-- col-md-8 td-main-content END -->

                        <div class="col-md-4 col-sm-4 main-sidebar">
                            <!-- <div class=main-sidebar-inner> -->

                                <div class="block-wrap">
                                    <ul class="banner-group">
                                        <li class="col-md-12 col-sm-4 col-xs-4 thumbnail">
                                            <a href="#" title="img-banner-300x200" target="_blank">
                                                <img src="images/img-banner-300x200.jpg" alt="" title="">
                                            </a>
                                        </li>
                                        <li class="col-md-12 col-sm-4 col-xs-4 thumbnail">
                                            <a href="#" title="img-banner-300x200" target="_blank">
                                                <img src="images/img-banner-300x200.jpg" alt="" title="">
                                            </a>
                                        </li>
                                    </ul>
                                </div>

                                <div class="block-wrap">
                                    <div class=block-title>訂閱電子報</div>
                                    <div class="epaper-box">
                                        <p>精選國內外設計與藝文大事、設計大師最新訪談，每週最新資訊定期遞送給您。</p>
                                        <div class="form-inline">
                                          <div class="form-group">
                                            <label class="sr-only" for="exampleInputEmail2">Email</label>
                                            <input type="email" class="form-control" id="exampleInputEmail2" placeholder="yourmail@example.com">
                                          </div>
                                          <button type="submit" class="btn btn-default">訂閱</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="block-wrap">
                                    <div class=block-title>熱門排行榜</div>

                                    <div class="news-wrap news-list">
                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://images.unsplash.com/photo-1509291985095-788b32582a81?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=3df807fb97311a00d38399243f18a4ab&auto=format&fit=crop&w=634&q=80" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                            </div>
                                        </div>

                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://images.unsplash.com/photo-1509569785882-4c160654309e?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=50a017034806c9eaf81d0477181f7f4b&auto=format&fit=crop&w=1350&q=80" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                            </div>
                                        </div>

                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://images.unsplash.com/photo-1507587396692-5afe1f777676?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=f4896d6d5ff445224485ff22493e423c&auto=format&fit=crop&w=634&q=80" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                            </div>
                                        </div>

                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://images.unsplash.com/photo-1489809415321-e23671dcbc81?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=fa140a740b16c639cd62930f158469ea&auto=format&fit=crop&w=1350&q=80" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                            </div>
                                        </div>

                                        <div class="thumbnail">
                                            <div class="pic effect">
                                                <img src="https://dummyimage.com/100x70/6b6b6b/fff.jpg" alt="" title="如何選擇適合自己的內容管理系統（CMS）">
                                                <a class="view-more" href="detail.html" title="了解更多"><span>more</span></a>
                                            </div>

                                            <div class="caption">
                                                <h3 class="title"><a href="detail.html" title="如何選擇適合自己的內容管理系統（CMS）">如何選擇適合自己的內容管理系統（CMS）</a></h3>
                                            </div>
                                        </div>

                                    </div><!-- news-list END -->
                                </div>

                                <div class="block-wrap">
                                    <iframe src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2F%E6%99%BA%E5%AA%92%E6%99%82%E4%BB%A3-1880890488818139%2F&tabs=timeline&width=300&height=500&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=1355515061131043" width="300" height="500" scrolling="no" frameborder="0" allowTransparency="true" style="display: block; width: 300px; margin: auto;">
                                    </iframe>
                                </div>

                                <div class="block-wrap">
                                    <ul class="banner-group">
                                        <li class="col-md-12 col-sm-4 col-xs-4 thumbnail">
                                            <a href="#" title="img-banner-300x200" target="_blank">
                                                <img src="images/img-banner-300x200.jpg" alt="" title="">
                                            </a>
                                        </li>
                                    </ul>
                                </div>

                            <!-- </div> --><!-- main-sidebar-inner END -->
                        </div><!-- col-md-4 END -->


                    </div><!-- row END -->

                </div><!-- container END -->

</asp:Content>

