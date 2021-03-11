# based on lecture notes of professor Nat Tuck
defmodule EventApp.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :comments, {:map, :string}
    field :date, :utc_datetime
    field :description, :string
    field :link, :string
    field :name, :string
    field :responses, {:map, :integer}
    field :updates, {:array, :string}
    belongs_to :user, EventApp.Users.User
    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    IO.inspect("in events.changeSet")
    event
    |> cast(attrs, [:name, :date, :description, :link, :updates, :responses, :comments, :user_id])
    |> validate_required([:name, :description, :user_id])
  end


end
