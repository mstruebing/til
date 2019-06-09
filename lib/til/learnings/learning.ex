defmodule Til.Learnings.Learning do
  use Ecto.Schema
  import Ecto.Changeset

  alias Til.Accounts.User

  schema "learnings" do
    field(:content, :string)
    field(:tags, {:array, :string})
    belongs_to(:user, User, foreign_key: :user_id)

    timestamps()
  end

  @doc false
  def changeset(learning, attrs) do
    IO.inspect(learning)
    IO.inspect(attrs)

    learning
    |> cast(attrs, [:content, :tags, :user_id])
    |> validate_required([:content, :tags, :user_id])
  end
end
