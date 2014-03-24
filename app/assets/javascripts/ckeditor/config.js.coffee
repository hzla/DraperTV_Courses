CKEDITOR.editorConfig = (config) ->
  config.language = "en"
  config.height = "200"
  config.toolbar_Pure = [
    { name: 'document',    items: [ 'Templates' ] },
    { name: 'clipboard',   items: [ 'Cut','Copy','Paste','-','Undo','Redo' ] },
    { name: 'editing',     items: [ 'SelectAll','-','SpellChecker', 'Scayt' ] },
    { name: 'tools',       items: [ 'Maximize', 'ShowBlocks','-' ] }
    { name: 'basicstyles', items: [ 'Bold','Italic','Underline' ] },
    { name: 'paragraph',   items: [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
    { name: 'links',       items: [ 'Link','Unlink' ] },
    '/',
    { name: 'styles',      items: [ 'Styles','Format','Font','FontSize' ] },
    { name: 'colors',      items: [ 'TextColor','BGColor' ] },
    { name: 'insert',      items: [ 'Image', 'Table','HorizontalRule','Smiley','SpecialChar' ] },
  ]
  config.toolbar = 'Pure'
  true