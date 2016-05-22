defmodule UnbeatablePlayer do
  @initial_alpha -10000
  @initial_beta 10000
  @initial_score 10.0
  @move_placehoder -1

  def make_move(board), do: make_move(board, Board.next_player_mark(board))
  def make_move(board, computer_mark) do
    Board.place_mark(board, calculate_move(board))
  end

  def calculate_move(board) do
    [{_, move}, _] = negamax(board, Enum.count(Board.available_positions(board)), @initial_alpha, @initial_beta)
    move
  end

  def negamax(current_board, depth, alpha, beta) do
    current_board
    |> finish_calculation?(depth)
    |> result(current_board, depth, {alpha, beta})
  end

  defp result(:finish, board, depth, alpha_beta), do: [{score(board), @move_placehoder}, alpha_beta]
  defp result(:continue, board, depth, {alpha, beta}) do
    board
    |> Board.available_positions
    |> Enum.reduce(accumulator(alpha, beta), fn(next_move, result_accumulator) ->
      check_result(board, next_move, result_accumulator, depth)
    end)
  end

  defp check_result(board, move, [{current_best_score, current_best_move}, {alpha, beta}], depth) do
    if alpha >= beta do
      [{current_best_score, current_best_move}, {alpha, beta}]
    else
      [{new_best_score, new_best_move}, {alpha, beta}] = negate_score(negamax(board, depth - 1, -alpha, -beta))
      if new_best_score > current_best_score do
        [{new_best_score, move}, {new_best_score, beta}]
      else
        [{current_best_score, current_best_move}, {alpha, beta}]
      end
    end
  end

  defp negate_score([{current_best_score, current_best_move}, {alpha, beta}]) do
    [{-current_best_score, current_best_move}, {alpha, beta}]
  end

  defp accumulator(alpha, beta) do
    [{-@initial_score, @move_placehoder}, {alpha, beta}]
  end

  def score(board) do
    if Board.winner?(board), do: 1, else: 0
  end

  defp finish_calculation?(board, depth), do: if Board.game_over?(board) || depth == 0, do: :finish, else: :continue
end
