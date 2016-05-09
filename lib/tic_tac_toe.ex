defmodule TicTacToe do

  def start do
    run_application(true)
  end

  defp run_application(false), do: stop
  defp run_application(true) do
    empty_board = [1,2,3,4,5,6,7,8,9]
    Ui.ask_for_game_mode
    |> PlayerFactory.players
    |> play(empty_board, Board.game_over?(empty_board))
    Ui.play_again?
    |> run_application
  end

  defp play(_players, board, true), do: game_over(board)
  defp play(players, board, false) do
    board |> Ui.print_board
    next_board = play_move(board, players)
    Enum.reverse(players) |> play(next_board, Board.game_over?(next_board))
  end

  defp stop do
    Ui.say_bye
  end

  defp play_move(board, [player | _]) do
    player.make_move(board)
  end

  defp game_over(board) do
    Ui.print_board(board)
    Ui.game_over_message(board)
  end
end
