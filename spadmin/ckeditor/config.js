/**
 * @license Copyright (c) 2003-2018, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function (config) {
    config.toolbarGroups = [
        { name: 'document', groups: ['mode', 'document', 'doctools'] },
        { name: 'clipboard', groups: ['clipboard', 'undo'] },
        { name: 'editing', groups: ['find', 'selection', 'spellchecker', 'editing'] },
        { name: 'forms', groups: ['forms'] },
        '/',
        { name: 'basicstyles', groups: ['basicstyles', 'cleanup'] },
        { name: 'paragraph', groups: ['list', 'indent', 'blocks', 'align', 'bidi', 'paragraph'] },
        { name: 'links', groups: ['links'] },
        { name: 'insert', groups: ['insert'] },
        { name: 'styles', groups: ['styles'] },
        { name: 'colors', groups: ['colors'] },
        { name: 'tools', groups: ['tools'] },
        { name: 'others', groups: ['others'] },
        { name: 'about', groups: ['about'] }
    ];
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