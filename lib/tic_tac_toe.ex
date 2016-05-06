defmodule TicTacToe do

  def start do
    run_application(true)
  end

  def run_application(false), do: stop
  def run_application(true) do
    board = [1,2,3,4,5,6,7,8,9]
    play(board, Board.game_over?(board))
    run_application(Ui.play_again?)
  end

  def play(board, true), do: game_over(board)
  def play(board, false) do
    Ui.print_board(board)
    {:ok, next_board} = Board.place_mark(board, Ui.ask_for_position(board))
    play(next_board, Board.game_over?(next_board))
  end

  defp stop do
    Ui.say_bye
  end

  defp game_over(board) do
    Ui.print_board(board)
    Ui.game_over_message(board)
  end
end
