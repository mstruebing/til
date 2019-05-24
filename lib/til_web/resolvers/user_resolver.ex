defmodule TilWeb.UserResolver do
  alias Til.Accounts
  alias Til.Learnings

  def all_users(_root, _args, _info) do
    users = populate_learnings(Accounts.list_users)
    {:ok, users}
  end

  defp filter_by_user_id(user_id, learnings) do
    Enum.filter(learnings, fn learning -> learning.user_id == user_id end)
  end

  defp populate_learnings(users) do
    learnings = Learnings.list_learnings
    Enum.map(users, fn user -> %{user | learnings: filter_by_user_id(user.id, learnings)} end)
  end
end
