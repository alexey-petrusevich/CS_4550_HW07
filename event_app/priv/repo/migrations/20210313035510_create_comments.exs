defmodule EventApp.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :comment, :text, null: false, default: ""
      add :event_id, references(:events, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:comments, [:event_id])
    create index(:comments, [:user_id])
  end
end
