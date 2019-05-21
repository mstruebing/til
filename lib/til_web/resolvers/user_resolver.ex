defmodule TilWeb.UserResolver do
  alias Til.Accounts
  alias Til.Learnings

  def all_users(_root, _args, _info) do
    users = populate_items(Accounts.list_users)
    {:ok, users}
  end

  defp filter_by_user_id(user_id, items) do
    Enum.filter(items, fn item -> item.user_id == user_id end)
  end

  defp populate_items(users) do
    items = Learnings.list_items
    Enum.map(users, fn user -> %{user | items: filter_by_user_id(user.id, items)} end)
  end
end
