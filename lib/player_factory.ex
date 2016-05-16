defmodule PlayerFactory do

  def players(game_mode) do
    case game_mode do
      :human_vs_human -> [HumanPlayer, HumanPlayer]
      :human_vs_random -> [HumanPlayer, RandomPlayer]
      :random_vs_human -> [RandomPlayer, HumanPlayer]
      :human_vs_unbeatable -> [HumanPlayer, UnbeatablePlayer]
      :unbeatable_vs_human -> [UnbeatablePlayer, HumanPlayer]
    end
  end
end
