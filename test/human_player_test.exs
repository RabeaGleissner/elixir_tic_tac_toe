defmodule HumanPlayerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "it makes a move on an empty board" do
    empty_board = [1,2,3,4,5,6,7,8,9]
    capture_io([input: "1"], fn ->
    assert HumanPlayer.make_move(empty_board) == ["X",2,3,4,5,6,7,8,9]
    end)
  end
end
