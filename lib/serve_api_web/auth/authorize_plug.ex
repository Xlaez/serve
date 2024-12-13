defmodule ServeApiWeb.Auth.AuthorizePlug do
  alias ServeApiWeb.Auth.ErrorResponse

  def is_authorized(%{params: %{"account" => params}} = conn, _opts) do
    if conn.assigns.account.id == params["id"] do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end
end
