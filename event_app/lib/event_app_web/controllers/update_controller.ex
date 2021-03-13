defmodule EventAppWeb.UpdateController do
  use EventAppWeb, :controller

  alias EventApp.Updates
  alias EventApp.Updates.Update

  def index(conn, _params) do
    updates = Updates.list_updates()
    render(conn, "index.html", updates: updates)
  end

  def new(conn, _params) do
    changeset = Updates.change_update(%Update{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"update" => update_params}) do
    update_params = update_params
                      |> Map.put("user_id", current_user_id(conn))
    case Updates.create_update(update_params) do
      {:ok, update} ->
        conn
        |> put_flash(:info, "Update created successfully.")
        |> redirect(to: Routes.update_path(conn, :show, update))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    update = Updates.get_update!(id)
    render(conn, "show.html", update: update)
  end

  def edit(conn, %{"id" => id}) do
    update = Updates.get_update!(id)
    changeset = Updates.change_update(update)
    render(conn, "edit.html", update: update, changeset: changeset)
  end

  def update(conn, %{"id" => id, "update" => update_params}) do
    update = Updates.get_update!(id)

    case Updates.update_update(update, update_params) do
      {:ok, update} ->
        conn
        |> put_flash(:info, "Update updated successfully.")
        |> redirect(to: Routes.update_path(conn, :show, update))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", update: update, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    update = Updates.get_update!(id)
    {:ok, _update} = Updates.delete_update(update)

    conn
    |> put_flash(:info, "Update deleted successfully.")
    |> redirect(to: Routes.update_path(conn, :index))
  end
end
