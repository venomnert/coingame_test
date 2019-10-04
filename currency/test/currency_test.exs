defmodule CurrencyTest do
  use ExUnit.Case
  doctest Currency

  test "greets the world" do
    assert Currency.hello() == :world
  end
end
