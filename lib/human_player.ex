defmodule HumanPlayer do

  def make_move(position, board) do
    Board.place_mark(position, board)
  end
end
