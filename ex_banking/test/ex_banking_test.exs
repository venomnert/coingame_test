defmodule ExBankingTest do
  use ExUnit.Case
  doctest ExBanking

  alias ExBanking.Bank
  alias ExBanking

  @amount 1.0

  describe "banking" do
    test "create_user/1 returns :ok" do
      test_user = :rand.uniform(20) |> Integer.to_string()

      assert :ok == Bank.create_user(test_user)
    end

    test "get_balance/1 new currency balance" do
      test_user = :rand.uniform(20) |> Integer.to_string()

      assert :ok == Bank.create_user(test_user)
      assert {:ok, @amount} == Bank.get_balance(test_user, "NZD")
    end

    test "deposit/3 add" do
      test_user = :rand.uniform(20) |> Integer.to_string()

      Bank.create_user(test_user)
      assert {:ok, 101} == Bank.deposit(test_user, 100,"USD")
    end

    test "withdraw/3 decr negative" do
      test_user = :rand.uniform(20) |> Integer.to_string()

      Bank.create_user(test_user)
      assert {:error, :not_enough_money} == Bank.withdraw(test_user, 100, "USD")
    end

    test "withdraw/3 decr" do
      test_user = :rand.uniform(10) |> Integer.to_string()

      User.create_user(test_user)
      Bank.deposit(test_user, 100, "USD")
      assert {:ok, 1} == Bank.withdraw(test_user, 100, "USD")
    end
  end
end
