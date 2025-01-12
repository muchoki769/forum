defmodule Forum.Accounts.Emails do
  @moduledoc """
  Delivers emails.
  """

  import Swoosh.Email

  def deliver_reset_password_instructions(user, url) do
    if !url do
      raise "Cannot deliver reset instructions without a url"
    end

    deliver(user.email, "Reset Your Password", """
    <html>
    <p>
    Hi #{user.email},
    </p>

    <p>
    <a href ="#{url}">Click here</a> to reset your password.
    </p>

    <p>
    If you didnt request this change, please ignore this.
    </p>
    <html>
    """)
  end

  defp deliver(to, subject, body) do
    IO.puts("Sending email to #{to} with subject #{subject} and body #{body}")

    new()
    |> from({"David", "ndungudavidmuchoki@gmail.com"})
    |> to(to_string(to))
    |> subject(subject)
    |> put_provider_option(:track_links, "None")
    |> html_body(body)
    |> Forum.Mailer.deliver!()
  end
end
