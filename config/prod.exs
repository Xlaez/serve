import Config

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: ServeApi.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

# if File.exists?(".env") do
#   try do
#     Dotenv.load()
#   rescue
#     _ -> IO.puts("Could not load .env file")
#   end
# end
