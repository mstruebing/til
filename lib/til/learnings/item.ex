defmodule Til.Learnings.Item do
  use Ecto.Schema
  import Ecto.Changeset


  schema "items" do
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
