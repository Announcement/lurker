require! <[commander]>

commander
    .version '1.0.1'
    .option '-n, --nsfw', 'disables filters on explicit content'
    .option '-s, --secure', 'enable hyper text transfer protocol secure (using: secure socket layer)'
    .option '-c, --color [when]', 'colorize the output', 'auto'

# always never auto errors

commander
    .command 'channel', 'browse a channel\'s catalog', {+isDefault}
    .alias 'chan'

commander
    .command 'watch', 'look at or observe attentively, typically over a period of time'
    .command 'search', 'try to find something by looking or otherwise seeking carefully and thoroughly'
    .parse process.argv

global.secure = commander.secure || false
global.color = commander.color
global.nsfw = commander.nsfw
