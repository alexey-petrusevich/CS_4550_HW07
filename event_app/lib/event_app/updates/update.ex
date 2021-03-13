defmodule EventApp.Updates.Update do
  use Ecto.Schema
  import Ecto.Changeset

  schema "updates" do
    field :update, :string
    #field :event_id, :id
    #field :user_id, :id
    belongs_to :event, EventApp.Events.Event
    belongs_to :user, EventApp.Users.User

    timestamps()
  end

  @doc false
  def changeset(update, attrs) do
    update
    |> cast(attrs, [:update, :event_id, :user_id])
    |> validate_required([:update, :event_id, :user_id])
  end
end
