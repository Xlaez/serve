defmodule ServeApi.Repo do
  use Ecto.Repo,
    otp_app: :serve_api,
    adapter: Ecto.Adapters.Postgres
end
