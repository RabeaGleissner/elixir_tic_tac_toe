defmodule PlayerFactoryTest do
  use ExUnit.Case

  test "returns two human players for human vs human game" do
    assert PlayerFactory.players(:human_vs_human) == [HumanPlayer, HumanPlayer]
  end

  test "returns human and random players for human vs random game" do
    assert PlayerFactory.players(:human_vs_random) == [HumanPlayer, RandomPlayer]
  end

  test "returns random and human players for random vs human game" do
    assert PlayerFactory.players(:random_vs_human) == [RandomPlayer, HumanPlayer]
  end

  test "returns human and unbeatable players for human vs unbeatable game" do
    assert PlayerFactory.players(:human_vs_unbeatable) == [HumanPlayer, UnbeatablePlayer]
  end

  test "returns unbeatable and human players for unbeatable vs human game" do
    assert PlayerFactory.players(:unbeatable_vs_human) == [UnbeatablePlayer, HumanPlayer]
  end
end
