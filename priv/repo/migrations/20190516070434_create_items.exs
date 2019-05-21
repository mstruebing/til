defmodule Til.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :content, :string
      add :tags, {:array, :string}
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:items, [:user_id])

  end
end
