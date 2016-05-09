defmodule RandomPlayer do

  def make_move(board) do
    position = board
                |> Board.available_positions
                |> Enum.random
    {:ok, next_board } = Board.place_mark(board, position)
    next_board
  end
end
