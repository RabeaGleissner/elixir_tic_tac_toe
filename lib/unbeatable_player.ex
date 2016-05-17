defmodule UnbeatablePlayer do
  @initial_alpha -10000
  @initial_beta 10000
  @move_placeholder -1

  def make_move(board), do: make_move(board, Board.next_player_mark(board))
  def make_move(board, computer_mark) do
    [_, move] = minimax(board, computer_mark, computer_mark, 9, @initial_alpha, @initial_beta)
    {:ok, next_board} = Board.place_mark(board, move)
    next_board
  end

  def minimax(board, computer_mark, current_mark, depth, alpha, beta) do
    board
    |> finished?(depth)
    |> result(computer_mark, current_mark, depth, alpha, beta)
  end

  def play_move(board, computer_mark, current_mark, depth, alpha, beta) do
    board
    |> Board.available_positions
    |> Enum.reduce_while([initialize_score(current_mark, computer_mark), @move_placeholder],
      fn(next_move), [existing_score, existing_best_move] ->
      board
      |> Board.place_mark(next_move)
      |> get_next_board
      |> minimax(computer_mark, switch(current_mark), depth - 1, alpha, beta)
      |> get_new_score
      |> find_best_score(existing_score, current_mark, computer_mark, next_move, existing_best_move)
      |> prune(computer_mark, current_mark, alpha, beta)
    end)
  end

  defp finished?(board, depth) do
    if depth == 0 || Board.game_over?(board), do: {:finished, board}, else: {:not_finished, board}
  end

  defp result({:finished, board}, computer_mark, _, depth, _,_) do
    [score_for_move(board, computer_mark, depth), -1]
  end
  defp result({:not_finished, board}, computer_mark, current_mark, depth, alpha, beta) do
      play_move(board, computer_mark, current_mark, depth, alpha, beta)
  end

  defp get_next_board({_, next_board}), do: next_board

  defp get_new_score([new_score, _]), do: new_score

  defp find_best_score(new_score, existing_score, current_mark, computer_mark, next_move, existing_best_move) do
    if new_best_score?(current_mark, computer_mark, new_score, existing_score) do
      {new_score, next_move}
    else
      {existing_score, existing_best_move}
    end
  end

  defp prune({best_score, best_move}, computer_mark, current_mark, alpha, beta) do
    new_alpha = update_alpha(alpha, best_score, current_mark, computer_mark)
    new_beta = update_beta(beta, best_score, current_mark, computer_mark)

    if new_alpha >= new_beta do
      {:halt, [best_score, best_move]}
    else
      {:cont, [best_score, best_move]}
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

  defp switch(current_mark) do
    if (current_mark == "X"), do: "O", else: "X"
  end

  defp initialize_score(current_mark, computer_mark) do
    if (current_mark == computer_mark), do: -1000, else: 1000
  end
end
