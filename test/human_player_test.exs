defmodule HumanPlayerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "makes a move on an empty board" do
    capture_io([input: "1"], fn ->
    assert HumanPlayer.make_move(Board.empty_board) == ["X",2,3,4,5,6,7,8,9]
    end)
  end
end
