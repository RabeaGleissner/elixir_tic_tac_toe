defmodule Ui do

  def ask_for_position do
    IO.puts "Please choose a position:"
    get_users_position
  end

  def get_users_position do
    input = clean_input(IO.gets(""))
    if valid?(input) do
      convert_to_integer(input)
    else
      ask_for_position
    end
  end

  def print_board(board) do
    IO.puts "#{List.first(board)} | #{Enum.at(board, 1)} | #{Enum.at(board, 2)}\n#{Enum.at(board, 3)} | #{Enum.at(board, 4)} | #{Enum.at(board, 5)}\n#{Enum.at(board, 6)} | #{Enum.at(board, 7)} | #{List.last(board)}"
  end

  def game_over_message(board) do
    IO.puts "Game over!"
    if Board.draw?(board) do
      IO.puts "It's a draw."
    else
      IO.puts "Winner is #{Board.winning_mark(board)}."
    end
  end

  defp clean_input(input) do
    String.strip(input)
  end

  defp valid?(input) do
    valid_numbers = [1,2,3,4,5,6,7,8,9]
    if is_number?(input) do
      Enum.find(valid_numbers, false, fn(num) ->
        num == convert_to_integer(input)
      end)
    else
      false
    end
  end

  defp convert_to_integer(string) do
    String.to_integer(string)
  end

  defp is_number?(input) do
    Integer.parse(input) != :error
  end
end
