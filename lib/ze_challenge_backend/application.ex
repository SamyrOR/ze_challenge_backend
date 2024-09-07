defmodule ZeChallengeBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ZeChallengeBackendWeb.Telemetry,
      ZeChallengeBackend.Repo,
      {DNSCluster, query: Application.get_env(:ze_challenge_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ZeChallengeBackend.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ZeChallengeBackend.Finch},
      # Start a worker by calling: ZeChallengeBackend.Worker.start_link(arg)
      # {ZeChallengeBackend.Worker, arg},
      # Start to serve requests, typically the last entry
      ZeChallengeBackendWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ZeChallengeBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ZeChallengeBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
