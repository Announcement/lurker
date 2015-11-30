#
local = './'
require! {
    commander: \program
    './helper': \helper
    './clean': \pretty
}
start = new Date!
program.parse(process.argv);
goal = program.args[0]
process.exit(1) unless goal
#module.exports = ->
    #watch.apply this, program.args

#watch = (number) ->
#    return unless number

#    for board in boards
#        for thread in threads
#            if thread.no is number
#                read {board, thread}

make = helper.make
fetch = helper.fetch
print = helper.print

config_board = make 'boards', {}
#print helper.reference config_board.path

scan-queue = []

fetch config_board, ->
    boards = it.boards

    for board in boards
        scan-queue.push board
    seconds = scan-queue.length * 10
    minutes = Math.floor seconds / 60
    seconds = seconds % 60
    #console.log "This task will take a maximum of #{minutes} minutes, #{seconds} seconds."
    fetch-threads!
delay = new Date!
target = {}
fetch-threads = ->
    return unless scan-queue.length
    current = scan-queue.shift!
    config_threads = make 'threads', board: current.board
    delay = new Date!
    fetch config_threads, ->
        now = new Date!
        #console.log "Board #{current.board}"
        for page in it
            for thread in page.threads
                if thread.no ~= goal
                    #print "Found thread on #{current.board} page #{page.page}"
                    target := {board: current.board, thread: goal}
                    fetch-thread!
                    scan-queue := []
                    return
        set-timeout fetch-threads, Math.max(now - delay, 1000)


fetch-thread = ->
    now = new Date!
    seconds = now - start
    config_thread = make 'thread', board: target.board, thread: target.thread
    fetch config_thread, ->
        pretty.show- nthread it
    #print "that threa d has been found in #{seconds}"

#boards =
#    config = make 'page', board: 'b', page: 1
#    print reference-to config.path

# http(s)://a.4cdn.org/board/thread/threadnumber.json
# http(s)://a.4cdn.org/board/pagenumber.json
# http(s)://a.4cdn.org/board/catalog.json
# http(s)://a.4cdn.org/board/threads.json
# http(s)://a.4cdn.org/board/archive.json
# http(s)://a.4cdn.org/boards.json
