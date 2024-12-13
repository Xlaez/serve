defmodule ServeApiWeb.AccountController do
  use ServeApiWeb, :controller

  require Logger
  alias ServeApi.{Account, Account.Account}
  alias ServeApiWeb.{Auth.Guardian, Auth.ErrorResponse, AccountJSON}

  import ServeApiWeb.Auth.AuthorizePlug

  plug :is_authorized when action in [:update, :delete]

  action_fallback ServeApiWeb.FallbackController

  def register(conn, %{"account" => account_params}) do
    # existing_account = ServeApi.Account.get_account_by_email!(account_params.email)
    # Logger.info(existing_account)
    # case existing_account do
    #   {:error, :notallowed} ->
    #     raise ErrorResponse.NotAcceptable, message: "An account with this email exists."
    # end

    with {:ok, %Account{} = account} <- ServeApi.Account.create_account(account_params) do
      authorize_account(conn, account.email, account_params["password"])
    end
  end

  defp authorize_account(conn, email, password) do
    case Guardian.authenticate(email, password) do
      {:ok, account, token} ->
        conn
        |> Plug.conn().put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:account_token, account: account, token: token)

      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Invalid credentials"
    end
  end
end
