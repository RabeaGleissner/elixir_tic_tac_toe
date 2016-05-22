defmodule UnbeatablePlayer do
  @initial_alpha -10000
  @initial_beta 10000

  def make_move(board), do: make_move(board, Board.next_player_mark(board))
  def make_move(board, computer_mark) do
    Board.place_mark(board, calculate_move(board, computer_mark))
  end

  def calculate_move(board, computer_mark) do
    [{_, move} | _ ] = minimax(board, {computer_mark, computer_mark}, 9, {@initial_alpha, @initial_beta})
    move

  end

  def minimax(current_board, marks, depth, alpha_beta) do
    current_board
    |> finish_calculation?(depth)
    |> result(current_board, marks, depth, alpha_beta)
  end

  defp finish_calculation?(board, depth), do: if Board.game_over?(board) || depth == 0, do: :finish, else: :continue

  defp result(:finish, board, {computer_mark, _}, depth, alpha_beta), do: [{score(board, computer_mark, depth), -1}, alpha_beta]
  defp result(:continue, board, {computer_mark, current_mark}, depth, alpha_beta) do
    board
    |> Board.available_positions
    |> Enum.reduce_while([{starting_score(current_mark, computer_mark), -1}, alpha_beta], fn(next_move), result_accumulator ->
      evaluate_game_states(board, next_move, computer_mark, current_mark, depth, result_accumulator)
    end)
  end

  defp evaluate_game_states(board, next_move, computer_mark, current_mark, depth, [{score, position}, alpha_beta]) do
    board
    |> Board.place_mark(next_move)
    |> minimax({computer_mark, switch(current_mark)}, depth - 1, alpha_beta)
    |> find_best_scored_move([score, position], {current_mark, computer_mark}, next_move)
    |> update_alpha_beta(computer_mark, current_mark)
    |> break_or_continue
  end

  defp update_alpha_beta([{score, move}, {alpha, beta}], computer_mark, current_mark) do
    # new_alpha = if computer_mark == current_mark, do: Enum.max([alpha, score]), else: alpha
    # new_beta = if computer_mark != current_mark, do: Enum.min([beta, score]), else: beta
    new_alpha = alpha
    new_beta = beta

    [{score, move}, {new_alpha, new_beta}]
  end

  defp break_or_continue([score_move, {alpha, beta}]) when alpha >= beta, do: {:halt, [score_move, {alpha, beta}]}
  defp break_or_continue([score_move, alpha_beta]), do: {:cont, [score_move, alpha_beta]}

  defp find_best_scored_move([{current_score, _}, alpha_beta], [best_score, best_position], marks, next_move) do
    marks
    |> current_player
    |> better_score(current_score, best_score)
    |> update_score({current_score, next_move}, {best_score, best_position}, alpha_beta)
  end

  defp current_player({mark, mark}), do: :computer
  defp current_player(_), do: :opponent

  defp better_score(:computer, current_score, best_score), do: current_score > best_score
  defp better_score(:opponent, current_score, best_score), do: current_score < best_score

  defp update_score(true, updated_scored_position, _, alpha_beta), do: [updated_scored_position, alpha_beta]
  defp update_score(false, _, best_scored_position, alpha_beta), do: [best_scored_position, alpha_beta]

  def score(board, mark, depth) do
    case Board.winning_mark(board) do
      ^mark -> depth
      :no_winner -> 0
      _ -> -depth
    end
  end

  defp switch("X"), do: "O"
  defp switch("O"), do: "X"

  defp starting_score(current_mark, computer_mark) do
    if (current_mark == computer_mark), do: -1000, else: 1000
  end
end
