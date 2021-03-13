# based on lecture notes of professor Nat Tuck
defmodule EventAppWeb.UserController do
  use EventAppWeb, :controller

  alias EventApp.Users
  alias EventApp.Users.User
  alias EventApp.Photos
  alias EventAppWeb.Plugs
  plug Plugs.RequireUser when action in [:edit, :update, :delete, :show]
  #plug :require_owner when action in [:edit, :update, :delete, :show]


  # INDEX
  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  # NEW
  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end


  # CREATE
  def create(conn, %{"user" => user_params}) do
    # retrieve uploaded photo from user_params
    up = user_params["photo"]
    # save photo
    {:ok, hash} = Photos.save_photo(up.filename, up.path)
    # update user params with id and photo_hash
    user_params = user_params
                  #|> Map.put("id", conn.assigns[:current_user].id)
                  |> Map.put("photo_hash", hash)

    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # SHOW
  def show(conn, %{"id" => id}) do
    IO.inspect("show")
    user = Users.get_user!(id)
    render(conn, "show.html", user: user)
  end

  # EDIT
  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  # UPDATE
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    # retrieve photo from user_params
    up = user_params["photo"]

    user_params = if (up) do
      {:ok, hash} = Photos.save_photo(up.filename, up.path)
      Map.put(user_params, "photo_hash", hash)
    else
      user_params
    end

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  # DELETE
  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end


  def photo(conn, %{"id" => id}) do
    IO.inspect("in user controller photo method")
    user = Users.get_user!(id)
    {:ok, _name, data} = Photos.load_photo(user.photo_hash)
    conn
    |> put_resp_content_type("image/jpeg")
    |> send_resp(200, data)
  end


  def require_owner(conn, _args) do
    user = conn.assigns[:current_user]
    event = conn.assigns[:event]
    if (user.id == event.user_id) do
      conn
    else
      conn
      |> put_flash(:error, "You're not the owner of this profile")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
