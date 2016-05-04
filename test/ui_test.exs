defmodule UiTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "it asks the user to enter a position" do
    assert capture_io(fn ->
      Ui.ask_for_position
    end) == "Please choose a position: \n"
  end
end
