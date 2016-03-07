require! \commander

query = (value, terms) ->
    terms.push value

commander
    .option '-d', '--description <phrase>', query, []
    .option '-t', '--thread <keyword>', query, []

commander
    .parse process.argv
