defmodule Forum.Accounts.User do
  use Ash.Resource,
    domain: Forum.Accounts,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication]

  attributes do
    uuid_primary_key :id

    attribute :email, :ci_string do
      allow_nil? false
      public? true
    end

    attribute :hashed_password, :string, allow_nil?: false, sensitive?: true
  end

  authentication do
    strategies do
      password :password do
        identity_field :email

        resettable do
          sender Forum.Accounts.User.Senders.SendPasswordResetEmail
        end
      end
    end

    tokens do
      enabled? true
      token_resource Forum.Accounts.Token
      signing_secret Forum.Accounts.Secrets
    end
  end

  postgres do
    table "users"
    repo Forum.Repo
  end

  identities do
    identity :unique_email, [:email]
  end
end
