defmodule TilWeb.Schema do
  use Absinthe.Schema 

  alias TilWeb.{ItemResolver, UserResolver}

  import_types Absinthe.Type.Custom

  object :item do
    field :id, non_null(:id)
    field :content, non_null(:string)
    field :tags, non_null(list_of(non_null(:string)))
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :items, non_null(list_of(non_null(:item)))
  end

  query do
    field :all_items, non_null(list_of(non_null(:item))) do
      resolve &ItemResolver.all_items/3
    end

    field :user_items, non_null(list_of(non_null(:item))) do
      arg :user_id, non_null(:id)
      resolve &ItemResolver.user_items/3
    end

    field :all_users, non_null(list_of(non_null(:user))) do
      resolve &UserResolver.all_users/3
    end
  end
end
