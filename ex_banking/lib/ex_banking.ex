defmodule ExBanking do
  @moduledoc """
  Documentation for ExBanking.
  """

  def init_bank() do
   {:ok, pid} = Supervisor.start_child(ExBanking.Supervisor, [])
   pid
  end

  def create_user(bank_pid, user) do
    GenServer.call(bank_pid, {:create_user, user})
  end

  def get_balance(bank_pid, user, currency) do
    GenServer.call(bank_pid, {:get_balance, user, currency})
  end

  def deposit(bank_pid, user, amount, currency) do
    GenServer.call(bank_pid, {:deposit, user, amount, currency})
  end

  def withdraw(bank_pid, user, amount, currency) do
    GenServer.call(bank_pid, {:withdraw, user, amount, currency})
  end

  def send(from_user, to_user, amount, currency) when is_binary(from_user) and is_binary(to_user) and is_number(amount) and is_binary(currency) do

  end
  def send(from_user, to_user, amount, currency) do

  end

end
