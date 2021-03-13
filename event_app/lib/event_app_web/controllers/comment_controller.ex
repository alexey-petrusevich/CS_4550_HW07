defmodule EventAppWeb.CommentController do
  use EventAppWeb, :controller

  alias EventApp.Comments
  alias EventApp.Comments.Comment

  # INDEX
  def index(conn, _params) do
    comments = Comments.list_comments()
    render(conn, "index.html", comments: comments)
  end

  # NEW
  def new(conn, _params) do
    changeset = Comments.change_comment(%Comment{})
    render(conn, "new.html", changeset: changeset)
  end

  # CREATE
  def create(conn, %{"comment" => comment_params}) do
    comment_params = comment_params
                     |> Map.put("user_id", current_user_id(conn))
    IO.inspect("creating new comment")
    IO.inspect(comment_params)
    case Comments.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # SHOW
  def show(conn, %{"id" => id}) do

    comment = Comments.get_comment!(id)
    render(conn, "show.html", comment: comment)
  end

  # EDIT
  def edit(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    changeset = Comments.change_comment(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  # UPDATE
  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Comments.get_comment!(id)

    case Comments.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  # DELETE
  def delete(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    {:ok, _comment} = Comments.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.comment_path(conn, :index))
  end
end
