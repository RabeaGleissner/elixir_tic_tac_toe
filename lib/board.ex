defmodule Board do

  @winning_combinations [{0,1,2}, {3,4,5}, {6,7,8}]

  def place_mark(position, board), do: List.replace_at(board, position - 1, next_player_mark(board))

  def next_player_mark(board) do
    if mark_count("X", board) <= mark_count("O", board) do
      "X"
    else
      "O"
    end
  end

  def mark_count(mark, board), do: Enum.count(board, fn(x) -> x == mark end)

  def winner?(board) do
    winner?(board, @winning_combinations)
  end

  defp winner?(_, []), do: false
  defp winner?(board, [{first, second, third} | rest]) do
    if same_marks?(Enum.at(board, first), Enum.at(board, second), Enum.at(board, third)) do
      true
    else
      winner?(board, rest)
    end
  end

  def same_marks?(first, second, third) do
    first == second && second == third
  end
end
