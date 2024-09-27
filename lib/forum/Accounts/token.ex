defmodule Forum.Accounts.Token do
  use Ash.Resource,
    domain: Forum.Accounts,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication.TokenResource]

  postgres do
    table "tokens"
    repo Forum.Repo
  end
end
