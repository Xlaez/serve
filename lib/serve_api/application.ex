defmodule ServeApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ServeApiWeb.Telemetry,
      ServeApi.Repo,
      {DNSCluster, query: Application.get_env(:serve_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ServeApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ServeApi.Finch},
      # Start a worker by calling: ServeApi.Worker.start_link(arg)
      # {ServeApi.Worker, arg},
      # Start to serve requests, typically the last entry
      ServeApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ServeApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ServeApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
