# based on lecture notes of professor Nat Tuck
defmodule EventApp.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :photo_hash, :string # for storing user photo
    #belongs_to :user, EventApp.Users.User
    has_many :events, EventApp.Events.Event
    has_many :comments, EventApp.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    # cast fields to potgresql format
    |> cast(attrs, [:name, :email, :photo_hash])
    # validate null: false, etc.
    |> validate_required([:name, :email, :photo_hash])
  end
end
