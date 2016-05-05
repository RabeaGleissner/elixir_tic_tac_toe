defmodule Ui do

  @clear_screen "\e[H\e[2J"

  def ask_for_position do
    IO.puts "Please choose a position:"
    get_users_position
  end

  def get_users_position do
    input = clean_input(IO.gets(""))
    if valid_position?(input) do
      convert_to_integer(input)
    else
      ask_for_position
    end
  end

  def play_again? do
    IO.puts "Play again? (y/n)"
    get_users_replay_choice
  end

  def print_board(board) do
    IO.puts @clear_screen <> "#{List.first(board)} | #{Enum.at(board, 1)} | #{Enum.at(board, 2)}\n" <>
    line <>
    "#{Enum.at(board, 3)} | #{Enum.at(board, 4)} | #{Enum.at(board, 5)}\n" <>
    line <>
    "#{Enum.at(board, 6)} | #{Enum.at(board, 7)} | #{List.last(board)}\n"
  end

  def game_over_message(board) do
    IO.puts "Game over!"
    if Board.draw?(board) do
      IO.puts "It's a draw.\n\n"
    else
      IO.puts "Winner is #{Board.winning_mark(board)}.\n\n"
    end
  end

  def say_bye do
    IO.puts @clear_screen <> "Byyyee... See you next time!"
  end

  defp clean_input(input) do
    input
    |> String.strip
    |> String.downcase
  end

  defp get_users_replay_choice do
    input = clean_input(IO.gets(""))
    cond do
      input == "y" ->
        true
      input == "n" ->
        false
      true ->
        IO.puts "Please reply with 'y' or 'n'."
        play_again?
    end
  end

  defp valid_position?(input) do
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

  defp line do
    "---------\n"
  end

end
