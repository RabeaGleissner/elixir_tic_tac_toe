defmodule RandomPlayer do

  def make_move(board) do
    position = board
                |> Board.available_positions
                |> Enum.random
                Board.place_mark(board, position)
  end
end
