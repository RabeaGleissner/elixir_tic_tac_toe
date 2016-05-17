defmodule UnbeatablePlayer do
  @initial_alpha_value -10000
  @initial_beta_value 10000

  def make_move(board), do: make_move(board, Board.next_player_mark(board))
  def make_move(board, computer_mark) do
    [_, move] = minimax(board, computer_mark, computer_mark, 9, @initial_alpha_value, @initial_beta_value)
    {:ok, next_board } = Board.place_mark(board, move)
    next_board
  end

  def minimax(board, computer_mark, current_mark, depth, alpha, beta) do
    best_score = initialize_best_score(current_mark, computer_mark)
    best_move = -2

    if Board.game_over?(board) || depth == 0 do
      [score_for_move(board, computer_mark, depth), -1]
    else
      play_next_move(board, computer_mark, current_mark, best_score, best_move, Board.available_positions(board), depth, alpha, beta)
    end
  end

  def play_next_move(_,_,_, best_score, best_move, [], _,_,_), do: [best_score, best_move]
  def play_next_move(board, computer_mark, current_mark, existing_score, existing_best_move, [next_move | other_available_positions], depth, alpha, beta) do
    {_, next_board} = Board.place_mark(board, next_move)
    [new_score, _] = minimax(next_board, computer_mark, switch_mark(current_mark), depth - 1, alpha, beta)

    {best_score, best_move} =
    if new_best_score?(current_mark, computer_mark, new_score, existing_score) do
      {new_score, next_move}
    else
      {existing_score, existing_best_move}
    end

    new_alpha = update_alpha(alpha, best_score, current_mark, computer_mark)
    new_beta = update_beta(beta, best_score, current_mark, computer_mark)

    if new_alpha >= new_beta do
      [best_score, best_move]
    else
      play_next_move(board, computer_mark, current_mark, best_score, best_move, other_available_positions, depth, alpha, beta)
    end
  end

  defp update_alpha(alpha, best_score, current_mark, computer_mark) do
    if current_mark == computer_mark, do: Enum.max([alpha, best_score]), else: alpha
  end

  defp update_beta(beta, best_score, current_mark, computer_mark) do
    if current_mark != computer_mark, do: Enum.min([beta, best_score]), else: beta
  end

  def score_for_move(board, computer_mark, depth) do
    winning_mark = Board.winning_mark(board)
    cond do
      winning_mark == computer_mark ->
        depth
      Board.draw?(board) ->
        0
      winning_mark != computer_mark ->
        -depth
    end
  end

  defp new_best_score?(current_mark, computer_mark, new_score, best_score) when current_mark == computer_mark do
      new_score > best_score
  end

  defp new_best_score?(current_mark, computer_mark, new_score, best_score) when current_mark != computer_mark do
      new_score < best_score
  end

  defp switch_mark(current_mark) do
    if (current_mark == "X"), do: "O", else: "X"
  end

  defp initialize_best_score(current_mark, computer_mark) do
    if (current_mark == computer_mark), do: -1000, else: 1000
  end
end
