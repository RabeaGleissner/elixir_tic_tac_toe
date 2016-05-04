defmodule Board do

  @winning_combinations [{0,1,2}, {3,4,5}, {6,7,8}, {0,3,6}, {1,4,7}, {2,5,8}, {0,4,8}, {2,4,6}]

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

  def winning_mark(board) do
    winning_mark(board, @winning_combinations)
  end

  defp winning_mark(board, [line | rest]) do
    if winning_line(board, line) do
      Enum.at(board, elem(line, 0))
    else
      winning_mark(board, rest)
    end
  end

  defp winner?(_, []), do: false
  defp winner?(board, [line | rest]) do
    if winning_line(board, line) do
      true
    else
      winner?(board, rest)
    end
  end

  defp winning_line(board, {first, second, third}) do
    same_marks?(Enum.at(board, first), Enum.at(board, second), Enum.at(board, third))
  end

  defp same_marks?(first, second, third) do
    first == second && second == third
  end
end
