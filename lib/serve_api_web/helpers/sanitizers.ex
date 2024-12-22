defmodule ServeApiWeb.Helpers.Sanitizers do
  @doc """
  Removes sensitive fields like `password` from an account map or struct.

  ## Examples

      iex> sanitize_account(%{id: 1, email: "user@example.com", password: "secret"})
      %{id: 1, email: "user@example.com"}

  """
  def sanitize_account(account) when is_map(account) do
    Map.drop(account, [:password])
  end
end
