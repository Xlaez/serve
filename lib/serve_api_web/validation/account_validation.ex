# defmodule ServeApiWeb.Validation.AccountValidation.RegisterRequest do
#   use Valdi

#   schema(%{
#     email: [:string, required: true, min_length: 4, format: ~r/@/],
#     password: [:string, required: true, min_length: 6]
#   })

#   def validate_email(email) do
#     cond do
#       String.contains?(email, "+") -> {:error, "Email cannot contain '+' symbol"}
#       String.ends_with?(email, ".") -> {:error, "Email cannot end with a dot"}
#       true -> {:ok, email}
#     end
#   end
# end
