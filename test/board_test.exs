defmodule BoardTest do
  use ExUnit.Case

  test "places a mark on an empty board" do
    assert Board.place_mark(1, [1,2,3,4,5,6,7,8,9]) == ["X",2,3,4,5,6,7,8,9]
  end

  test "returns next player mark" do
    assert Board.next_player_mark(["X",2,3,4,5,6,7,8,9]) == "O"
  end

  test "knows that it is a winning board" do
    assert Board.winner?([
      "X", "X", "X",
      "O", "O", 6,
       7,   8,  9
    ]) == true
  end

  test "knows that there is no winner" do
    assert Board.winner?([
      "X", "X", "O",
      "O", "O", 6,
       7,   8, "X"
    ]) == false
  end
end
