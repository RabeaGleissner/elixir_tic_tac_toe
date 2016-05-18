defmodule HumanPlayer do

  def make_move(board) do
    position = board
                |> Ui.ask_for_position
                Board.place_mark(board, position)
  end
end
