<%@ Page Title="" Language="C#" MasterPageFile="~/spadmin/admin.master" AutoEventWireup="true" CodeFile="companyinfo.aspx.cs" Inherits="spadmin_companyInfo" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_title" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        var companyinfo;
        function getdata() {
            $.post('companyinfo.ashx', { "action": "get", "_": new Date().getTime() }, function (data) {
                if (data != "") {
                    companyinfo = JSON.parse(data);
                    companyinfo = companyinfo[0];
                    $.each(companyinfo, function (key, val) {
                        var data = val;
                        var id = "#" + key
                        if ($(id) != undefined) {
                            $(id).val(val);
                        }

                    });

                }
            });
        }

        $(document).ready(function () {
         //   getdata();
            $("#update").click(function () {
                var data = "{\"action\":\"set\"";
                $.each(companyinfo, function (key, val) {
                    var id = "#" + key
                    if ($(id) != undefined) {

                        data += ",\"" + key + "\"" + ":" + "\"" + $(id).val() + "\"";
                    }

                });
                data += "}";
                var data = JSON.parse(data);
                $.post('companyinfo.ashx', data, function (data) {
                    if (data == '1') {
                        alert('更新完畢');
                    };

                });
            });
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
                    <asp:TextBox ID="companyName" runat="server" placeholder="公司名稱" class="col-xs-10 col-sm-5"></asp:TextBox>

                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">系統名稱 </label>
                <div class="col-sm-9">
                    <asp:TextBox runat="server" ID="systemName" placeholder="系統名稱" class="col-xs-10 col-sm-5"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">公司統編 </label>
                <div class="col-sm-9">
                    <asp:TextBox runat="server" ID="companyNo" placeholder="公司統編" class="col-xs-10 col-sm-5"></asp:TextBox>

                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">聯絡電話</label>
                <div class="col-sm-9">
                    <asp:TextBox runat="server" ID="phone" placeholder="聯絡電話" class="col-xs-10 col-sm-5"></asp:TextBox>

                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">公司地址</label>
                <div class="col-sm-9">
                    <asp:TextBox runat="server" ID="address" placeholder="地址" class="col-xs-10 col-sm-5"></asp:TextBox>

                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">Facebook App Id</label>
                <div class="col-sm-9">
                    <asp:TextBox runat="server" ID="FacebookAppId" placeholder="Facebook app Id" class="col-xs-10 col-sm-5"></asp:TextBox>

                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">Facebook App Secret</label>
                <div class="col-sm-9">
                    <asp:TextBox runat="server" ID="FacebookAppSecret" placeholder="Facebook App Secret" class="col-xs-10 col-sm-5"></asp:TextBox>


                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">googleapi Key</label>
                <div class="col-sm-9">
                    <asp:TextBox runat="server" ID="googleapiKey" placeholder="google api Key" class="col-xs-10 col-sm-5"></asp:TextBox>


                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">google clientId</label>
                <div class="col-sm-9">
                    <asp:TextBox runat="server" ID="googleclientId" placeholder="google client Id" class="col-xs-10 col-sm-5"></asp:TextBox>

                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">公司logo 圖示(PC)</label>
                <asp:FileUpload ID="FileUpload1" runat="server" /><asp:Button ID="Button1" runat="server" Text="上傳" OnClick="Button1_Click" /><img src="/images/logo.png" />

            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right" for="form-field-1">公司logo 圖示(手機)</label>
                <asp:FileUpload ID="FileUpload2" runat="server" /><asp:Button ID="Button2" runat="server" Text="上傳" OnClick="Button1_Click" /><img src="/images/LOGO-m.png" />
            </div>
            <div class="space-4"></div>

            <div class="clearfix form-actions">
                <div class="col-md-offset-3 col-md-9">

                    <asp:Button runat="server" Text="更新內容" OnClick="update_Click" class="btn btn-info" type="button" ID="update" />
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

