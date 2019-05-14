defmodule TilWeb.Schema do
  use Absinthe.Schema 

  alias TilWeb.ItemResolver

  import_types Absinthe.Type.Custom

  object :item do
    field :id, non_null(:id)
    field :content, non_null(:string)
    field :tags, non_null(list_of(non_null(:string)))
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime

  end

  query do
    field :all_items, non_null(list_of(non_null(:item))) do
      resolve &ItemResolver.all_items/3
    end
  end
end
