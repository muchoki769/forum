defmodule Forum.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ForumWeb.Telemetry,
      Forum.Repo,
      {DNSCluster, query: Application.get_env(:forum, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Forum.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Forum.Finch},
      {AshAuthentication.Supervisor, otp_app: :Forum},
      # Start a worker by calling: Forum.Worker.start_link(arg)
      # {Forum.Worker, arg},
      # Start to serve requests, typically the last entry
      ForumWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Forum.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ForumWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
