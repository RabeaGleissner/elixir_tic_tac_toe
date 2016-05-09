defmodule HumanPlayer do

  def make_move(position, board) do
    {:ok, next_board } = Board.place_mark(position, board)
    next_board
  end
end
