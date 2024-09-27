defmodule Forum.Repo do
  use AshPostgres.Repo,
    otp_app: :forum,
    adapter: Ecto.Adapters.Postgres

  def installed_extensions do
    ["ash-functions", "uuid-ossp", "citext"]
  end
end
