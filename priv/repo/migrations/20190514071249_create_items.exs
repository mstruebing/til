defmodule Til.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :content, :string
      add :tags, {:array, :string}

      timestamps()
    end

  end
end
