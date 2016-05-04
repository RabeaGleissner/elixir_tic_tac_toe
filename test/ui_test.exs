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
end
