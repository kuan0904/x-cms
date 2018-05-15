/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
    //config.uiColor = '#AADC6E';
    //config.skin = 'kama';
    config.toolbar = 'Full';    
    config.toolbar_Full = [
       ['Source','-','Save','NewPage','Preview','-','Templates'],
       ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
       ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
       ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
       '/',
       ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
        ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
        ['Link','Unlink','Anchor'],
       ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
       '/',
        ['Styles','Format','Font','FontSize'],
        ['TextColor','BGColor']
    ];

    config.removeButtons = 'Subscript,Superscript,Form,Checkbox,Radio,Save,NewPage,Templates';
    config.allowedContent = true;
    config.extraAllowedContent = 'style script';
    //下面是增加的配置代码  
    config.filebrowserBrowseUrl = '../../spadmin/ckfinder/ckfinder.html';
    config.filebrowserImageBrowseUrl = '../../spadmin/ckfinder/ckfinder.html?type=Images';
    config.filebrowserUploadUrl = '../../spadmin/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Files';
    config.filebrowserImageUploadUrl = '../../spadmin/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Images';
  
    
};
