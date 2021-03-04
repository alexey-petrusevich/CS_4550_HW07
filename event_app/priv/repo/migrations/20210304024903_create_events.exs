defmodule EventApp.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, null: false
      add :date, :utc_datetime, null: false
      add :description, :text, null: false
      add :link, :string, null: false
      add :updates, {:array, :text}, null: false
      add :responses, {:map, :integer}, null: false
      add :comments, {:map, :text}, null: false

      timestamps()
    end

  end
end
