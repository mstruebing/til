defmodule TilWeb.ItemResolver do
  alias Til.Learnings

  def all_items(_root, _args, _info) do
    items = Learnings.list_items
    IO.inspect(items)
    {:ok, items}
  end
end
