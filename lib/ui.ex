defmodule Ui do

  @clear_screen "\e[H\e[2J"
  @game_mode [
    {1, "Human vs Human", :human_vs_human},
    {2, "Human vs Random", :human_vs_random},
    {3, "Random vs Human", :random_vs_human},
  ]

  def ask_for_game_mode do
    clear_screen
    IO.puts "Please choose a game mode:\n"
    print_game_modes(@game_mode, "")
    get_game_mode
  end

  def ask_for_board_size do
    IO.puts "Please choose a board size:\n\n1 - 3x3 board\n2 - 4x4 board"
    get_board_size
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
    |> Enum.join(line(Board.dimension(board)))
    |> IO.puts
      board
  end

  def ask_for_position(board) do
    IO.puts "\nPlease choose a position:"
    get_users_position(board)
  end

  def game_over_message(board) do
    IO.puts "Game over!"
    board
    |> Board.result
    |> message
  end

  def clear_screen, do: IO.write @clear_screen

  def say_bye do
    clear_screen
    IO.puts "Byyyee... See you next time!"
  end

  defp get_game_mode do
    input = clean_input(IO.gets(""))
    case valid_game_mode?(input) do
      {:valid, game_mode} -> map_game_mode(game_mode)
      {:invalid, user_input} -> invalid_game_mode(user_input)
    end
  end

  defp invalid_game_mode(user_choice) do
    IO.puts "Sorry, '#{user_choice}' is not valid."
    ask_for_game_mode
  end

  defp valid_game_mode?(input) do
    if Enum.any?(@game_mode, fn({number, _, _}) -> number(input) == number end) do
      {:valid, number(input)}
    else
      {:invalid, input}
    end
  end

  defp map_game_mode(user_input) do
    Enum.filter(@game_mode, fn({number, _, _}) -> user_input == number end)
    |> List.first
    |> Tuple.to_list
    |> List.last
  end

  defp get_board_size do
    IO.gets("")
    |> clean_input
    |> map_to_dimension
  end

  defp map_to_dimension("1"), do: 3
  defp map_to_dimension("2"), do: 4
  defp map_to_dimension(input), do: invalid_board_size(input)

  defp invalid_board_size(input) do
    IO.puts "Sorry, #{input} doesn't quite work. Please enter 1 or 2!"
    ask_for_board_size
  end

  defp print_game_modes([], printable), do: IO.write printable
  defp print_game_modes([{number, option, _} | rest], printable) do
    updated_printable = printable <> "#{number} - #{option}\n"
    print_game_modes(rest, updated_printable)
  end

  defp get_users_position(board) do
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

  defp draw_line(line) do
    Enum.map(line, fn(cell) -> evenly_spaced_cell(cell) end)
    |> Enum.join(" | ")
  end

  defp evenly_spaced_cell(cell) do
    cell
    |> ensure_is_string
    |> String.rjust(2)
  end

  defp ensure_is_string(input) when is_integer(input), do: Integer.to_string(input)
  defp ensure_is_string(input), do: input

  defp message(:draw), do: IO.puts "It's a draw.\n\n"
  defp message({:winner, winner}) do
    IO.puts "The winner is #{winner}.\n\n"
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

  defp line(dimension), do: "\n#{String.duplicate("-", (dimension * 4))}-\n"
end
