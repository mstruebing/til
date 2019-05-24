defmodule TilWeb.Schema do
  use Absinthe.Schema 

  alias TilWeb.{LearningResolver, UserResolver}

  import_types Absinthe.Type.Custom

  object :learning do
    field :id, non_null(:id)
    field :content, non_null(:string)
    field :tags, non_null(list_of(non_null(:string)))
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :learnings, non_null(list_of(non_null(:learning)))
  end

  query do
    field :all_learnings, non_null(list_of(non_null(:learning))) do
      resolve &LearningResolver.all_learnings/3
    end

    field :user_learnings, non_null(list_of(non_null(:learning))) do
      arg :user_id, non_null(:id)
      resolve &LearningResolver.user_learnings/3
    end

    field :all_users, non_null(list_of(non_null(:user))) do
      resolve &UserResolver.all_users/3
    end
  end
end
