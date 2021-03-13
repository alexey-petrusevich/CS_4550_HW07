# based on lecture notes of professor Nat Tuck
defmodule EventApp.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :date, :utc_datetime
    field :description, :string
    field :link, :string
    field :name, :string
    field :responses, {:map, :integer}
    field :updates, {:array, :string}
    belongs_to :user, EventApp.Users.User
    has_many :comments, EventApp.Comments.Comment
    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :date, :description, :link, :updates, :responses, :comments, :user_id])
    |> validate_required([:name, :description, :user_id])
  end


end
