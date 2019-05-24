defmodule Til.Learnings.Learning do
  use Ecto.Schema
  import Ecto.Changeset

  alias Til.Accounts.User


  schema "learnings" do
    field :content, :string
    field :tags, {:array, :string}
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(learning, attrs) do
    learning
    |> cast(attrs, [:content, :tags, :user])
    |> validate_required([:content, :tags, :user])
  end
end
