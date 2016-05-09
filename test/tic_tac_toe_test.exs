defmodule TicTacToeTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "it runs the application once" do
    positions = "1\n5\n2\n6\n3\n"
    no_replay = "n\n"
    input = positions <> no_replay
    message = capture_io([input: input], fn ->
      TicTacToe.start
    end)
    assert String.contains?(message, "See you next time")
  end
end
