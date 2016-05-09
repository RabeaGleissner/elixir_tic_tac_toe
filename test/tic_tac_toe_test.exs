defmodule TicTacToeTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "runs application once for a human vs human game" do
    game_mode = "1\n"
    positions = "1\n5\n2\n6\n3\n"
    no_replay = "n\n"
    input = game_mode <> positions <> no_replay
    message = capture_io([input: input], fn ->
      TicTacToe.start
    end)
    assert String.contains?(message, "See you next time")
  end
end
