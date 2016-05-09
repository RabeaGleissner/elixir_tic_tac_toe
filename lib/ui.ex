defmodule Ui do

  @clear_screen "\e[H\e[2J"
  @game_mode [
    {1, "Human vs Human"},
    {2, "Human vs Random"},
    {3, "Random vs Human"},
  ]

    def ask_for_game_mode do
      IO.puts "Please choose a game mode:"
      Enum.map(@game_mode, fn({number, option}) -> IO.puts "#{number} - #{option}" end)
      get_game_mode
    end

    def get_game_mode do
      input = clean_input(IO.gets(""))
      case valid_game_mode?(input) do
        {:valid, game_mode} -> map_game_mode(game_mode)
        {:invalid, user_input} -> invalid_game_mode(user_input)
      end
    end

    def invalid_game_mode(user_choice) do
      IO.puts "Sorry, '#{user_choice}' is not valid."
      ask_for_game_mode
    end

    def valid_game_mode?(input) do
      if Enum.any?(@game_mode, fn({number, _}) -> number(input) == number end) do
        {:valid, number(input)}
      else
        {:invalid, input}
      end
    end

    def map_game_mode(number) do
      case number do
        1 -> :human_vs_human
        2 -> :human_vs_random
        3 -> :random_vs_human
      end
    end

    def ask_for_position(board) do
      IO.puts "Please choose a position:"
      get_users_position(board)
    end

    def get_users_position(board) do
      input = clean_input(IO.gets(""))
      case valid_position?(input, board) do
        {:valid, position} -> position
        {:taken, position} -> move_was_taken(board, position)
        :not_a_number -> was_not_a_number(board, input)
      end
    end

    defp move_was_taken(board, position) do
      IO.puts "#{position} is already taken!"
      ask_for_position(board)
    end

    defp was_not_a_number(board, input) do
      IO.puts "#{input} is invalid. We need a number!"
      ask_for_position(board)
    end

    def play_again? do
      IO.puts "Play again? (y/n)"
      get_users_replay_choice
    end

    def print_board(board) do
      clear_screen
      board
      |> Board.rows
      |> Enum.map(&draw_line/1)
      |> Enum.join(line)
      |> IO.puts
    end

    defp clear_screen, do: IO.write @clear_screen

    defp draw_line(line) do
      Enum.join(line, " | ") <> "\n"
    end

    def game_over_message(board) do
      IO.puts "Game over!"
      board
      |> Board.result
      |> message
    end

    defp message(:draw), do: IO.puts "It's a draw.\n\n"
    defp message({:winner, winner}) do
      IO.puts "The winner is #{winner}.\n\n"
    end

    def say_bye do
      clear_screen
      IO.puts "Byyyee... See you next time!"
    end

    defp clean_input(input) do
      input
      |> String.strip
      |> String.downcase
    end

    defp get_users_replay_choice do
      IO.gets("")
      |> clean_input
      |> replay?
    end

    defp replay?("y"), do: true
    defp replay?("n"), do: false
    defp replay?(_) do
      invalid_replay_choice_error
      play_again?
    end

    defp invalid_replay_choice_error do
      IO.puts "Please reply with 'y' or 'n'."
    end

    defp valid_position?(input, board) do
      input
      |> number
      |> available_on_board?(board)
    end

    defp available_on_board?(:not_a_number, _), do: :not_a_number
    defp available_on_board?(position, board) do
      Board.position_available?(board, position)
    end

    defp number(input) do
      case Integer.parse(input) do
        {number, ""} -> number
        _ -> :not_a_number
      end
    end

    defp line do
      "---------\n"
    end
end
