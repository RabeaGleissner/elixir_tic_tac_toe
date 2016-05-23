defmodule UnbeatablePlayer do
  @initial_alpha -10000
  @initial_beta 10000
  @initial_score 10.0
  @move_placehoder -1

  def make_move(board) do
    Board.place_mark(board, calculate_move(board))
  end

  def calculate_move(board) do
    negamax(board, Enum.count(Board.available_positions(board)), @initial_alpha, @initial_beta)[:best_move]
  end

  def negamax(current_board, depth, alpha, beta) do
    current_board
    |> finish_calculation?(depth)
    |> result(current_board, depth, {alpha, beta})
  end

  defp result(:finish, board, depth, _) do
    %{:best_score => score(board, depth), :best_move => @move_placehoder}
  end

  defp result(:continue, board, depth, {alpha, beta}) do
    board
    |> Board.available_positions
    |> Enum.reduce(accumulator(alpha, beta), fn(next_move, result_accumulator) ->
      check_result(board, next_move, result_accumulator, depth)
    end)
  end

  defp check_result(board, move, current_best, depth) do
    if current_best[:alpha] >= current_best[:beta] do
      current_best
    else
      board
      |> Board.place_mark(move)
      |> negamax(depth - 1, -current_best[:beta], -current_best[:alpha])
      |> negate_score
      |> better_score?(current_best)
      |> update_score(move)
    end
  end

  defp update_score({false, _, current_best}, _), do: current_best
  defp update_score({true, new_result, current_best}, move) do
    %{
      :best_score => new_result[:best_score] ,
      :best_move => move,
      :alpha => new_result[:best_score],
      :beta => current_best[:beta],
    }
  end

  defp better_score?(new_score, old_score) do
    {new_score[:best_score] > old_score[:alpha], new_score, old_score}
  end

  defp negate_score(result) do
    %{:best_score => -result[:best_score], :best_move => result[:best_move]}
  end

  defp accumulator(alpha, beta) do
    %{
      :best_score => -@initial_score,
      :best_move => @move_placehoder,
      :alpha => alpha,
      :beta => beta,
    }
  end

  def score(board, depth) do
    if Board.winner?(board) do
      -(depth + 1)
    else
      0
    end
  end

  defp finish_calculation?(board, depth), do: if Board.game_over?(board) || depth == 0, do: :finish, else: :continue
end
