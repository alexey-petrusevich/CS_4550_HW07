# based on lecture notes of professor Nat Tuck
defmodule EventApp.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias EventApp.Repo

  alias EventApp.Events.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    IO.inspect("events.create_event")
    IO.inspect(attrs)
    val = %Event{}
    |> Event.changeset(attrs)
    IO.inspect("called changeset")
    IO.inspect(val)
    IO.inspect("calling insert")
    val = val
    |> Repo.insert()
    IO.inspect("inserted to repo")
    IO.inspect(val)
    val
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change_event(%Event{} = event, attrs \\ %{}) do
    Event.changeset(event, attrs)
  end

  # Retrieves all the events from the repo and preloads them
  def list_events do
    Repo.all(Event)
    |> Repo.preload(:user)
  end

  # preloads comments for the given event
  def load_comments(%Event{} = event) do
    Repo.preload(event, [comments: :user])
  end


  # preloads responses for the given event
  def load_responses(%Event{} = event) do
    Repo.preload(event, [responses: :user])
  end

  # preloads updates for the given event
  def load_updates(%Event{} = event) do
    Repo.preload(event, [updates: :user])
  end
end
