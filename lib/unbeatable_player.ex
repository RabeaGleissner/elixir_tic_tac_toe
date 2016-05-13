defmodule UnbeatablePlayer do

  @computer_mark "O"

  def score_for_move(board) do
    cond do
      Board.winning_mark(board) == @computer_mark ->
        1
      Board.winning_mark(board) == "X" ->
        -1
      Board.draw?(board) ->
        0
    end
  end
end
