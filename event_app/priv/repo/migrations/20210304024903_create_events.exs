# based on lecture notes of professor Nat Tuck
defmodule EventApp.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, null: false, default: ""
      add :date, :utc_datetime, null: true
      add :description, :text, null: false, default: ""
      add :link, :string, null: false, default: ""
      add :subscrbers, {:array, :string}, null: false
      # foreign key that references users table
      add :user_id, references(:users), null: false
      timestamps()
    end

  end
end
