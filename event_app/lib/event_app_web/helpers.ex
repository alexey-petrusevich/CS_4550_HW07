# based on lecture notes of professor Nat Tuck

defmodule EventAppWeb.Helpers do

  # returns true if the given connection contains information about the user
  # A.K.A. is user logged in
  def have_current_user?(conn) do
    conn.assigns[:current_user] != nil
  end

  # checks if the user stored in the given connection is the same as the given user_id
  def current_user_id?(conn, user_id) do
    # retrieve user info from the connection (socket)
    user = conn.assigns[:current_user]
    # check if user ids are the same
    # if connection doesn't have user id, user is 'nil' and #false is returned
    user && user.id == user_id
  end
end