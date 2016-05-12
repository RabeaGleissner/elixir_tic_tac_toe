defmodule TicTacToeTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "runs application once for a human vs human game" do
    board_size = "1\n"
    game_mode = "1\n"
    positions = "1\n5\n2\n6\n3\n"
    no_replay = "n\n"
    input = board_size <> game_mode <> positions <> no_replay
    message = capture_io([input: input], fn ->
      TicTacToe.start
    end)
    assert String.contains?(message, "See you next time")
  end

  test "runs application once for a human vs random game" do
    board_size = "1\n"
    game_mode = "2\n"
    positions = "1\n2\n3\n"
    no_replay = "n\n"
    input = board_size <> game_mode <> positions <> no_replay
    :rand.seed(:exsplus, {1, 2, 3})
    message = capture_io([input: input], fn ->
      TicTacToe.start
    end)
    assert String.contains?(message, "See you next time")
  end
end
