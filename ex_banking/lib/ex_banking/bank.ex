defmodule ExBanking.Bank do
  @type banking_error :: {:error,
    :wrong_arguments                |
    :sender_does_not_exist          |
    :receiver_does_not_exist        |
    :too_many_requests_to_user      |
    :too_many_requests_to_sender    |
    :too_many_requests_to_receiver
  }

  @spec create_user(user :: String.t) :: :ok | banking_error
  defdelegate create_user(user), to: User

  @spec get_balance(user :: String.t, currency :: String.t) :: {:ok, balance :: number} | banking_error
  defdelegate get_balance(user, currency), to: User

  @spec deposit(user :: String.t, amount :: number, currency :: String.t) :: {:ok, new_balance :: number} | banking_error
  def deposit(user, amount, currency) do
    user
    |> User.update_user_balance(:add, amount, currency)
  end

  @spec withdraw(user :: String.t, amount :: number, currency :: String.t) :: {:ok, new_balance :: number} | banking_error
  def withdraw(user, amount, currency) when is_binary(user) and is_number(amount) and is_binary(currency) do
    user
    |> User.update_user_balance(:decr, amount, currency)
  end

  @spec send(from_user :: String.t, to_user :: String.t, amount :: number, currency :: String.t) :: {:ok, from_user_balance :: number, to_user_balance :: number} | banking_error
  def send(from_user, to_user, amount, currency) when is_binary(from_user) and is_binary(to_user) and is_number(amount) and is_binary(currency) do
    from_user_balance = 0
    to_user_balance = 1
    {:ok, from_user_balance, to_user_balance}
  end
  def send(from_user, to_user, amount, currency) do
    {:error, :user_does_not_exists}
  end

end
