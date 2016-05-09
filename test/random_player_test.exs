defmodule RandomPlayerTest do
  use ExUnit.Case

  test "makes a random move on the board" do
    board = ["X","O","X",4,5,6,7,8,9]
    :rand.seed(:exsplus, {1, 2, 3})
    assert ["X", "O", "X", 4, 5, 6, 7, "O", 9] == RandomPlayer.make_move(board)
  end
end
