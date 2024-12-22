defmodule ServeApiWeb.AccountController do
  use ServeApiWeb, :controller

  require Logger

  alias ServeApiWeb.Helpers.Sanitizers
  alias ServeApiWeb.Mails
  alias ServeApiWeb.Helpers.OtpHelper
  alias ServeApi.{Account, Account.Account}
  alias ServeApiWeb.{Auth.Guardian, Auth.ErrorResponse, AccountJSON}
  alias OtpHelper
  alias Mails.Mails

  import ServeApiWeb.Auth.AuthorizePlug

  plug :is_authorized when action in [:update, :delete]

  action_fallback ServeApiWeb.FallbackController

  def email_available(conn, %{"email" => email}) do
    case ServeApi.Account.get_account_by_email!(email) do
      nil ->
        conn
        |> put_status(:ok)
        |> json(%{message: "Email is available"})

      %ServeApi.Account.Account{} ->
        conn
        |> put_status(:conflict)
        |> json(%{message: "Email is already taken"})
    end
  end

  def register(conn, params) do
    account_params = %{
      email: params["email"],
      password: params["password"],
      first_name: params["first_name"],
      last_name: params["last_name"]
    }

    case ServeApi.Account.get_account_by_email!(account_params.email) do
      nil ->
        with {:ok, %Account{} = account} <- ServeApi.Account.create_account(account_params) do
          #   authorize_account(conn, account.email, account_params["password"])
          # else
          #   {:error, changeset} ->
          #     conn
          #     |> put_status(:unprocessable_entity)
          #     |> render(:error, changeset: changeset)
          otp = to_string(OtpHelper.generate_otp())

          case Mails.welcome(account, otp) |> ServeApi.Mailer.deliver() do
            {:ok, _response} ->
              conn
              |> put_status(:created)
              |> json(%{
                message: "Account created successfully",
                account: Sanitizers.sanitize_account(account)
              })

            {:error, reason} ->
              Logger.error("Failed to send email: #{inspect(reason)}")

              conn
              |> put_status(:internal_server_error)
              |> json(%{error: "Failed to send email"})
          end
        else
          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(:error, changeset: changeset)
        end

      %Account{} = _account ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Account already exists"})
    end
  end

  defp authorize_account(conn, email, password) do
    case Guardian.authenticate(email, password) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:account_token, account: account, token: token)

      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Invalid credentials"
    end
  end
end
