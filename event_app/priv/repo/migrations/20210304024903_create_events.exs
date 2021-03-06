defmodule EventApp.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, null: false
      add :date, :utc_datetime, null: false
      add :description, :text, null: false
      add :link, :string, null: false
      add :updates, {:array, :text}, null: true
      add :responses, {:map, :integer}, null: true
      add :comments, {:map, :text}, null: true

      timestamps()
    end

  end
end
