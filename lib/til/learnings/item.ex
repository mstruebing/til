defmodule Til.Learnings.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Til.Accounts.User


  schema "items" do
    field :content, :string
    field :tags, {:array, :string}
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:content, :tags, :user])
    |> validate_required([:content, :tags, :user])
  end
end
