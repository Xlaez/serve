defmodule ServeApiWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized Request", plug_status: 401
end

defmodule ServeApiWeb.Auth.ErrorResponse.Forbidden do
  defexception message: "Access Forbidden", plug_status: 403
end

defmodule ServeApiWeb.Auth.ErrorResponse.NotFound do
  defexception message: "Resource Not Found", plug_status: 404
end

defmodule ServeApiWeb.Auth.ErrorResponse.NotAcceptable do
  defexception message: "Request Not Accepted", plug_status: 422
end
