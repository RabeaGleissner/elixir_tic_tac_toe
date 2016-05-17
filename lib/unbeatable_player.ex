defmodule UnbeatablePlayer do

  def score_for_move(board, computer_mark) do
    board
    |> Board.winning_mark
    |> winning_player(computer_mark)
    |> score_for
  end

  defp winning_player(winner, computer) when winner == computer, do: {:ok, :computer}
  defp winning_player(winner, _) when winner == :no_winner, do: {:ok, :draw}
  defp winning_player(_, _), do: {:ok, :opponent}

  defp score_for({_, :computer}), do: 1
  defp score_for({_, :opponent}), do: -1
  defp score_for({_, :draw}), do: 0
end
