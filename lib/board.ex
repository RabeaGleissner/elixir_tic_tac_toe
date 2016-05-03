defmodule Board do

  def place_mark(mark, position, board) do
    List.replace_at(board, position - 1, mark)
  end

  def next_player_mark(board) do
    x_count = count_mark("X", board)
    o_count = count_mark("O", board)
    if x_count < o_count do
      "X"
    else
      "O"
    end
  end

  def count_mark(mark, board) do
    Enum.count(board, fn(x) -> x == mark end)
  end
end
