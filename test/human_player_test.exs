defmodule HumanPlayerTest do
  use ExUnit.Case

  test "it makes a move on an empty board" do
    empty_board = [1,2,3,4,5,6,7,8,9]
    assert HumanPlayer.make_move(empty_board, 1) == ["X",2,3,4,5,6,7,8,9]
  end
end
