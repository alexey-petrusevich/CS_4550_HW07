# based on lecture notes of professor Nat Tuck
defmodule EventApp.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, null: false
      add :date, :utc_datetime, null: true
      add :description, :text, null: false
      add :link, :string, null: true
      add :updates, {:array, :text}, null: true
      add :responses, {:map, :integer}, null: true
#      foreign key that references users table
      add :user_id, references(:users), null: false
      timestamps()
    end

  end
end
