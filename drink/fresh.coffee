# generator utility

sources = {
    boards: 'boards'

    catalog: '%b/catalog'
    page: '%b/%n'

    threads: '%b/threads'
    thread: '%b/thread/%t'

    archive: '%b/archive'
}

synonyms = {
    board: '%b'
    page: '%n'
    thread: '%t'
}

generate = (source = 'boards', {board, page, thread}) ->
    source = sources[source]

    for key, value of _arg
        source = source.replace synonyms[key], value

    source

exports.generate = generate
exports.sources = sources

# where %b is BOARD
# where %n is PAGE
# where %t is THREAD

# http(s)://a.4cdn.org/board/thread/threadnumber.json
# http(s)://a.4cdn.org/board/pagenumber.json
# http(s)://a.4cdn.org/board/catalog.json
# http(s)://a.4cdn.org/board/threads.json
# http(s)://a.4cdn.org/board/archive.json
# http(s)://a.4cdn.org/boards.json
