defmodule BoardTest do
  use ExUnit.Case

  @empty_3_by_3_board Board.empty_board
  @empty_4_by_4_board Board.empty_board(4)

  test "returns an empty board" do
    refute Board.board_full?(Board.empty_board)
  end

  test "3x3 board has 9 cells" do
    assert length(Board.empty_board(3)) == 9
  end

  test "4x4 board has 16 cells" do
    assert length(Board.empty_board(4)) == 16
  end

  test "places mark on empty board" do
    assert Board.place_mark(@empty_3_by_3_board, 1) == ["X",2,3,4,5,6,7,8,9]
  end

  test "cannot place mark in a position that is taken" do
    assert Board.place_mark(["X",2,3,4,5,6,7,8,9], 1) == {:taken, 1}
  end

  test "returns next player's mark" do
    assert Board.next_player_mark(["X",2,3,4,5,6,7,8,9]) == "O"
  end

  test "returns all lines of the current game state" do
    assert Board.current_lines([
      "X", "X", "X",
      "O", "O", 6,
       7,   8, 9
    ]) == [["X", "X", "X"], ["O", "O", 6], [7,8,9], ["X", "O", 7], ["X", "O", 8], ["X", 6, 9], ["X", "O", 9], ["X", "O", 7]]
  end

  test "knows that it is a winning 3x3 board" do
    assert Board.winner?([
      "X", "X", "X",
      "O", "O", 6,
       7,   8,  9
    ])
  end

  test "knows that it is a winning 4x4 board" do
    assert Board.winner?([
      "X","O","O","O",
       5, "X", 7,  8,
       9,  10,"X",12,
       13, 14, 15,"X"
    ])
  end

  test "knows that there is no winner" do
    refute Board.winner?([
      "X", "X", "O",
      "O", "O", 6,
       7,   8, "X"
    ])
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
    ])
  end

   test "knows that game is over" do
    assert Board.game_over?([
      "O", "X", "O",
      "O", "X", "X",
      "X", "O", "O"
    ])
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
