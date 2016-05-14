defmodule UnbeatablePlayerTest do
  use ExUnit.Case

  test "assigns a 1 if the computer player wins" do
    assert UnbeatablePlayer.score_for_move([
      "O","O","O",
      "X","X", 6,
       7,  8,  9
    ], "O") == 1
  end

  test "assigns a -1 if the computer's opponent wins" do
    assert UnbeatablePlayer.score_for_move([
      "O","O", 3,
      "X","X","X",
       7,  8,  9
    ], "O") == -1
  end

  test "assigns a 0 if the game is a draw" do
    assert UnbeatablePlayer.score_for_move([
      "O","O","X",
      "X","X","O",
      "O","O","X"
    ], "O") == 0
  end

  test "picks the winning move out of two" do
    assert UnbeatablePlayer.make_move([
      "O","X","X",
      "X","O","O",
       7, "X", 9
    ], "O") == 9
  end

  test "makes a winning move for a diagonal win" do
    assert UnbeatablePlayer.make_move([
       "X","X",3,
       "X","O",6,
       "O","X",9
    ], "O") == 3
  end

  test "makes a winning move for a horizontal win" do
    assert UnbeatablePlayer.make_move([
       "X", 2,  3,
        4, "O","O",
       "X", 8, "X"
    ], "O") == 4
  end

  test "makes a winning move for a vertical win" do
    assert UnbeatablePlayer.make_move([
       "O", 2,  3,
       "X","O","O",
       "X","O","X"
    ], "O") == 2
  end

  test "blocks an opponents winning move" do
    assert UnbeatablePlayer.make_move([
       "X","O",3,
       "X", 5, 6,
       "O", 8,"X"
    ], "O") == 5
  end

  test "blocks opponent's fork" do
    assert UnbeatablePlayer.make_move([
       "X",2, 3,
        4,"O",6,
        7, 8,"X"
    ], "O") == 2
    #could also be 6, 4 or 8
  end

  test "creates a fork if possible" do
    assert UnbeatablePlayer.make_move([
        1, "X",3,
       "O", 5, 6,
       "X","X","O"
    ], "O") == 5
    #could also be 6
  end
end
