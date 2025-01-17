defmodule TilWeb.Schema do
  @moduledoc """
  This module defines the used GraphQL schema.
  """

  use Absinthe.Schema

  alias TilWeb.{LearningResolver, UserResolver}

  import_types(Absinthe.Type.Custom)

  object :learning do
    field(:id, non_null(:id))
    field(:author, non_null(:string))
    field(:title, non_null(:string))
    field(:content, non_null(:string))
    field(:tags, non_null(list_of(non_null(:string))))
    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)
    field(:user_id, non_null(:string))
  end

  object :user do
    field(:id, non_null(:id))
    field(:email, non_null(:string))
    field(:handle, non_null(:string))
    field(:learnings, non_null(list_of(non_null(:learning))))
  end

  object :session do
    field(:token, :string)
    field(:user, :user)
  end

  query do
    field :learnings, non_null(list_of(non_null(:learning))) do
      resolve(&LearningResolver.list_all/3)
    end

    field :users, non_null(list_of(non_null(:user))) do
      resolve(&UserResolver.list_all/3)
    end

    field :get_user_by_email, :user do
      arg(:email, non_null(:string))
      resolve(&UserResolver.get_user_by_email/3)
    end

    field :user_count, non_null(:integer) do
      resolve(&UserResolver.user_count/3)
    end

    field :learnings_by_tag, non_null(list_of(non_null(:learning))) do
      arg(:tag, non_null(:string))
      resolve(&LearningResolver.learnings_by_tag/3)
    end

    field :learnings_by_user_id, non_null(list_of(non_null(:learning))) do
      arg(:user_id, non_null(:id))
      resolve(&LearningResolver.learnings_by_user_id/3)
    end

    field :learnings_by_user, non_null(list_of(non_null(:learning))) do
      arg(:handle, non_null(:string))
      resolve(&LearningResolver.learnings_by_user/3)
    end

    field :learning_count, non_null(:integer) do
      resolve(&LearningResolver.learning_count/3)
    end
  end

  mutation do
    field :create_user, :user do
      arg(:email, non_null(:string))
      arg(:handle, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&UserResolver.create/3)
    end

    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&UserResolver.login/3)
    end

    field :logout, :user do
      resolve(&UserResolver.logout/3)
    end

    field :create_learning, :learning do
      arg(:title, non_null(:string))
      arg(:content, non_null(:string))
      arg(:private, :boolean)
      arg(:tags, non_null(list_of(non_null(:string))))

      resolve(&LearningResolver.create/3)
    end
  end
end
