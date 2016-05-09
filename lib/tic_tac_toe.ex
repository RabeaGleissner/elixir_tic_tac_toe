defmodule TicTacToe do

  def start do
    run_application(true)
  end

  def run_application(false), do: stop
  def run_application(true) do
    board = [1,2,3,4,5,6,7,8,9]
    Ui.ask_for_game_mode
    |> PlayerFactory.players
    |> play(board, Board.game_over?(board))
    Ui.play_again?
    |> run_application
  end

  def play(_players, board, true), do: game_over(board)
  def play(players, board, false) do
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
