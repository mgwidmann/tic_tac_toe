module.exports =
  class Board
    constructor: (@size = 3) ->
      @moves = []
      @errors = []
      @playing = true

    move: (x, y, isCpu = false) ->
      if @playing
        move = {x: x, y: y, cpu: isCpu}
        @moveWithinBounds(move)
        @moveTaken(move)
        if @errors.length == 0
          @moves.push({x: x, y: y, cpu: isCpu})
          @checkWinner(move)

    vertical: (move)->
      result = true
      for y in [1..@size]
        unless @takenBy({x: move.x, y: y, cpu: move.cpu})
          result = false
          break
      result

    horizontal: (move)->
      result = true
      for x in [1..@size]
        unless @takenBy({x: x, y: move.y, cpu: move.cpu})
          result = false
          break
      result

    diagonal: (move)->
      result = true
      for d in [1..@size]
        unless @takenBy({x: d, y: d, cpu: move.cpu})
          result = false
          break
      result

    antiDiagonal: (move)->
      result = true
      for d in [1..@size]
        unless @takenBy({x: @size + 1 - d, y: d, cpu: move.cpu})
          result = false
          break
      result

    checkWinner: (move)->
      if @vertical(move) || @horizontal(move) || @diagonal(move) || @antiDiagonal(move)
        @win(move.cpu)

    moveTaken: (move)->
      if @taken(move.x, move.y)
        @errors.push "You cannot move there."
      @errors.length == 0

    moveWithinBounds: (move) ->
      for type, val of {X: move.x, Y: move.y}
        if val > @size || val <= 0
          @errors.push "The #{type} value of #{val} is out of bounds."
      @errors.length == 0

    taken: (x,y) ->
      for m in @moves
        if m.x == x && m.y == y
          found = true
          break
      found

    takenBy: (move)->
      isCpu = false
      for m in @moves
        if m.x == move.x && m.y == move.y
          isCpu = move.cpu == m.cpu
          break
      isCpu

    win: (isCpu)->
      @playing = false
      if isCpu
        console.log "OH NOES! The CPU has beat you!"
      else
        console.log "Of course, you beat the stupid computer... Start a new game with 'start #{@size}'"
