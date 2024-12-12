defmodule ServeApi.Account do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias ServeApi.Repo

  alias ServeApi.Account.Account

  @doc """
  Returns the list of accounts
  """
  def list_accounts do
    Repo.all(Account)
  end

  @doc """
  Get a single account by id.
  """
  def get_account_by_id!(id) do
    Repo.get!(Account, id)
  end

  def get_full_account!(id) do
    Account
    |> where(id: ^id)
    |> Repo.one()
  end

  @doc """
  Get's a single account with email
  """
  def get_account_by_email!(email) do
    Account
    |> where(email: ^email)
    |> Repo.one()
  end

  @doc """
  Creates a new account in the account db
  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update an account.
  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{data: %Account{}}

  """
  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end
end
