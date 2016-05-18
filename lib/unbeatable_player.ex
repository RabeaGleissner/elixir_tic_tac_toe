defmodule UnbeatablePlayer do

  def make_move(board), do: make_move(board, Board.next_player_mark(board))
  def make_move(board, computer_mark) do
    [_, move] = minimax(board, computer_mark, computer_mark, 9)
    move
    #Board.place_mark(board, move)
  end

  def minimax(current_board, computer_mark, current_mark, depth) do
    current_board
    |> finish_calculation?(depth)
    |> result(current_board, computer_mark, current_mark, depth)
  end

  defp finish_calculation?(board, depth), do: if Board.game_over?(board) || depth == 0, do: :finish, else: :continue

  defp result(:finish, board, computer_mark, _, depth), do: [score(board, computer_mark, depth), -1]
  defp result(:continue, board, computer_mark, current_mark, depth) do
    board
    |> Board.available_positions
    |> Enum.reduce([initialize_score(current_mark, computer_mark), -1], fn(next_move), [score, position] ->
      evaluate_game_states(board, next_move, computer_mark, current_mark, depth, score, position)
    end)
  end

  defp evaluate_game_states(board, next_move, computer_mark, current_mark, depth, score, position) do
    board
    |> Board.place_mark(next_move)
    |> minimax(computer_mark, switch(current_mark), depth - 1)
    |> find_best_scored_move([score, position], [current_mark, computer_mark], next_move)
  end

  defp find_best_scored_move([current_score, _], [best_score, best_position], [current_mark, computer_mark], next_move) do
    computer_mark
    |> current_player(current_mark)
    |> score_better(current_score, best_score)
    |> update_score([current_score, next_move], [best_score, best_position])
  end

  defp current_player(mark, mark), do: :computer
  defp current_player(_, _), do: :opponent

  defp score_better(:computer, current_score, best_score), do: current_score > best_score
  defp score_better(:opponent, current_score, best_score), do: current_score < best_score

  defp update_score(true, updated_scored_position, _), do: updated_scored_position
  defp update_score(false, _, best_scored_position), do: best_scored_position

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
