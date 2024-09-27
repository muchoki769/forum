defmodule Forum.Accounts do
  use Ash.Domain

  resources do
    resource Forum.Accounts.User
    resource Forum.Accounts.Token
  end
end
