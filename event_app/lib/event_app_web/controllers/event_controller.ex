# based on lecture notes of professor Nat Tuck
defmodule EventAppWeb.EventController do
  use EventAppWeb, :controller

  alias EventApp.Events
  alias EventApp.Events.Event
  alias EventAppWeb.Plugs
  plug :fetch_event when action in [:show, :edit, :update, :delete]
  plug Plugs.RequireUser when action in [:new, :edit, :update, :delete]
  plug :require_owner when action in [:edit, :update, :delete]


  def require_owner(conn, _args) do
    # retrieve user info from connection (socket)
    user = conn.assigns[:current_user]
    # retrieve event stored in the connection (socket)
    event = conn.assigns[:event]

    # check if id of the logged in user is the same as the id of the event stored in the connection
    if (user.id == event.user_id) do
      # match - event has belongs to the logged in user
      conn
    else
      # else ids are different --> error
      conn
      |> put_flash(:error, "That isn't yours.")
        # redirect to the index page
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  # fetches an event given the connection (with stored user id)
  def fetch_event(conn, _args) do
    # retrieve event from the connection (socket)
    id = conn.params["id"]
    # retrieve event from the database
    event = Events.get_event!(id)
    # store event info in the socket
    assign(conn, :event, event)
  end


  # require login verification for /events/new, /events/edit, /events/create, and /events/update
  # redirect to index if failed to verify
  plug Plugs.RequireUser when action in [:new, :edit, :create, :update]

  # INDEX
  def index(conn, _params) do
    events = Events.list_events()
    render(conn, "index.html", events: events)
  end

  # NEW
  def new(conn, _params) do
    changeset = Events.change_event(%Event{})
    render(conn, "new.html", changeset: changeset)
  end

  # CREATE
  def create(conn, %{"event" => event_params}) do
    IO.inspect(event_params)
    IO.inspect("added value to map")
    IO.inspect(event_params)

    # add user_id to the new post
    event_params = event_params
                   |> Map.put("user_id", conn.assigns[:current_user].id)

    case Events.create_event(event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # SHOW
  def show(conn, %{"id" => id}) do
    #event = Events.get_event!(id)
    # retrieve event from the connection (socket)
    event = conn.assigns[:event]
            # and pass it for loading comments
            |> Events.load_comments()
      # load event responses
            |> Events.load_responses()
      # load event updates
            |> Events.load_updates()


    comm = %EventApp.Comments.Comment{
      event_id: event.id,
      user_id: current_user_id(conn)
    }
    new_comment = Comments.change_comment(comm)

    resp = %EventApp.Responses.Response{
      event_id: event.id,
      user_id: current_user_id(conn)
    }
    new_response = Responses.change_response(resp)

    resp = %EventApp.Updates.Update{
      event_id: event.id,
      user_id: current_user_id(conn)
    }
    new_update = Updates.change_update(resp)


    render(
      conn,
      "show.html",
      event: event,
      new_comment: new_comment,
      new_response: new_response,
      new_update: new_update
    )
  end

  # EDIT
  def edit(conn, %{"id" => id}) do
    #event = Events.get_event!(id)
    # retrieve event from the connection (socket)
    event = conn.assigns[:event]
    changeset = Events.change_event(event)
    render(conn, "edit.html", event: event, changeset: changeset)
  end

  # UPDATE
  def update(conn, %{"id" => id, "event" => event_params}) do
    #event = Events.get_event!(id)
    # retrieve event from the connection (socket)
    event = conn.assigns[:event]

    case Events.update_event(event, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  # DELETE
  def delete(conn, %{"id" => id}) do
    #event = Events.get_event!(id)
    # retrieve event from the connection (socket)
    event = conn.assigns[:event]
    {:ok, _event} = Events.delete_event(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: Routes.event_path(conn, :index))
  end
end
