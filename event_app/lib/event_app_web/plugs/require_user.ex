# based on lecture notes of professor Nat Tuck
defmodule EventAppWeb.Plugs.RequireUser do
  use EventAppWeb, :controller

  def init(args), do: args

  def call(conn, _args) do
    if (conn.assigns[:current_user]) do
      # if connection (socket) contains info about current user, allow connection
      conn
      else
      # otherwise, connection has no user info == user is not logged in
      conn
      # display error
      |> put_flash(:error, "You must log in to do that.")
      # redirect to index page
      |> redirect(to: Routes.page_path(conn, :index))
      # halt the plug pipeline by preventing plugs downstream?? (see elixir docs)
      |> halt()
    end
  end
end