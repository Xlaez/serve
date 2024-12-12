defmodule ServeApi.Repo do
  use Ecto.Repo,
    otp_app: :blog_api,
    adapter: Ecto.Adapters.Postgres
end
