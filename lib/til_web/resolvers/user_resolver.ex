defmodule TilWeb.UserResolver do
  @moduledoc """
  This module defines the resolvers for users.
  """

  alias Til.Accounts
  alias Til.AuthHelper
  alias Til.Learnings

  def list_all(_root, _args, _info) do
    users =
      Accounts.list_users()
      |> populate_learnings

    {:ok, users}
  end

  def get_user_by_email(_root, %{email: email}, _info) do
    user = Accounts.get_user_by_email(email)
    learnings = Learnings.list_learnings(%{user_id: user.id})
    {:ok, %{user | learnings: filter_by_user_id(user.id, learnings)}}
  end

  def user_count(_root, _args, _info) do
    count = Accounts.count_users()
    {:ok, count}
  end

  def create(_root, args, _info) do
    Accounts.create_user(args)
  end

  def login(_root, %{email: email, password: password}, _info) do
    with {:ok, user} <- AuthHelper.login_with_email_pass(email, password),
         {:ok, jwt, _} <- Til.Guardian.encode_and_sign(user),
         {:ok, _} <- Til.Accounts.store_token(user, jwt) do
      {:ok, %{token: jwt, user: user}}
    end
  end

  def logout(_root, _args, %{context: %{current_user: current_user}}) do
    Til.Accounts.revoke_token(current_user, nil)
    {:ok, current_user}
  end

  def logout(_root, _args, _info) do
    {:error, "Please log in first!"}
  end

  defp populate_learnings(users) do
    learnings = Learnings.list_learnings()

    users
    |> Enum.map(fn user -> %{user | learnings: filter_by_user_id(user.id, learnings)} end)
  end

  defp filter_by_user_id(user_id, learnings) do
    learnings
    |> Enum.filter(fn learning -> learning.user_id == user_id end)
  end
end
