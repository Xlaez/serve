defmodule ServeApiWeb.Helpers.OtpHelper do
  @moduledoc """
  Helper module for generating One-time-passwords
  """

  @doc """
  Generates a random 6-digit OTP

   ## Examples

      iex> OTPHelper.generate_otp()
      123456
  """

  def generate_otp do
    :crypto.strong_rand_bytes(4)
    |> :binary.decode_unsigned()
    |> rem(1_000_000)
    |> Integer.to_string()
    |> String.pad_leading(6, "0")
  end
end
