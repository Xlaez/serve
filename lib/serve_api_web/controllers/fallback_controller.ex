defmodule ServeApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.
  """

  use ServeApiWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ServeApiWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: ServeApiWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, unexpected_value) do
    conn
    |> put_status(:internal_server_error)
    |> json(%{error: "Unhandled error", value: inspect(unexpected_value)})
  end
end
