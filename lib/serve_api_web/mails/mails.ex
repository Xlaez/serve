defmodule ServeApiWeb.Mails.Mails do
  import Swoosh.Email

  @spec welcome(any(), String) :: Swoosh.Email.t()
  def welcome(user, otp) do
    new()
    |> to({user.name, user.email})
    |> from({"Serve<no reply>", "info@dolphjs.com"})
    |> subject("Welcome to Serve NG")
    |> html_body(welcome_html_body(user, otp))
  end

  defp welcome_html_body(user, otp) do
    """
    <div style="font-family: Arial, sans-serif; text-align: center; background-color: #f9f9f9; padding: 20px;">
      <div style="max-width: 600px; margin: auto; background: #ffffff; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);">
        <div style="background-color: #4CAF50; color: white; padding: 20px;">
          <h1>Welcome to Serve NG!</h1>
        </div>
        <div style="padding: 20px; color: #555;">
          <p style="font-size: 18px; line-height: 1.5;">
            Hi <strong>#{user.name}</strong>, <br><br>
            We're thrilled to have you join us! 🎉 To get started, please use the OTP below to verify your email address.
          </p>
          <div style="margin: 20px 0; font-size: 22px; font-weight: bold; color: #333;">
            Your OTP: <span style="background: #f4f4f4; padding: 10px 20px; border-radius: 5px; display: inline-block; letter-spacing: 2px;">#{otp}</span>
          </div>
          <p style="font-size: 16px; line-height: 1.5;">
            This code is valid for the next 15 minutes. If you didn’t request this email, please ignore it.
          </p>
          <p style="font-size: 14px; color: #888;">
            Stay awesome, <br>
            The Serve NG Team 💚
          </p>
        </div>
        <div style="background-color: #f1f1f1; color: #666; padding: 15px; font-size: 12px;">
          Need help? Contact us at <a href="mailto:info@dolphjs.com" style="color: #4CAF50;">info@dolphjs.com</a>
        </div>
      </div>
    </div>
    """
  end
end
