defmodule ServeApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :serve_api,
    module: ServeApiWeb.Auth.Guardian,
    error_handler: ServeApiWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
