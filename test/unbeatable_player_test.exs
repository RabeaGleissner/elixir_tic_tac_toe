defmodule UnbeatablePlayerTest do
  use ExUnit.Case

  test "assigns a 1 if the computer player wins" do
    assert UnbeatablePlayer.score([
      "O","O","O",
      "X","X", 6,
       7,  8,  9
    ], "O", 6) == 6
  end

  test "assigns a -1 if the computer's opponent wins" do
    assert UnbeatablePlayer.score([
      "O","O", 3,
      "X","X","X",
       7,  8,  9
    ], "O", 6) == -6
  end

  test "assigns a 0 if the game is a draw" do
    assert UnbeatablePlayer.score([
      "O","O","X",
      "X","X","O",
      "O","O","X"
    ], "O", 0) == 0
  end

  test "picks the winning move out of two" do
    assert 4 == UnbeatablePlayer.make_move([
      "X","O","X",
       4, "O","O",
      "X","X", 9
    ], "O")
    #assert Board.position_available?(next_board, 9) == {:taken, 9}
  end

  test "makes a winning move for a diagonal win" do
    assert 3 == UnbeatablePlayer.make_move([
       "X","X",3,
       "X","O",6,
       "O","X",9
    ], "O")
    #assert Board.position_available?(next_board, 3) == {:taken, 3}
  end

  test "makes a winning move for a horizontal win" do
    assert 4 == UnbeatablePlayer.make_move([
       "X", 2,  3,
        4, "O","O",
       "X", 8, "X"
    ], "O")
    #assert Board.position_available?(next_board, 4) == {:taken, 4}
  end

  test "makes a winning move for a vertical win" do
    assert 2 == UnbeatablePlayer.make_move([
       "O", 2,  3,
       "X","O","O",
       "X","O","X"
    ], "O")
    #assert Board.position_available?(next_board, 2) == {:taken, 2}
  end

  test "blocks an opponents winning move" do
    assert 5 == UnbeatablePlayer.make_move([
       "X","O",3,
       "X", 5, 6,
       "O", 8,"X"
    ], "O")
    #assert Board.position_available?(next_board, 5) == {:taken, 5}
  end

  test "blocks opponent's fork" do
    assert 2 == UnbeatablePlayer.make_move([
       "X",2, 3,
        4,"O",6,
        7, 8,"X"
    ], "O")
    #assert Board.position_available?(next_board, 2) == {:taken, 2}
  end

  test "creates a fork if possible" do
    assert 5 == UnbeatablePlayer.make_move([
        1, "X",3,
       "O", 5, 6,
       "X","X","O"
    ], "O")
    #assert Board.position_available?(next_board, 5) == {:taken, 5}
  end
end
