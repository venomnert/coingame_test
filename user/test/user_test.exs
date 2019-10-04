defmodule UserTest do
  use ExUnit.Case
  doctest User

  @amount 1.0

  describe "users" do
    test "create_user/1 returns :ok" do
      test_user = :rand.uniform(10) |> Integer.to_string()

      assert :ok == User.create_user(test_user)
      assert {:ok, @amount} == User.get_balance(test_user, "USD")
      assert {:ok, (@amount*1.5)} == User.get_balance(test_user, "CAD")
    end

    test "get_balance/1 new currency balance" do
      test_user = :rand.uniform(10) |> Integer.to_string()

      assert :ok == User.create_user(test_user)
      assert {:ok, @amount} == User.get_balance(test_user, "NZD")
    end

    test "update_user_balance/3 add" do
      test_user = :rand.uniform(10) |> Integer.to_string()

      User.create_user(test_user)
      assert {:ok, 101} == User.update_user_balance(test_user, :add, 100, "USD")
    end

    test "update_user_balance/3 decr negative" do
      test_user = :rand.uniform(10) |> Integer.to_string()

      User.create_user(test_user)
      assert {:error, :not_enough_money} == User.update_user_balance(test_user, :decr, 100, "USD")
    end

    test "update_user_balance/3 decr" do
      test_user = :rand.uniform(10) |> Integer.to_string()

      User.create_user(test_user)
      User.update_user_balance(test_user, :add, 100, "USD")
      assert {:ok, 1} == User.update_user_balance(test_user, :decr, 100, "USD")
    end
  end
end
