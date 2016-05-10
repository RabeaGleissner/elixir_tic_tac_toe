# TicTacToe

[![Build Status](https://travis-ci.org/RabeaGleissner/elixir_tic_tac_toe.svg?branch=master)](https://travis-ci.org/RabeaGleissner/elixir_tic_tac_toe)

To run this application, first clone the repo by typing:

`git clone git@github.com:RabeaGleissner/elixir_tic_tac_toe.git`

Now navigate into the directory and install the dependencies:

`mix deps.get`

## Play the game

Type:

 `mix play`

## Tests

To run the tests, type:

`mix test`

If you are interested in the code coverage, run:

`mix coveralls.html`

`open cover/excoveralls.html`

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

