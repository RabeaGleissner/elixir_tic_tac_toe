defmodule UnbeatablePlayer do
  require IEx

  def make_move(board), do: make_move(board, "X")
  def make_move(board, computer_mark) do
    [_, move] = minimax(board, computer_mark, computer_mark)
    move
  end

  def minimax(board, computer_mark, current_mark) do
    best_score = initialize_best_score(current_mark, computer_mark)
    best_move = -1

    if Board.game_over?(board) do
      [score_for_move(board, computer_mark), -1]
    else
      play_next_move(board, computer_mark, current_mark, best_score, best_move, Board.available_positions(board))
    end
  end

  def play_next_move(_, _, _, best_score, best_move, []), do: [best_score, best_move]
  def play_next_move(board, computer_mark, current_mark, existing_score, existing_best_move, [next_move | other_available_positions]) do
    {_, next_board} = Board.place_mark(board, next_move)
    [new_score, _] = minimax(next_board, computer_mark, switch_mark(current_mark))

    {best_score, best_move} =
    if new_best_score?(current_mark, computer_mark, new_score, existing_score) do
      {new_score, next_move}
    else
      {existing_score, existing_best_move}
    end
    play_next_move(board, computer_mark, current_mark, best_score, best_move, other_available_positions)
  end

  def score_for_move(board, computer_mark) do
    winning_mark = Board.winning_mark(board)
    cond do
      winning_mark == computer_mark ->
        1
      Board.draw?(board) ->
        0
      winning_mark != computer_mark ->
        -1
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
