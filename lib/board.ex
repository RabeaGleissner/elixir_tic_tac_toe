defmodule Board do

  @winning_combinations [{0,1,2}, {3,4,5}, {6,7,8}, {0,3,6}, {1,4,7}, {2,5,8}, {0,4,8}, {2,4,6}]

  def place_mark(board, position) do
    board
    |> position_available?(position)
    |> update_board(board)
  end

  defp update_board({:valid, position}, board) do
    next_board = board
               |> next_player_mark
               |> update(board, position-1)
    {:ok, next_board}
  end

  defp update_board(error, _), do: error

  defp update(mark, board, position) do
    List.replace_at(board, position , mark)
  end

  def next_player_mark(board), do: if more_o_marks(board), do: "X", else: "O"

  def mark_count(mark, board), do: Enum.count(board, fn(cell) -> cell == mark end)

  def game_over?(board), do: winner?(board) || draw?(board)

  def winner?(board), do: winner?(board, @winning_combinations)

  def draw?(board), do: board_full?(board) && !winner?(board)

  def board_full?(board) do
    board
    |> Enum.reject(&mark?/1)
    |> Enum.empty?
  end

  def rows(board) do
    Enum.chunk(board, 3)
  end

  def available_positions(board) do
    Enum.filter(board, &available?/1)
  end

  def winning_mark(board), do: winning_mark(board, @winning_combinations)

  defp mark?(mark), do: mark in ["X", "O"]

  def position_available?(board, position) do
    cell = Enum.at(board, position - 1)
    if available?(cell) do
      {:valid, position}
    else
      {:taken, position}
    end
  end

  def available?(cell) do
    !(cell in ["X", "O"])
  end

  def result(board) do
    if draw?(board) do
      :draw
    else
      {:winner, winning_mark(board)}
    end
  end

  defp winning_mark(_, []), do: nil
  defp winning_mark(board, [line | rest]) do
    if winning_line(board, line) do
      Enum.at(board, elem(line, 0))
    else
      winning_mark(board, rest)
    end
  end

  defp winner?(_, []), do: false
  defp winner?(board, [line | rest]) do
    if winning_line(board, line), do: true, else: winner?(board, rest)
  end

  defp winning_line(board, {first, second, third}) do
    same_marks?(Enum.at(board, first), Enum.at(board, second), Enum.at(board, third))
  end

  defp same_marks?(mark, mark, mark), do: true
  defp same_marks?(_,_,_), do: false

  defp more_o_marks(board), do: mark_count("X", board) <= mark_count("O", board)
end
