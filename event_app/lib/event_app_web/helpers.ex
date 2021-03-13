# based on lecture notes of professor Nat Tuck

defmodule EventAppWeb.Helpers do

  # returns true if the given connection contains information about the user
  # A.K.A. is user logged in
  def have_current_user?(conn) do
    IO.inspect("in have_current_user?")
    conn.assigns[:current_user] != nil
  end

  def is_subscriber?(conn, event) do
    user = conn.assigns[:current_user]
    # user is not logged in
    if (user == nil) do
      false
    else
      Enum.member?(event.subscribers, user.email)
    end
  end

  # returns true if logged in user is the owner of the event
  def is_owner?(conn, event) do
    user = conn.assigns[:current_user]
    user != nil && user.id == event.user_id
  end


  # checks if the user stored in the given connection is the same as the given user_id
  def current_user_id?(conn, user_id) do
    IO.inspect("in current_user_id?")
    # retrieve user info from the connection (socket)
    user = conn.assigns[:current_user]
    # check if user ids are the same
    # if connection doesn't have user id, user is 'nil' and #false is returned
    user && user.id == user_id
  end

  # returns id of the user stored within given connection (socket)
  def current_user_id(conn) do
    user = conn.assigns[:current_user]
    user && user.id
  end

  def current_event_id(conn) do
    event = conn.assigns[:event]
    event && event.id
  end

end