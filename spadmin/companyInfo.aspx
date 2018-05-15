<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_title" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script >

 
function getdata() {   
    $.postJSON('companyinfo.ashx', { "action": "get", "_": new Date().getTime() }, function (data) {       
        if (data != "") {
            var data = JSON.parse(data);                                         
       
            $.each(data, function (key, val) {
                var id = "#" + key
                $(id).val(val);
                   
            });

           

        }
    });     
}

       $(document).ready(function () {  
            getdata();
         
        
              
        });
    </script>
    <div class="page-header">
        <h1>公司基本資料設定
        </h1>
    </div>
    <!-- /.page-header -->

    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
       
                <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">公司名稱 </label>
                    <div class="col-sm-9">
                        <input type="text" id="companyName" placeholder="公司名稱" class="col-xs-10 col-sm-5" />
                    </div>
                </div>

                   <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">公司統編 </label>
                    <div class="col-sm-9">
                        <input type="text" id="companyNo" placeholder="公司統編" class="col-xs-10 col-sm-5" />
                    </div>
                </div>

                   <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-1">facebook id</label>
                    <div class="col-sm-9">
                        <input type="text" id="facebookid" placeholder="facebook id" class="col-xs-10 col-sm-5" />
                    </div>
                </div>

                <div class="space-4"></div>

                <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right" for="form-field-tags">Tag input</label>

                    <div class="col-sm-9">
                        <input type="text" name="tags" id="form-field-tags" value="Tag Input Control" placeholder="Enter tags ..." />
                    </div>
                </div>

                <div class="clearfix form-actions">
                    <div class="col-md-offset-3 col-md-9">
                        <button class="btn btn-info" type="button">
                            <i class="icon-ok bigger-110"></i>
                            Submit
                        </button>

                        &nbsp; &nbsp; &nbsp;
											<button class="btn" type="reset">
                                                <i class="icon-undo bigger-110"></i>
                                                Reset
                                            </button>
                    </div>
                </div>

                <div class="hr hr-24"></div>

         </div>
        </div>
    

           


</asp:Content>

