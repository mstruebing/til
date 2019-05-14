defmodule Til.Learnings.Item do
  use Ecto.Schema
  import Ecto.Changeset


  schema "items" do
    field :content, :string
    field :tags, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:content, :tags])
    |> validate_required([:content, :tags])
  end
end
