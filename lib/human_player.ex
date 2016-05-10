defmodule HumanPlayer do

  def make_move(board) do
    position = board
                |> Ui.ask_for_position
    {:ok, next_board } = Board.place_mark(board, position)
    next_board
  end
end
