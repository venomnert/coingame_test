defmodule User do

  @me __MODULE__
  @default_amount 1
  @type banking_error :: {:error,
    :wrong_arguments                |
    :user_already_exists            |
    :user_does_not_exist
  }

  def start_link() do
    Agent.start_link(&init_users/0, name: @me)
  end

  def init_users() do
    %{}
  end

  def create_user(user) when is_binary(user) do
    formatted_user = format_user(user)
    get_user_account(user)
    |> case do
      nil  -> Agent.update(@me, fn state -> state |> Map.put(formatted_user, @default_amount) end)
      _user_account -> {:error, :user_already_exists}
    end
  end
  def create_user(_user) do
    {:error, :wrong_arguments}
  end

  def update_user_balance(user, opp, amount, currency) when is_binary(user) and is_number(amount) do
    user_account = get_user_account(user)
    foreign_amount =  amount * Currency.get_currency(currency)
    update_user_balance(user_account, {opp, foreign_amount})
  end

  def update_user_balance(user_account, {:add, amount}) do
    user_key = get_user_key(user_account)
    user_balance = user_account[user_key]
    new_balance = user_balance + amount
    Agent.update(@me, fn state -> state |> Map.put(user_key, new_balance) end)
    {:ok, new_balance}
  end
  def update_user_balance(user_account, {:decr, amount}) do
    user_key = get_user_key(user_account)
    user_balance = user_account[user_key]
    new_balance = user_balance - amount

    case new_balance do
      value when value >= 0 ->
        Agent.update(@me, fn state -> state |> Map.put(user_key, new_balance) end)
        {:ok, new_balance}

      value when value < 0 ->
        {:error, :not_enough_money }
    end
  end
  def update_user_balance(nil, _) do
    {:error, :user_does_not_exist}
  end
  def update_user_balance(_user, _opp, _amount) do
    {:error, :wrong_arguments}
  end

  def get_balance(user, currency) when is_binary(user) and is_binary(currency) do
    user_account = get_user_account(user)
    convert_amount(user_account, currency)
  end
  def get_balance(nil, _rate) do
    {:error, :user_does_not_exist}
  end
  def get_balance(_user, _currency) do
    {:error, :wrong_arguments}
  end
  def convert_amount(user_account, currency) do
    Currency.get_currency(currency)
    rate = currency |> Currency.get_currency()

    case get_user_amount(user_account) do
      nil -> {:ok, 0}
      amount -> {:ok, amount * rate}
    end
  end

  defp get_user_account(user) do
    formatted_user = format_user(user)
    Agent.get(@me, fn state -> state |> Map.get(formatted_user) end)
    |> case do
      nil -> nil
      value -> %{formatted_user => value}
    end
  end
  defp get_user_key(user_account) do
    user_account
    |> Map.keys()
    |> List.first()
  end
  defp get_user_amount(user_account) do
    user_account |> Map.values() |> List.first()
  end
  defp format_user(user) do
    user |> String.upcase() |> String.to_atom()
  end
end
