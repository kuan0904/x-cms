<%@ Page Title="" Language="C#" MasterPageFile="admin.master" AutoEventWireup="true" CodeFile="keyword_set.aspx.cs" Inherits="admin_keyword_set" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <script>

       
        function getQueryParams(queryParams) {
            //  var t1 = $("#t1").datebox("getValue");

            var t1 = document.getElementById("t1").value;
            var t2 = document.getElementById("t2").value;
            var t3 = $('#t3').combobox('getValue');
            //$("#sex").combobox("getValue");

            queryParams.t1 = t1;
            queryParams.t2 = t2;
            queryParams.t2 = t3;
            return queryParams;

        }
      
        function reloadgrid() {      
            var queryParams = $('#tt').datagrid('options').queryParams;
            getQueryParams(queryParams);         
            $('#tt').datagrid('options').queryParams = queryParams;
            $("#tt").datagrid('reload');

        }
       
        function newData() {
            $('#fm').form('clear');
            $('#dlg').dialog('open').dialog('setTitle', '新增資料');
            document.getElementById("kind").value = "add";
        }


        function editData() {

            var row = $('#tt').datagrid('getSelected');
            if (row == null) {
                $.messager.alert("提示", "請選擇要修改的資料！", "info");
            }


            //   loadsex()
            if (row) {
                $('#keyword').val(row.keyword);
                $('#url').val(row.url);
                $('#account').combobox('setValue', row.WorkerRealName);
                $('#color').val(row.color)
                $('#dlg').dialog('open').dialog('setTitle', '修改資料');
                document.getElementById("kind").value = "modify";
                $('#fm').form('load', row);

            }
        }
        function loadsex() {
            var queryaccount = "getsex.ashx";
            $.getJSON(queryaccount, function (json) {
                $('#account').combobox({
                    data: json.rows,
                    valueField: 'id',
                    textField: 'sex',
                    required: 'true',
                    editable: 'false'
                });
            })



        }

        function saveData() {

            var url = document.getElementById("url").value;
            var color = document.getElementById("color").value;
            var status = $("#status").combobox("getValue");

            var keyword = document.getElementById("keyword").value;
           
            var kind = document.getElementById("kind").value;

            if (kind == "add") {

                var data = { "kind": kind, "data": [{ "Id": "", "url": url, "keyword": keyword, "color": color, "status": status }] };
              
                $.ajax({
                    type: "post",
                    url: "getdata.ashx/ProcessRequest",
                    data: JSON.stringify(data),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var json = data; //數組 
                        var html = "";
                        html = json.status;
                        if (html == "ok") {
                            $('#dlg').dialog('close');
                            $('#tt').datagrid('clearSelections');
                            $.messager.alert("提示", "新增完畢", "info");
                            $('#tt').datagrid('reload');

                        }
                        else {

                            $.messager.alert("提示", "新增失败，請重新操作！", "info");
                            return;

                        }
                    },
                    error: (function (jqXHR, textStatus, errorThrown) {
                        alert(jqXHR.responseText);
                        // alert(jqXHR.status);
                        //alert(jqXHR.readyState);
                        //  alert(jqXHR.statusText);
                    })
                });



            } else {
                var row = $('#tt').datagrid('getSelected');
                if (row) {
                  
                    var adminID = row.id;
                }

                var data = { "kind": kind, "data": [{ "Id": adminID ,"url": url ,"keyword": keyword ,"color": color}] };

                $.ajax({
                    type: "post",
                    url: "add.ashx/ProcessRequest",
                    data: JSON.stringify(data),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var json = data; //數組 
                        var html = "";
                        html = json.status;
                        if (html == "ok") {
                            $('#dlg').dialog('close');
                            $('#tt').datagrid('clearSelections'); 
                            $.messager.alert("提示", "資料修改完畢", "info");
                            $('#tt').datagrid('reload');

                        }
                        else {

                            $.messager.alert("提示", "修改失败，請重新操作！", "info");
                            return;
                          
                        }
                    },
                    error: (function (jqXHR, textStatus, errorThrown) {
                        alert(jqXHR.responseText);
                        // alert(jqXHR.status);
                        //alert(jqXHR.readyState);
                        //  alert(jqXHR.statusText);
                    })
                });




          
            }
        }
        function removeData() {
            var kind = document.getElementById("kind").value = "delete";
            var row = $('#tt').datagrid('getSelected');
            if (row == null) {
                $.messager.alert("提示", "请選擇要刪除的資料！", "info");
            }
            if (row) {
                $.messager.confirm('提示', '你確定要刪減這筆資料嗎?？', function (r) {
                    if (r) {
                        var data = { "kind": kind, "data": [{ "Id": row.id }] };

                        $.ajax({
                            type: "post",
                            url: "add.ashx/ProcessRequest",
                            data: JSON.stringify(data),
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                var json = data; //數組 
                                var html = "";
                                html = json.status;
                                if (html == "ok") {

                                    $('#dlg').dialog('close');
                                    $('#tt').datagrid('clearSelections'); //清空选中的行
                                    $.messager.alert("提示", "資料己删除！", "info");
                                    $('#tt').datagrid('reload');

                                    // close the dialog
                                    // $('#tt').datagrid('reload');
                                    //$('#fm').form('submit');

                                }
                                else {

                                    $.messager.alert("提示", "刪減失敗，请重新操作！", "info");
                                    //alert('添加失败，请重新操作！')
                                    return;
                                    //$('#fm').form('submit');
                                }
                            },
                            error: (function (jqXHR, textStatus, errorThrown) {
                                alert(jqXHR.responseText);
                                // alert(jqXHR.status);
                                //alert(jqXHR.readyState);
                                //  alert(jqXHR.statusText);
                            })
                        });

                                             

               
                    }
                })
            }
        }

    </script>

    <script>
        function formatstatus(val, row) {
			if (val ==1 ){
				return '開啟';
			} else {
			    return '關閉';
			}
        }
        function formatcolor(val, row) {
           
            
            return val;
           
        }
    </script>
    <table id="tt" title="keyword管理" class="easyui-datagrid" style="width: auto; height: 400px;"
           idfield="itemid" pagination="true" data-options="iconCls:'icon-save',rownumbers:true,url:'keywordset.ashx/ProcessRequest',pageSize:10, pageList:[5,10,15,20],method:'get',toolbar:'#tb',striped:true" fitcolumns="true">
       
        <thead>
            <tr>
                <th data-options="field:'id',checkbox:true"></th>
                <th data-options="field:'keyword',width:200">kyeword</th>
                <th data-options="field:'url',width:400,align:'left'">url</th>
                <th data-options="field:'color',width:100,align:'left',formatter:formatcolor">顏色</th>
                <th data-options="field:'status',width:100,formatter:formatstatus">狀態</th>
            </tr>
        </thead>
       
    </table>
    
    <div id="tb" style="padding: 5px; height: auto">
       
        <div style="margin-bottom: 5px">
            <a href="javascript:void(0)" onclick="newData()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"></a>
            <a href="javascript:void(0)" onclick="editData() " class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true"></a>
            <a href="javascript:void(0)" onclick="removeData()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true"></a>
        </div>
       
        <div>
           keyword:
           <input id="t1" />
            url:
            <input id="t2" />
            狀態:
            <select id="t3" class="easyui-combobox" name="status" style="width:200px;">
                <option value="">不區分</option>
                <option value="0">關閉</option>
                <option value="1">開啟</option>
            </select>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="reloadgrid()">Search</a>
        </div>
    </div>

    <div id="dlg" class="easyui-dialog" style="width: 600px; height: auto; padding: 10px 20px"
         data-options="closed:true,buttons:'#dlg-buttons'">
     
        <div class="ftitle">Keyword管理</div>
        <form id="fm" method="post">
            <div class="fitem">
                <label>keyword：</label>
                <input id="keyword" name="keyword" class="easyui-validatebox" data-options="required:true" />
            </div>
            <div class="fitem">
                <label>url：</label>
                <input id="url" name="url" class="easyui-validatebox" data-options="required:true" />
                <input name="kind" id="kind" type="hidden" />
                <input name="AdminID" id="id" type="hidden" />
                <input id="key" name="key" onkeydown="if(event.keyCode==13)reloadgrid()" type="hidden" />
            </div>
       

            <div class="fitem">
                <label>顏色:</label>
                <input name="color" id="color" type="color" />
            </div>
            <div class="fitem">
                <label>狀態:</label>
     
                <select id="status" class="easyui-combobox" name="status" style="width:200px;">
                    <option value="0">關閉</option>
                    <option value="1">開啟</option>
                    </select> 
</div>

        </form>
    </div>
    <div id="dlg-buttons">
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveData()">存檔</a>
        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">close</a>
    </div>

</asp:Content>

