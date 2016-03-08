chai = require 'chai'
assert = chai.assert
expect = chai.expect
should = chai.should()

describe 'Fresh', ->
    fresh = require '../drink/fresh'

    describe '#drink', ->
        it 'should be a filled object beverage', ->
            fresh.drink.should.to.be.ok
            fresh.drink.should.to.be.an 'object'

    describe '#beans', ->
        it 'should construct the api requests for the boards', ->
            beans.should.
            expect(generate('boards', {})).to.equal('boards')

    describe "#generate(catalog)", ->
        generate = brew.generate

        it 'should construct the api request for the catalog', ->
            expect(generate('catalog', {board: 'b'})).to.equal('b/catalog')

    describe "#generate(page)", ->
        generate = brew.generate

        it 'should construct the api request for the page', ->
            expect(generate('page', {board: 'b', page: 1})).to.equal('b/1')

    describe "#generate(threads)", ->
        generate = brew.generate

        it 'should construct the api request for the threads', ->
            expect(generate('threads', {board: 'b'})).to.equal('b/threads')

    describe "#generate(thread)", ->
        generate = brew.generate
        config = {board: 'b', thread: 1}

        it 'should construct the api request for the thread', ->
            expect(generate('thread', config)).to.equal('b/thread/1')

    describe "#generate(archive)", ->
        generate = brew.generate

        it 'should construct the api request for the archive', ->
            expect(generate('archive', {board: 'b'})).to.equal('b/archive')
