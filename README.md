# TicTacToe

To run this application, first clone the repo by typing:

`git clone git@github.com:RabeaGleissner/elixir_tic_tac_toe.git`

Then navigate into the directory and type:

 `mix play`

To run the tests, type:

`mix test`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add tic_tac_toe to your list of dependencies in `mix.exs`:

        def deps do
          [{:tic_tac_toe, "~> 0.0.1"}]
        end

  2. Ensure tic_tac_toe is started before your application:

        def application do
          [applications: [:tic_tac_toe]]
        end

