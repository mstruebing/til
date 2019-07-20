defmodule Til.Learnings.Learning do
  @moduledoc """
  This module defines the learning dataset.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Til.Accounts.User

  schema "learnings" do
    field(:title, :string)
    field(:content, :string)
    field(:private, :boolean)
    field(:tags, {:array, :string})

    belongs_to(:user, User, foreign_key: :user_id)

    timestamps()
  end

  @doc false
  def changeset(learning, attrs) do
    learning
    |> cast(attrs, [:title, :content, :tags, :user_id, :private])
    |> validate_required([:title, :content, :tags, :user_id])
  end
end
