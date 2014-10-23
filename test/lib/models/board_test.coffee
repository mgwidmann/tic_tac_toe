sinon = require('sinon')
Board = require('../../../lib/models/board')

describe 'Board', ->

  describe '#new', ->

    it 'can make a new Board', ->
      new Board()

    it 'can pass in a size', ->
      new Board(5)

    it 'can access the size later', ->
      (new Board(5)).size.should.eql(5)

  describe '#move', ->

    board = null
    beforeEach ->
      board = new Board()

    it 'can make a move', ->
      board.move(1,1)

    it 'cannot move out of bounds for X above the size', ->
      board.move(10,1)
      board.errors.should.eql(['The X value of 10 is out of bounds.'])

    it 'cannot move out of bounds for X at zero', ->
      board.move(0,1)
      board.errors.should.eql(['The X value of 0 is out of bounds.'])

    it 'cannot move out of bounds for X below zero', ->
      board.move(-1,1)
      board.errors.should.eql(['The X value of -1 is out of bounds.'])

    it 'cannot move out of bounds for Y above the size', ->
      board.move(1,10)
      board.errors.should.eql(['The Y value of 10 is out of bounds.'])

    it 'cannot move out of bounds for Y at zero', ->
      board.move(1,0)
      board.errors.should.eql(['The Y value of 0 is out of bounds.'])

    it 'cannot move out of bounds for Y below zero', ->
      board.move(1,-1)
      board.errors.should.eql(['The Y value of -1 is out of bounds.'])

    it 'updates the board', ->
      board.move(1,1)

    it 'returns available moves', ->
      board.move(1,1)
      board.moves.should.eql([{x: 1, y: 1, cpu: false}])

    it 'does not allow moving to an already taken spot', ->
      board.move(1,1)
      board.move(1,1)
      board.errors.should.eql(['You cannot move there.'])
      board.moves.should.eql([{x: 1, y: 1, cpu: false}])

  describe '#win', ->

    board = null
    beforeEach ->
      board = new Board()

    describe 'winning', ->

      it 'calls #win when a player wins vertically', ->
        board.move(1,1)
        board.move(1,2)
        sinon.spy(board, "win")
        board.move(1,3)
        board.win.calledOnce.should.be.true

      it 'calls #win when a player wins horizontally', ->
        board.move(1,1)
        board.move(2,1)
        sinon.spy(board, "win")
        board.move(3,1)
        board.win.calledOnce.should.be.true

      it 'calls #win when a player wins diagonally', ->
        board.move(1,1)
        board.move(2,2)
        sinon.spy(board, "win")
        board.move(3,3)
        board.win.calledOnce.should.be.true

      it 'calls #win when a player wins anti-diagonally', ->
        board.move(3,1)
        board.move(2,2)
        sinon.spy(board, "win")
        board.move(1,3)
        board.win.calledOnce.should.be.true

    describe 'losing', ->

      it 'does not call #win when the cpu makes the winning move vertically', ->
        board.move(1,1)
        board.move(1,2)
        sinon.spy(board, "win")
        board.move(1,3, true)
        board.win.calledOnce.should.be.false

      it 'does not call #win when the cpu makes the winning move horizontally', ->
        board.move(1,1)
        board.move(2,1)
        sinon.spy(board, "win")
        board.move(3,1, true)
        board.win.calledOnce.should.be.false

      it 'does not call #win when the cpu makes the winning move diagonally', ->
        board.move(1,1)
        board.move(2,2)
        sinon.spy(board, "win")
        board.move(3,3, true)
        board.win.calledOnce.should.be.false

      it 'does not call #win when the cpu makes the winning move anti-diagonally', ->
        board.move(3,1)
        board.move(2,2)
        sinon.spy(board, "win")
        board.move(1,3, true)
        board.win.calledOnce.should.be.false
