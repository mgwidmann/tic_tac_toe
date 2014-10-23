tic_tac_toe
===========

Console based tic-tac-toe game.

# Installation

To install, run the install command:

    npm install

# Tests

To run the test suite run the following command:

    npm test

This will watch the repository and rerun tests when they change. Hit Ctrl-C to exit.

# Playing the game

To start up the game, simply run the following command:

    npm start

## Example playing

    npm start

    > tic_tac_toe@1.0.0 start /Users/matt/code/node/tic_tac_toe
    > node main.js

    Welcome to TicTacToe!
      To see a list of commands type 'help', to exit type 'exit'
    TicTacToe>

Typing `help` or `exit` will perform those actions. The help screen looks like this:

    TicTacToe> help
    Below are the list of commands. To see more information, type 'help <command>'
        help              Shows this help prompt
        exit              Exit the game
        start <size>      Starts the game with the a board the size of <size>
        move <x> <y>      When in a game, makes a move at the <x>, <y> position

To start a game, you must first decide how big of a board you want to play on. All boards are perfect squares, so you only need enter one number. To start a new game, simply use the `start` command:

    TicTacToe> start 3
          1   2   3
       ╭───┭───┭───╮
    1  ┃ _ ┃ _ ┃ _ ┃
    2  ┃ _ ┃ _ ┃ _ ┃
    3  ┃ _ ┃ _ ┃ _ ┃
       ╰───┵───┵───╯
    TicTacToe>

Once started, you may use the `move` command to place a move. The `move` command takes its parameters seprated by spaces in the format `move x y`. To move to position (1,2) where X is 1 and Y is 2 (X being the horizontal axis and Y being the vertical axis), type the following:

    TicTacToe> move 1 2

You will see the CPU thinking for a brief moment, and then the board will be redrawn.

    Moving CPU to 2 2
          1   2   3
       ╭───┭───┭───╮
    1  ┃ _ ┃ X ┃ _ ┃
    2  ┃ _ ┃ O ┃ _ ┃
    3  ┃ _ ┃ _ ┃ _ ┃
       ╰───┵───┵───╯
    TicTacToe>

Continue making moves until either you or the CPU win the game!

    TicTacToe> move 1 3
    Of course, you beat the stupid computer... Start a new game with 'start 3'
          1   2   3
       ╭───┭───┭───╮
    1  ┃ X ┃ X ┃ X ┃
    2  ┃ _ ┃ O ┃ _ ┃
    3  ┃ _ ┃ O ┃ _ ┃
       ╰───┵───┵───╯
    TicTacToe>
