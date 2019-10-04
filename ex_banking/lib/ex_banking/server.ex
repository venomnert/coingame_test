defmodule ExBanking.Server do

  use GenServer
  alias ExBanking.Bank

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, ExBanking.Bank}
  end

  def handle_call({:create_user, user}, _from, state) do
    {:reply, Bank.create_user(user), state}
  end
  def handle_call({:get_balance, user, currency}, _from, state) do
    {:reply, Bank.get_balance(user, currency), state}
  end
  def handle_call({:deposit, user, amount, currency}, _from, state) do
    {:reply, Bank.deposit(user, amount, currency), state}
  end
  def handle_call({:withdraw, user, amount, currency}, _from, state) do
    {:reply, Bank.withdraw(user, amount, currency), state}
  end
end
