# based on lecture notes of professor Nat Tuck
defmodule EventApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :photo_hash, :string, null: false

      timestamps()
    end

  end
end
