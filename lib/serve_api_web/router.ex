defmodule ServeApiWeb.Router do
  use ServeApiWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: reason}) do
    IO.inspect(reason, label: "Unhandled error reason")
    conn |> json(%{errors: "Internal Server Error"}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug ServeApiWeb.Auth.Pipeline
    plug ServeApiWeb.Auth.SetAccount
  end

  scope "/api", ServeApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
    get "/health_checker", DefaultController, :health_checker

    post "/auth/register", AccountController, :register
  end

  scope "/api", ServeApiWeb do
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:serve_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ServeApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
