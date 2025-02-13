# based on lecture notes of professor Nat Tuck
defmodule EventApp.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :name, :string
    field :date, :utc_datetime
    field :description, :string
    field :link, :string
    # subscriber emails
    field :subscribers, {:array, :string}
    belongs_to :user, EventApp.Users.User
    has_many :comments, EventApp.Comments.Comment
    has_many :responses, EventApp.Responses.Response
    has_many :updates, EventApp.Updates.Update
    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :date, :description, :link, :subscribers, :user_id])
    |> validate_required([:name, :description, :user_id])
  end


end
