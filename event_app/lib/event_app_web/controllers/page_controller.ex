# based on lecture notes of professor Nat Tuck
defmodule EventAppWeb.PageController do
  use EventAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
