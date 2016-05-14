defmodule Board do

  @winning_combinations [{0,1,2}, {3,4,5}, {6,7,8}, {0,3,6}, {1,4,7}, {2,5,8}, {0,4,8}, {2,4,6}]

  def empty_board, do: empty_board(3)
  def empty_board(dimension) do
    Enum.to_list(1..dimension * dimension)
  end

  def place_mark(board, position) do
    board
    |> position_available?(position)
    |> update_board(board)
  end

  def next_player_mark(board), do: if more_o_marks(board), do: "X", else: "O"

  def mark_count(mark, board), do: Enum.count(board, fn(cell) -> cell == mark end)

  def game_over?(board), do: winner?(board) || draw?(board)

  def winner?(board) do
    board
    |> current_lines
    |> Enum.map(fn(line) -> all_same_marks?(line) end)
    |> Enum.any?(fn(x) -> x == true end)
  end

  def draw?(board), do: board_full?(board) && !winner?(board)

  def available_positions(board), do: Enum.filter(board, &available?/1)

  def winning_mark(board), do: winning_mark(board, current_lines(board))

  def position_available?(board, position) do
    cell = Enum.at(board, position - 1)
    if available?(cell) do
      {:valid, position}
    else
      {:taken, position}
    end
  end

  def result(board) do
    if draw?(board) do
      :draw
    else
      {:winner, winning_mark(board)}
    end
  end

  def board_full?(board) do
    board
    |> Enum.reject(&mark?/1)
    |> Enum.empty?
  end

  def dimension(board) do
    length(board)
    |> :math.sqrt
    |> round
  end

  def current_lines(board) do
    [rows(board), columns(board), diagonals(board)]
    |> List.flatten
    |> Enum.chunk(dimension(board))
  end

  def rows(board), do: Enum.chunk(board, dimension(board))

  defp columns(board) do
    board
    |> rows
    |> transpose
  end

  defp diagonals(board) do
    [
      backward_diagonal([], board, dimension(board), dimension(board) - 1),
      forward_diagonal([], board, dimension(board), dimension(board), dimension(board) - 1)
    ]
  end

  defp backward_diagonal(diagonal, _, _, -1), do: diagonal
  defp backward_diagonal(diagonal, board, dimension, counter) do
    board
    |> Enum.at((dimension * counter) + counter)
    |> add_to_diagonals(diagonal)
    |> backward_diagonal(board, dimension, counter - 1)
  end

  defp forward_diagonal(diagonal, _, _, 0, _), do: Enum.reverse(diagonal)
  defp forward_diagonal(diagonal, board, dimension, counter, offset) do
    board
    |> Enum.at(offset)
    |> add_to_diagonals(diagonal)
    |> forward_diagonal(board, dimension, counter - 1, offset + (dimension - 1))
  end

  defp add_to_diagonals(cell, diagonal), do: List.insert_at(diagonal, 0, cell)

  defp update_board({:valid, position}, board) do
    next_board = board
                  |> next_player_mark
                  |> update(board, position - 1)
    {:ok, next_board}
  end

  defp update_board(error, _), do: error

  defp update(mark, board, position) do
    List.replace_at(board, position , mark)
  end

  defp winning_mark(_, []), do: nil
  defp winning_mark(board, [line | rest]) do
    if winning_line(line) do
      List.first(line)
    else
      winning_mark(board, rest)
    end
  end

  defp winning_line(line) do
    all_same_marks?(line)
  end

  defp all_same_marks?(line) do
    [head | elements] = line
    Enum.all?(elements, fn(element) -> element == head end)
  end

  defp available?(cell), do: !mark?(cell)

  defp mark?(mark), do: mark in ["X", "O"]

  defp more_o_marks(board), do: mark_count("X", board) <= mark_count("O", board)

  defp transpose([[]|_]), do: []
  defp transpose(rows) do
    [Enum.map(rows, &hd/1) | transpose(Enum.map(rows, &tl/1))]
  end
end
