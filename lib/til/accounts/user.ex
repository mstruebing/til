defmodule Til.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Til.Learnings.Learning


  schema "users" do
    field :email, :string
    field :password_hash, :string

    has_many :learnings, Learning

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password_hash])
    |> validate_required([:email, :password_hash])
    |> unique_constraint(:email)
  end
end
