require! \commander

commander
    .option '-p', '--page', 'browse by given page at a time'
    .parse process.argv


console.log commander.args
/*
'board',
  'title',
  'ws_board',
  'per_page',
  'pages',
  'max_filesize',
  'max_webm_filesize',
  'max_comment_chars',
  'bump_limit',
  'image_limit',
  'cooldowns',
  'meta_description',
  'is_archived'*/
