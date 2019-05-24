defmodule Til.Repo.Migrations.CreateLearnings do
  use Ecto.Migration

  def change do
    create table(:learnings) do
      add :content, :string
      add :tags, {:array, :string}
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:learnings, [:user_id])

  end
end