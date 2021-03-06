# based on lecture notes of professor Nat Tuck
defmodule EventAppWeb.SessionController do
  use EventAppWeb, :controller

  def create(conn, %{"name" => name, "email" => email}) do
    # changed search by both username and email
    user = EventApp.Users.get_user_by_name_and_email(name, email)
    # if user not nil, store session and redirect back to index
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back #{user.name}")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Login failed.")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end