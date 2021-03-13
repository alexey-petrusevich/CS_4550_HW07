defmodule EventApp.Repo.Migrations.CreateUpdates do
  use Ecto.Migration

  def change do
    create table(:updates) do
      add :update, :text, null: false, default: ""
      add :event_id, references(:events, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:updates, [:event_id])
    create index(:updates, [:user_id])
  end
end
