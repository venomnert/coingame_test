defmodule Currency do
  @me __MODULE__

  def start_link() do
    Agent.start_link(&currency_list/0, name: @me)
  end

  def get_currency(currency) do
    formatted_currency = currency
                          |> String.upcase()
                          |> String.to_atom()

    Agent.get(@me, fn state ->
      state
      |> Map.get(formatted_currency)
    end)
    |> case do
      nil ->
            Agent.update(@me, fn state -> state |> Map.put(formatted_currency, 1.0) end)
            Agent.get(@me, fn state -> state |> Map.get(formatted_currency) end)
      item -> item
    end
  end

  def currency_list() do
    %{
      USD: 1.0,
      CAD: 1.5,
      EUR: 1.2
    }
  end
end
