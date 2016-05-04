defmodule Ui do
  def ask_for_position do
    IO.puts "Please choose a position:"
    get_users_position
  end

  def get_users_position do
    input = clean_input(IO.gets(""))
    if valid?(input) do
      convert_to_integer(input)
    else
      ask_for_position
    end
  end

  def clean_input(input) do
    String.strip(input)
  end

  def valid?(input) do
    valid_numbers = [1,2,3,4,5,6,7,8,9]
    if is_number?(input) do
      Enum.find(valid_numbers, false, fn(num) ->
        num == convert_to_integer(input)
      end)
    else
      false
    end
  end

 defp convert_to_integer(string) do
    String.to_integer(string)
  end

  defp is_number?(input) do
    Integer.parse(input) != :error
  end
end
