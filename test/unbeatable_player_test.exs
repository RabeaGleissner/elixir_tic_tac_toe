defmodule UnbeatablePlayerTest do
  use ExUnit.Case

  test "assigns a 1 if the computer player wins" do
    assert UnbeatablePlayer.score_for_move([
      "O","O","O",
      "X","X", 6,
       7,  8,  9
    ]) == 1
  end

  test "assigns a -1 if the computer's opponent wins" do
    assert UnbeatablePlayer.score_for_move([
      "O","O", 3,
      "X","X","X",
       7,  8,  9
    ]) == -1
  end

  test "assigns a 0 if the game is a draw" do
    assert UnbeatablePlayer.score_for_move([
      "O","O","X",
      "X","X","O",
      "O","O","X"
    ]) == 0
  end
end
