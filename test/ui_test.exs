defmodule UiTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "it asks the user to enter a position" do
    assert capture_io([input: "4\n"], fn ->
      Ui.ask_for_position
    end) == "Please choose a position:\n"
  end

  test "it returns the user's choice for a position" do
    capture_io([input: "4\n"], fn ->
      assert Ui.get_users_position == 4
    end)
  end

  test "it asks for a position again if user input is invalid" do
    assert capture_io([input: "n\n4\n"], fn ->
      Ui.ask_for_position
    end) == "Please choose a position:\nPlease choose a position:\n"
  end

  test "it prints an empty board" do
    assert capture_io(fn ->
      Ui.print_board([1,2,3,4,5,6,7,8,9])
    end) == "1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9\n"
  end

  test "it prints a full board" do
    assert capture_io(fn ->
      Ui.print_board([ "X","O","X","O","X","O","O","X","X"])
    end) == "X | O | X\nO | X | O\nO | X | X\n"
  end
end
