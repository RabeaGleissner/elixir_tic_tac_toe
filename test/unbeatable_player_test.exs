defmodule UnbeatablePlayerTest do
  use ExUnit.Case

  test "assigns a 1 if it is a winning board" do
    assert UnbeatablePlayer.score([
      "O","O","O",
      "X","X", 6,
       7,  8,  9
    ], 4) == -5
  end

  test "assigns a 0 if the game is a draw" do
    assert UnbeatablePlayer.score([
      "O","O","X",
      "X","X","O",
      "O","O","X"
    ], 0) == 0
  end

  test "picks the winning move out of two" do
    next_board = UnbeatablePlayer.make_move([
      "X","O","X",
       4, "O","O",
      "X","X", 9
    ])
    assert Board.position_available?(next_board, 4) == {:taken, 4}
  end

  test "makes a winning move for a diagonal win" do
    assert 3 == UnbeatablePlayer.calculate_move([
       "X","X",3,
       "X","O",6,
       "O","X",9
    ])
  end

  test "makes a winning move for a horizontal win" do
    assert 4 == UnbeatablePlayer.calculate_move([
       "X", 2,  3,
        4, "O","O",
       "X", 8, "X"
    ])
  end

  test "makes a winning move for a vertical win" do
    assert 2 == UnbeatablePlayer.calculate_move([
       "O", 2,  3,
       "X","O","O",
       "X","O","X"
    ])
  end

  test "blocks an opponents winning move" do
    assert 5 == UnbeatablePlayer.calculate_move([
       "X","O",3,
       "X", 5, 6,
       "O", 8,"X"
    ])
  end

  test "blocks opponent's fork" do
    assert 2 == UnbeatablePlayer.calculate_move([
       "X",2, 3,
        4,"O",6,
        7, 8,"X"
    ])
  end

  test "creates a fork if possible" do
    assert 5 == UnbeatablePlayer.calculate_move([
        1, "X",3,
       "O", 5, 6,
       "X","X","O"
    ])
  end
end
