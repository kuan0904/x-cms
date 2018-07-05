/**
 * @license Copyright (c) 2003-2018, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */


CKEDITOR.editorConfig = function (config) {

    config.fontSize_sizes = 'x0.8/0.8em;x0.9/0.9em;x1/1em;x1.2/1.2em;x1.4/1.4em;x1.6/1.6em;x1.8/1.8em;x2/2em;x2.58/2.5em;x3/3em;x4/4em;';
    config.font_names = '新細明體;細明體;標楷體;微軟正黑體;Arial;Arial Black;Comic Sans MS;Courier New;Tahoma;Times New Roman;Verdana';
    config.colorButton_colors =
        '000,800000,8B4513,2F4F4F,008080,000080,4B0082,696969,' +
        'B22222,A52A2A,DAA520,006400,40E0D0,0000CD,800080,808080,' +
        'F00,FF8C00,FFD700,008000,0FF,00F,EE82EE,A9A9A9,' +
        'FFA07A,FFA500,FFFF00,00FF00,AFEEEE,ADD8E6,DDA0DD,D3D3D3,' +
        'FFF0F5,FAEBD7,FFFFE0,F0FFF0,F0FFFF,F0F8FF,E6E6FA,FFF';
    config.filebrowserBrowseUrl = '../../spadmin/ckfinder/ckfinder.html';
    config.filebrowserImageBrowseUrl = '../../spadmin/ckfinder/ckfinder.html?type=Images';
    config.filebrowserUploadUrl = '../../spadmin/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Files';
    /*  config.filebrowserImageUploadUrl = '../../spadmin/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Images';*/
    config.filebrowserImageUploadUrl = '../../spadmin/saveMultiUpload.aspx?kind=QuickUpload&type=Images&responseType=json';
    config.filebrowserWindowWidth = '800';  //“瀏覽服務器”彈出框的size設置
    config.filebrowserWindowHeight = '500';
    config.contentsCss = ['/css/theme.css'];
    config.extraPlugins = 'templates';
    config.htmlEncodeOutput = true;
    config.allowedContent = true;
    config.extraAllowedContent = 'style script';
    config.height = '700px'; //可以這樣寫
    config.width = 1000; //也可以這樣寫


};