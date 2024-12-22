# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :serve_api,
  ecto_repos: [ServeApi.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :serve_api, ServeApiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: ServeApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ServeApi.PubSub,
  live_view: [signing_salt: "Bjvzykqq"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# if config_env() in [:dev, :test] do
#   if File.exists?(".env") do
#     Dotenv.load()
#   else
#     IO.puts("Could not load .env file")
#   end
# end

config :serve_api, ServeApiWeb.Auth.Guardian,
  issuer: "serve_api",
  secret_key: "UkZ3UAXuMoTto9DNHbXs0YNouFL0SSRP2ObHncg6SA2UaVdvQ+wQBEyLlc8F+doE"

config :guardian, Guardian.DB,
  repo: ServeApi.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
