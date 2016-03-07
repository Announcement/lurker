require! <[http chalk]>

protocol = if (global.secure) then 'https' else 'http'

domain = 'a.4cdn.org'

sources =
    boards: 'boards'

    catalog: '%b/catalog'
    page: '%b/%n'

    threads: '%b/threads'
    thread: '%b/thread/%t'

    archive: '%b/archive'

compliment = (object) ->
    reverse = {}
    for own let key, value of object
        reverse[value] = key
    reverse

alias =
    "%b": "board"
    "%n": "page"
    "%t": "thread"

saila = compliment alias

callback = (res) !->
    res.set-encoding 'utf8'

    data = ""

    res.on \data, (chunk) !->
        data := data + chunk;

    res.on \end , !->
        data := JSON.parse data
        beautify data

print = ->
    console.log.apply console, &

reference-to = (source) ->
    if source.index-of('/') is 0 then source .= substring 1
    "#{protocol}://#{domain}/#{source}.json"

make = (source='boards', {board, page, thread}) ->
    path = sources[source]

    if board then path .= replace saila.board, board
    if page then path .= replace saila.page, page
    if thread then path .= replace saila.thread, thread

    path = path.replace /\%./g, ->
        if global.color then chalk.blue alias[it] else alias[it]


    config =
        hostname: domain,
        port: 80,
        path: "/#{path}.json"
        agent: no

fetch = (config, callback) ->
    handler = (res) ->
        res.setEncoding 'utf8'

        data = ""

        res.on \data, (chunk) !->
            data := data + chunk;
            #console.log chunk

        res.on \end , !->
            callback JSON.parse data

    http.get config, handler

exports.make = make
exports.fetch = fetch
exports.print = print
exports.reference = reference-to
# http.get config, callback

# where %b is BOARD
# where %n is PAGE
# where %t is THREAD

# http(s)://a.4cdn.org/board/thread/threadnumber.json
# http(s)://a.4cdn.org/board/pagenumber.json
# http(s)://a.4cdn.org/board/catalog.json
# http(s)://a.4cdn.org/board/threads.json
# http(s)://a.4cdn.org/board/archive.json
# http(s)://a.4cdn.org/boards.json
