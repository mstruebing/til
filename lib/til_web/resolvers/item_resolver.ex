defmodule TilWeb.ItemResolver do
  alias Til.Learnings

  def all_items(_root, _args, _info) do
    items = Learnings.list_items
    {:ok, items}
  end

  def user_items(_root, args, _info) do
    # Refactor to do in the Repothingy
    items = Enum.filter(Learnings.list_items, fn item -> Integer.to_string(item.user_id) == args.user_id end)
    {:ok, items}
  end
end
