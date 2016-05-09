defmodule TicTacToe do

  def start do
    run_application(true)
  end

  def run_application(false), do: stop
  def run_application(true) do
    game_mode = Ui.ask_for_game_mode
    board = [1,2,3,4,5,6,7,8,9]
    play(PlayerFactory.players(game_mode), board, Board.game_over?(board))
    run_application(Ui.play_again?)
  end

  def play(_players, board, true), do: game_over(board)
  def play(players, board, false) do
    Ui.print_board(board)
    next_board = play_move(players, board)
    play(Enum.reverse(players), next_board, Board.game_over?(next_board))
  end

  defp stop do
    Ui.say_bye
  end

  defp play_move([player | _], board) do
    player.make_move(board)
  end

  defp game_over(board) do
    Ui.print_board(board)
    Ui.game_over_message(board)
  end
end
