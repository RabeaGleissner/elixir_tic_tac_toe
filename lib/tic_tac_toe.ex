defmodule TicTacToe do

  def start, do: run_application(true)

  defp run_application(false), do: stop
  defp run_application(true) do
    Ui.ask_for_game_mode
    |> PlayerFactory.players
    |> play(Board.empty_board, Board.game_over?(Board.empty_board))

    Ui.play_again?
    |> run_application
  end

  defp play(_players, board, true), do: game_over(board)
  defp play(players, board, false) do
    next_board = board
    |> Ui.print_board
    |> play_move(players)

    Enum.reverse(players)
    |> play(next_board, Board.game_over?(next_board))
  end

  defp stop, do: Ui.say_bye

  defp play_move(board, [player | _]), do: player.make_move(board)

  defp game_over(board) do
    board
    |> Ui.print_board
    |> Ui.game_over_message
  end
end
