defmodule ServeApiWeb.Auth.Guardian do
  use Guardian, otp_app: :serve_api
  alias ServeApi.Account

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Account.get_account_by_id!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :no_id_provided}
  end

  def authenticate(email, password) do
    case Account.get_account_by_email!(email) do
      nil ->
        {:error, :unauthorized}

      account ->
        case validate_password(password, account.password) do
          true -> create_token(account, :access)
          false -> {:error, :unauthorized}
        end
    end
  end

  def authenticate(token) do
    with {:ok, claims} <- decode_and_verify(token),
         {:ok, account} <- resource_from_claims(claims),
         {:ok, _old, {new_token, _claims}} <- refresh(token) do
      {:ok, account, new_token}
    end
  end

  def validate_password(pure_string, hashed_password) do
    Bcrypt.verify_pass(pure_string, hashed_password)
  end

  def create_token(account, type) do
    {:ok, token, _claims} = encode_and_sign(account, %{}, token_options(type))
    {:ok, account, token}
  end

  def create_token_and_set_cookie(account, type) do
    {:ok, token, claims} = encode_and_sign(account, %{}, token_options(type))
    {:ok, account, token, claims}
  end

  defp token_options(type) do
    case type do
      :access -> [token_type: "access", ttl: {5, :hour}]
      :reset -> [token_type: "reset", ttl: {15, :minute}]
    end
  end

  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["type"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
    end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end

  def set_auth_cookie(conn, token) do
    conn
    |> Plug.Conn.put_resp_cookie("auth_token", token,
      http_only: true,
      # Update on prod
      secure: false,
      same_site: "Strict",
      max_age: 5 * 60 * 60
    )
  end

  def clear_auth_cookie(conn) do
    Plug.Conn.delete_resp_cookie(conn, "auth_token")
  end
end
