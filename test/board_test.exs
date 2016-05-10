defmodule BoardTest do
  use ExUnit.Case

  test "returns an empty board" do
    board = Board.empty_board
    assert !Board.board_full?(board)
  end

  test "places mark on empty board" do
    assert Board.place_mark([1,2,3,4,5,6,7,8,9], 1) == {:ok, ["X",2,3,4,5,6,7,8,9]}
  end

  test "cannot place mark in a position that is taken" do
    assert Board.place_mark(["X",2,3,4,5,6,7,8,9], 1) == {:taken, 1}
  end

  test "returns next player's mark" do
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

  test "returns winning mark X" do
    assert Board.winning_mark([
      "X","X","X",
      "O","O", 6,
       7,  8,  9
    ]) == "X"
  end

  test "returns winning mark O" do
    assert Board.winning_mark([
      "O",  2,  3,
      "X", "O", 6,
      "X", "X","O"
    ]) == "O"
  end

  test "knows that board is a draw" do
    assert Board.draw?([
      "O", "X", "O",
      "O", "X", "X",
      "X", "O", "O"
    ]) == true
  end

   test "knows that game is over" do
    assert Board.game_over?([
      "O", "X", "O",
      "O", "X", "X",
      "X", "O", "O"
    ]) == true
   end

   test "board is empty" do
     assert Board.board_full?([1,2,3,4,5,6,7,8,9]) == false
   end

  test "knows that the position is unavailable" do
    assert Board.position_available?([
      "O",  2,  3,
      "X", "O", 6,
      "X", "X","O"
    ], 1) == {:taken, 1}
  end

  test "knows that the position is available" do
    assert Board.position_available?([
      "O",  2,  3,
      "X", "O", 6,
      "X", "X","O"
    ], 2) == {:valid, 2}
  end

  test "returns all available positions" do
    assert Board.available_positions([
      "O",  2,  3,
      "X", "O", 6,
      "X", "X","O"
    ]) == [2,3,6]
  end
end
