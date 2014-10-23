readline = require('readline')
rl = readline.createInterface(process.stdin, process.stdout)
Board = require('../models/board')

module.exports =
  class CLI
    moveRegex = /^move\W(\d+)\W(\d+)\W*/
    startRegex = /^start\W(\d+)\W*/
    board = null

    @drawBoard = (board)->
      result = drawHeader(board)
      result = drawTopRow(result, board)
      result = drawContents(result, board)
      drawBottomRow(result, board)

    drawHeader = (board)->
      result = "     "
      # Numeric Header
      for x in [1..board.size]
        result += " #{x}  "
      result += "\n   "

    drawTopRow = (result, board)->
      # Top row
      for x in [1..board.size]
        if x == 1
          result += "╭───"
        else if x == board.size
          result += "┭───╮"
        else
          result += "┭───"
      result += "\n"

    drawContents = (result, board)->
      # Contents
      for x in [1..board.size]
        result += "#{x}  ┃"
        for y in [1..board.size]
          taken = board.taken(x,y)
          takenByPlayer = board.takenBy({x: x, y: y, cpu: false})
          token = if taken then (if takenByPlayer then "X" else "O") else "_"
          result += " #{token} ┃"
        result += "\n"
      result

    drawBottomRow = (result, board)->
      # Bottom row
      result += "   "
      for x in [1..board.size]
        if x == 1
          result += "╰───"
        else if x == board.size
          result += "┵───╯"
        else
          result += "┵───"
      result

    @getInput = ->
      console.log "Welcome to TicTacToe!"
      console.log "  To see a list of commands type 'help', to exit type 'exit'"
      rl.setPrompt('TicTacToe> ')
      rl.prompt()
      rl.on 'line', (line)->
        t = line.trim()
        switch true
          ###################### HELP ##########################
          when t == 'help'
            CLI.help()
            rl.prompt()
          when t == 'help help', t == 'help exit'
            console.log "Theres not much to explain here..."
            rl.prompt()
          when t == 'help start'
            console.log "Begins a game. All boards are perfect squares, and the board must be " +
              "larger than or equal to the size of 3. Once in a game, the move command is available."
            rl.prompt()
          when t == 'help move'
            console.log "Makes a move for you at the specified position. You cannot make moves off the board."
            rl.prompt()
          ###################### GAME ##########################
          when moveRegex.test(t)
            CLI.moveCmd(t)
          when startRegex.test(t)
            CLI.startCmd(t)
            rl.prompt()
          ##################### OTHER ##########################
          when t == 'exit'
            process.exit(0)
          else
            console.log('Apologies, but I am just a stupid computer and I cannot understand what that means.')
            rl.prompt()

    @moveCmd = (t)->
      m = moveRegex.exec(t)
      if board && board.playing
        CLI.movePlayer(m)
      else
        console.log "Please start a new game!"
        rl.prompt()

    @startCmd = (t)->
      s = startRegex.exec(t)
      boardSize = parseInt(s[1], 10)
      if boardSize >= 2 && boardSize <= 9
        board = new Board(boardSize)
        console.log CLI.drawBoard(board)
      else
        console.log "You cannot specify a board of size #{boardSize}"

    @moveToTopOfBoard = (numErrors)->
      readline.clearLine(process.stdout, 0) # Clear line
      readline.moveCursor(process.stdout, 0, -(board.size + 4 + numErrors)) # Move back up

    @redrawBoard = ->
      console.log CLI.drawBoard(board)

    @movePlayer = (m)->
      readline.clearLine(process.stdout, 0) # Clear line
      numErrors = board.errors.length # Previous action's error count
      board.errors = []
      board.move(parseInt(m[1], 10), parseInt(m[2], 10))
      if board.errors.length != 0
        CLI.moveToTopOfBoard(numErrors)
        for error in board.errors
          console.log error
        CLI.redrawBoard()
        rl.prompt()
      else if board.playing
        CLI.moveCPU(numErrors)
      else
        CLI.redrawBoard()
        rl.prompt()

    @moveCPU = (numErrors)->
      CLI.moveToTopOfBoard(numErrors)
      CLI.redrawBoard()
      console.log "* CPU Thinking... *"
      setTimeout((->
        readline.moveCursor(process.stdout, 0, -1) # Move up one line
        readline.clearLine(process.stdout, 0) # Clear line
        # Coffeescript has no do while...
        do_until = true
        count = 0
        while do_until
          board.errors = []
          x = Math.floor(Math.random() * board.size) + 1
          y = Math.floor(Math.random() * board.size) + 1
          board.move(x, y, true)
          count++
          do_until = board.errors.length > 0 && (board.size * board.size + 10 < count)
        CLI.moveToTopOfBoard(numErrors - 1)
        readline.clearLine(process.stdout, 0) # Clear line
        console.log "Moving CPU to #{x} #{y}"

        CLI.redrawBoard(0)
        rl.prompt()
      ), 1000)

    @help = ->
      console.log """
      Below are the list of commands. To see more information, type 'help <command>'
          help              Shows this help prompt
          exit              Exit the game
          start <size>      Starts the game with the a board the size of <size>
          move <x> <y>      When in a game, makes a move at the <x>, <y> position
      """
