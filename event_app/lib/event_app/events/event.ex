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

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    IO.inspect("in events.changeSet")
    event
    |> cast(attrs, [:name, :date, :description, :link, :updates, :responses, :comments])
    |> validate_required([:name, :date, :description, :link])
  end
end
