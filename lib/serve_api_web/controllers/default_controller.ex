defmodule ServeApiWeb.DefaultController do
  use ServeApiWeb, :controller

  def index(conn, _params) do
    text(conn, "Index API endpoint visited - #{Mix.env()}")
  end

  def health_checker(conn, _params) do
    text(conn, "Server is running in good health in #{Mix.env()} environment")
  end
end
