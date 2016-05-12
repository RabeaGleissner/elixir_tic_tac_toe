defmodule UiTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  @clear_screen "\e[H\e[2J"

  test "asks user to enter board size" do
    assert capture_io([input: "1\n"], fn ->
      Ui.ask_for_board_size
    end) == "Please choose a board size:\n\n1 - 3x3 board\n2 - 4x4 board\n"
  end

  test "returns board size chosen by user" do
    assert capture_io([input: "1\n"], fn ->
      assert Ui.ask_for_board_size == 3
    end)
  end

  test "shows error and asks again if invalid board size was chosen" do
    assert capture_io([input: "8\n2\n"], fn ->
      Ui.ask_for_board_size
    end) == "Please choose a board size:\n\n1 - 3x3 board\n2 - 4x4 board\nSorry, 8 doesn't quite work. Please enter 1 or 2!\nPlease choose a board size:\n\n1 - 3x3 board\n2 - 4x4 board\n"
  end

  test "asks user to enter a game mode" do
    assert capture_io([input: "1\n"], fn ->
      Ui.ask_for_game_mode
    end) == "#{@clear_screen}Please choose a game mode:\n\n1 - Human vs Human\n2 - Human vs Random\n3 - Random vs Human\n"
  end

  test "returns :human_vs_human for user input 1" do
    capture_io([input: "1\n"], fn ->
      assert Ui.ask_for_game_mode == :human_vs_human
    end)
  end

  test "returns :human_vs_random for user input 2" do
    capture_io([input: "2\n"], fn ->
      assert Ui.ask_for_game_mode == :human_vs_random
    end)
  end

  test "returns :random_vs_human for user input 3" do
    capture_io([input: "3\n"], fn ->
      assert Ui.ask_for_game_mode == :random_vs_human
    end)
  end

  test "shows an error message when chosen game mode is invalid" do
    messages = capture_io([input: "hey\n1\n"], fn ->
      Ui.ask_for_game_mode
    end)
    assert String.contains?(messages, "Sorry, 'hey' is not valid.")
  end

  test "asks the user to enter a position" do
    assert capture_io([input: "4\n"], fn ->
      Ui.ask_for_position(Board.empty_board)
    end) == "Please choose a position:\n"
  end

  test "returns the user's choice for a position" do
    capture_io([input: "4\n"], fn ->
      assert Ui.ask_for_position(Board.empty_board)
      == 4
    end)
  end

  test "asks for position again if user input is invalid" do
    assert capture_io([input: "n\n4\n"], fn ->
      Ui.ask_for_position(Board.empty_board)
    end) == "Please choose a position:\nn is invalid. We need a number!\nPlease choose a position:\n"
  end

  test "asks for position again if chosen position is already taken" do
    assert capture_io([input: "1\n4\n"], fn ->
      Ui.ask_for_position(["X",2,3,4,5,6,7,8,9])
    end) == "Please choose a position:\n1 is already taken!\nPlease choose a position:\n"
  end

  test "prints a board" do
    assert capture_io(fn ->
      Ui.print_board([1,"X",3,4,"O",6,7,8,9])
    end) == @clear_screen <> "1 | X | 3\n---------\n4 | O | 6\n---------\n7 | 8 | 9\n\n"
  end

  test "prints game over message for winner X" do
    assert capture_io(fn ->
      Ui.game_over_message([
        "X","O","X",
        "O","X","O",
        "O","X","X"])
    end) == "Game over!\nThe winner is X.\n\n\n"
  end

  test "prints game over message for winner O" do
    assert capture_io(fn ->
      Ui.game_over_message([
        "X","O","X",
        "O","O","O",
        "O","X","X"])
    end) == "Game over!\nThe winner is O.\n\n\n"
  end

  test "prints game over message for a draw" do
    assert capture_io(fn ->
      Ui.game_over_message([
        "X","O","X",
        "X","O","O",
        "O","X","X"])
    end) == "Game over!\nIt's a draw.\n\n\n"
  end

  test "asks if user wants to play again" do
    assert capture_io([input: "y"], fn ->
      Ui.play_again?
    end) == "Play again? (y/n)\n"
  end

  test "returns true when user wants to play again" do
    capture_io([input: "y"], fn ->
      assert Ui.play_again?
    end)
  end

  test "returns false when user does not want to play again" do
    capture_io([input: "n"], fn ->
      refute Ui.play_again?
    end)
  end

  test "displays error message on invalid input for replay" do
    message = capture_io([input: "maybe\nn"], fn ->
      Ui.play_again?
    end)
    assert String.contains?(message, "Please reply with 'y' or 'n'.")
  end

  test "says goodbye" do
    assert capture_io(fn ->
      assert Ui.say_bye
    end) == @clear_screen <> "Byyyee... See you next time!\n"
  end
end
