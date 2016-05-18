defmodule UnbeatablePlayer do

  def make_move(board), do: make_move(board, Board.next_player_mark(board))
  def make_move(board, computer_mark) do
    [score, move] = minimax(board, computer_mark, computer_mark, 9)
    move
    #Board.place_mark(board, move)
  end

  def minimax(current_board, computer_mark, current_mark, depth) do
    current_board
    |> Board.game_outcome
    |> result(current_board, computer_mark, current_mark, depth)
  end

  defp result(:game_ongoing, board, computer_mark, current_mark, depth) do
    board
    |> Board.available_positions
    |> Enum.reduce([initialize_score(current_mark, computer_mark), -1], fn(next_move), [score, position] ->
      board
      |> Board.place_mark(next_move)
      |> minimax(computer_mark, switch(current_mark), depth - 1)
      |> find_best_score(score, position, current_mark, computer_mark, next_move)
    end)
  end
  defp result(_, board, computer_mark, _, depth), do: [score(board, computer_mark, depth), -1]

  defp find_best_score([current_score, current_position], best_score, best_position, current_mark, computer_mark, next_move) do
    if current_mark == computer_mark && current_score > best_score || current_mark != computer_mark && current_score < best_score do
      [current_score, next_move]
    else
      [best_score, best_position]
    end
  end

  def score(board, computer_mark, depth) do
    board
    |> Board.winning_mark
    |> winning_player(computer_mark)
    |> score_for(depth)
  end

  defp winning_player(winner, computer) when winner == computer, do: {:ok, :computer}
  defp winning_player(winner, _) when winner == :no_winner, do: {:ok, :draw}
  defp winning_player(_, _), do: {:ok, :opponent}

  defp score_for({_, :computer}, depth), do: depth
  defp score_for({_, :opponent}, depth), do: -depth
  defp score_for({_, :draw}, _), do: 0

  defp switch(mark), do: if (mark == "X"), do: "O", else: "X"

  defp initialize_score(current_mark, computer_mark) do
    if (current_mark == computer_mark), do: -1000, else: 1000
  end
end
