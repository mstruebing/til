defmodule Til.Accounts.User do
  @moduledoc """
  This module defines the user dataset.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Til.Learnings.Learning

  schema "users" do
    field(:email, :string)
    field(:handle, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:token, :string)

    has_many(:learnings, Learning)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :handle])
    |> validate_required([:email, :password, :handle])
    |> validate_length(:handle, min: 3, max: 10)
    |> validate_length(:password, min: 5)
    |> unique_constraint(:email, donwcase: true)
    |> unique_constraint(:handle, donwcase: true)
    |> put_password_hash()
  end

  def store_token_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:token])
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
