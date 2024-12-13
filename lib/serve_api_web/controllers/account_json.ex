defmodule ServeApiWeb.AccountJSON do
  alias ServeApi.Account.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  def account_token(%{account: account, token: token}) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      first_name: account.first_name,
      last_name: account.last_name,
      other_name: account.other_name,
      img_url: account.img_url,
      country: account.country,
      city: account.city,
      phone: account.phone,
      type: account.type,
      login_type: account.login_type,
      device_tokens: account.device_tokens
    }
  end

  def full_account(%{account: account}) do
    %{
      id: account.id,
      email: account.email,
      first_name: account.first_name,
      last_name: account.last_name,
      other_name: account.other_name,
      img_url: account.img_url,
      country: account.country,
      city: account.city,
      phone: account.phone,
      type: account.type,
      login_type: account.login_type,
      device_tokens: account.device_tokens
    }
  end
end
