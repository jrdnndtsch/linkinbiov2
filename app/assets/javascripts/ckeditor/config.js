CKEDITOR.editorConfig = function (config) {
  // ... other configuration ...

//   config.justifyClasses= ['AlignLeft', 'AlignCenter', 'AlignRight']
//   config.toolbar_mini = [
//     ['Bold',  'Italic',  'Underline', 'Blockquote', 'JustifyClasses', 'FontSize'],
//     ['AlignLeft', 'AlignCenter', 'AlignRight']
//   ];
//   config.toolbar = "mini";

    config.toolbar = [
            '/',
            { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline'] },
            // '/',
            // { name: 'justifyClasses', items: ['AlignLeft', 'AlignCenter', 'AlignRight'] },
            ['JustifyLeft','JustifyCenter','JustifyRight'],
            ['Blockquote', 'BulletedList', 'NumberedList'],
            ['Link'], 
            ['Maximize']
    ];
    config.uiColor = '#F0F0F5';
    config.linkShowAdvancedTab = false;
    config.linkShowTargetTab = false;
    config.magicline_color = '#C5E88E';
    config.removePlugins = 'elementspath';

    

}

