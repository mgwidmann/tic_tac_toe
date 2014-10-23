Board = require('../../../lib/models/board')
CLI = require('../../../lib/interface/cli')

describe 'CLI', ->

  describe '#drawBoard', ->

    board = null
    beforeEach ->
      board = new Board()

    it 'draws an empty 3x3 board', ->
      CLI.drawBoard(board).should.eql "" +
      "      1   2   3  \n" + # Editor autmatically removes whitespace, so no heredocs
      "   ╭───┭───┭───╮\n" +
      "1  ┃ _ ┃ _ ┃ _ ┃\n" +
      "2  ┃ _ ┃ _ ┃ _ ┃\n" +
      "3  ┃ _ ┃ _ ┃ _ ┃\n" +
      "   ╰───┵───┵───╯"

    it 'draws a 3x3 board with a move in the middle', ->
      board.move(2,2)
      CLI.drawBoard(board).should.eql "" +
      "      1   2   3  \n" + # Editor autmatically removes whitespace, so no heredocs
      "   ╭───┭───┭───╮\n" +
      "1  ┃ _ ┃ _ ┃ _ ┃\n" +
      "2  ┃ _ ┃ X ┃ _ ┃\n" +
      "3  ┃ _ ┃ _ ┃ _ ┃\n" +
      "   ╰───┵───┵───╯"

    it 'draws a 5x5 board with 3 moves', ->
      board = new Board(5)
      board.move(1,1)
      board.move(3,3)
      board.move(5,5)
      CLI.drawBoard(board).should.eql "" +
      "      1   2   3   4   5  \n" + # Editor autmatically removes whitespace, so no heredocs
      "   ╭───┭───┭───┭───┭───╮\n" +
      "1  ┃ X ┃ _ ┃ _ ┃ _ ┃ _ ┃\n" +
      "2  ┃ _ ┃ _ ┃ _ ┃ _ ┃ _ ┃\n" +
      "3  ┃ _ ┃ _ ┃ X ┃ _ ┃ _ ┃\n" +
      "4  ┃ _ ┃ _ ┃ _ ┃ _ ┃ _ ┃\n" +
      "5  ┃ _ ┃ _ ┃ _ ┃ _ ┃ X ┃\n" +
      "   ╰───┵───┵───┵───┵───╯"

    it 'does not allow access to the drawHeader function', ->
      (->
        CLI.drawHeader(board)
      ).should.throw("Object function CLI() {} has no method 'drawHeader'")

    it 'does not allow access to the drawTopRow function', ->
      (->
        CLI.drawTopRow("", board)
      ).should.throw("Object function CLI() {} has no method 'drawTopRow'")

    it 'does not allow access to the drawContents function', ->
      (->
        CLI.drawContents("", board)
      ).should.throw("Object function CLI() {} has no method 'drawContents'")

    it 'does not allow access to the drawBottomRow function', ->
      (->
        CLI.drawBottomRow("", board)
      ).should.throw("Object function CLI() {} has no method 'drawBottomRow'")
