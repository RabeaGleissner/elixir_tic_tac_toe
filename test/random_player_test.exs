defmodule RandomPlayerTest do
  use ExUnit.Case

  test "it returns any available position" do
    board = ["X","O","X",4,5,6,7,8,9]
    :rand.seed(:exsplus, {1, 2, 3})
    assert {:ok, ["X", "O", "X", 4, 5, 6, 7, "O", 9]} == RandomPlayer.make_move(board)
  end
end
