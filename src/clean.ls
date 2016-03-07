require! <[fs chalk]>

#thread = fs.read-file-sync 'thread.json'
#thread = JSON.parse thread


print = ->
    console.log.apply console, &

beautify-comment = (comment) ->
    url = /((http|ftp)s?\:\/\/)(\w+\.){1,}[a-z]{2,}(\/\S*)*/gi
    comment = comment.replace(/<br\s*\/?>/g, '\n')
    comment = comment.replace(/<[^>]+>/g, '')
    comment = comment.replace(/&gt;/g, '>')
    comment = comment.replace(/&lt;/g, '<')
    comment = comment.replace(/&quot;/g, '"')

    comment = comment.replace /&#([0-9]{1,3});/g, ->
         String.fromCharCode parseInt &1

    comment = comment.replace /^>[^>].+$/gim, ->
        chalk.green it

    comment = comment.replace />>\d+/gim, ->
        chalk.yellow.bold it

    comment = comment.replace url, ->
        chalk.blue it

    comment

display-header = ->
    now = new Date!

    time = new Date(it.tim)

    if time.to-string! is "Invalid Date" then time = new Date(it.now)
    else time = it.now
    print chalk.gray("@" + it.no) + ' ' + it.name + ' ' + chalk.gray time

file-name = ->
    print chalk.red it.filename + it.ext

show-post = (post) ->
        display-header post

        file-name post if post.filename
        print beautify-comment post.com if post.com
        print ''

show-thread = (thread) ->
    for post in thread.posts
        show-post post

exports.show-thread = show-thread

beautify-boards = (data) ->
    #print chalk.yellow.underline 'boards'
    for let v in data.boards
        rows[v.board] = {pages: v.pages, length: v.per_page}
        if not commander.nsfw and v.ws_board is 0 then
            return
        unless not commander.board or commander.board is v.board then
            return
        #    return
        #if v.board is commander.board then
        print!
        print "/#{v.board}/", ' - ', chalk.blue v.title
        print chalk.gray repair v.meta_description
    #for own let value, key of data do
    #    console.log(chalk.red(key) + chalk.yellow(value));

repair = (description) ->
    description.replace /&quot;.+?&quot; is\s*/, ''
        .replace /^(4chan's|a|international)\s*/m, ''
        .replace /^(image)?board\s*/m, ''
        .replace /\.$/m, ''

exports.show-boards = beautify-boards
