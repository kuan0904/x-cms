<%@ Page Title="" Language="C#"   AutoEventWireup="true" CodeFile="LessonList.aspx.cs" Inherits="spadmin_LessonList" %>
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
        <title></title>
    	<!-- basic styles -->
		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />    
		<link rel="stylesheet" href="assets/css/ace.min.css" />
    </head>     

<body >


 		<div class="table-responsive">
  	  
										

		<div class="col-xs-12">
									

			<div class="table-responsive">
				<table id="sample-table-2" class="table table-striped table-bordered table-hover">
                    <thead>								
                        <tr>
                        <th class="center">	<i class="icon-time bigger-110 hidden-480"></i>訂單編號</th>
                        <th class="center">付款方式</th>
                        <th class="center">狀態</th>

                        <th>姓名</th>
                        <th>Email</th>
                        <th>電話</th>
                        <th>公司名稱</th>
                        <th>職稱</th>                      
                        <th align="center">報到</th>
                    </tr>
                    </thead>
					<tbody>
											

									
                        <%=html %>
							

					</tbody>
				</table>
			</div>
		</div>
	</div>
		    
       
		<!-- basic scripts -->

		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

		<script src="assets/js/bootstrap.min.js"></script>

		<script src="assets/js/jquery.dataTables.min.js"></script>
		<script src="assets/js/jquery.dataTables.bootstrap.js"></script>

		<script type="text/javascript">
			jQuery(function($) {
				var oTable1 = $('#sample-table-2').dataTable( {
				"aoColumns": [
			      null,
			      null,null, null, null,
				   null, null,null, { "bSortable": false }
                    ]
                    ,
                    "aLengthMenu": [
                        [25, 50, 100, 200, -1],
                        [25, 50, 100, 200, "All"]
                    ],
                    iDisplayLength: -1,
                    "oLanguage":{"sProcessing":"處理中...",
                                     "sLengthMenu":"顯示 _MENU_ 項結果",
                                     "sZeroRecords":"沒有匹配結果",
                                     "sInfo":"顯示第 _START_ 至 _END_ 項結果，共 _TOTAL_ 項",
                                     "sInfoEmpty":"顯示第 0 至 0 項結果，共 0 項",
                                     "sInfoFiltered":"(從 _MAX_ 項結果過濾)",
                                     "sSearch":"搜索:",
                                     "oPaginate":{"sFirst":"首頁",
                                                          "sPrevious":"上頁",
                                                          "sNext":"下頁",
                                                          "sLast":"尾頁"}
                                     }
                }

                );
				
				
	
			})
	

            jQuery.postJSON = function (url, para, contentType, callback) {
            if (contentType == null || contentType == '') contentType = "text/xml";
            $.ajax({
                type: 'POST',
                url: url,
                data: para,
                dataType: "json",
                contentType: contentType,
                async: false,
                cache: false,
                success: function (data) { callback(data); },
                error: function (xhr, error) { callback(''); }
            });
            };

            //"fnServerParams": function (aoData) {  //查询条件
            //                    aoData.push(
            //                        { "name": "user_name", "value": $("#") },
            //                        { "name": "user_no", "value": "cde" }
            //                        );
            //                },



            //var oTable = $('#editable-sample').dataTable(tableInit);
            
            //$("button[name='btnType']").bind("click", function () { //按钮 触发table重新请求服务器
            //    oTable.fnDraw();
            //});

        $(document).ready(function(){
            $("#Text1").keyup(function () {
                $('tr:not(:has('+ $("#Text1").val() +'))').css("background", "#FFFFFF");
                $('tr:contains('+ $("#Text1").val() +')').css( "background", "#00FF00");
             
            });
		//顯示視窗前呼叫
            //$("#ooo").on("show.bs.modal", function (e) {      
            //});

            //轉場特效結束，已完全呈現時呼叫
            //$("#ooo").on("shown.bs.modal",function(e){
            ////  console.log('轉場特效結束，已完全呈現時呼叫');
            ////});

            ////關閉視窗前呼叫
            //$("#ooo").on("hide.bs.modal",function(e){
            //  console.log('關閉視窗前呼叫');
            //});

            //轉場特效結束，已完全隱藏時呼叫
            //$("#ooo").on("hidden.bs.modal",function(e){
            //  console.log('轉場特效結束，已完全隱藏時呼叫');
            //});

            //隱藏視窗
            //$("#ooo").modal('hide');

            //開啟視窗
            //$("#ooo").modal('show');

            //切換視窗顯示、不顯示
            //$("#ooo").modal('toggle');

            //判斷視窗是否開啟中
            //if($("#ooo").hasClass('in')){
            //  console.log('視窗目前是開啟的狀態..');
            //}
            $('#exampleModal').on('show.bs.modal', function (event) {
              var button = $(event.relatedTarget) // Button that triggered the modal
              var ord_code = button.data('ord_code') // Extract info from data-* attributes
               
               
            var dataValue = "{ord_code:'"+  ord_code +"'}";             
            $.postJSON('LessonList.aspx/get_orddata', dataValue, 'application/json; charset=utf-8', function (result) {
                var result = result.d.replace('src="/','src="');
        
                var modal = $(this)
                //modal.find('.modal-title').text('New message to ' + recipient)
               $('.modal-body').html(result)          
                  
            });
            
            })
		});
		</script>
    <!--
  「data-backdrop="static"」 鎖定背景，點擊背景時不自動關閉視窗
  「fade」 淡入、淡出的轉場效果
  「modal-lg」視窗大小，如modal-lg、modal-md、modal-sm
  「data-dismiss="modal"」 關閉視窗
  「data-keyboard="true"」 是否用ESC鍵關閉，預設為true
-->


<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">訂單資訊</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      
      </div>
    </div>
  </div>
</div>

    </body>
</html>