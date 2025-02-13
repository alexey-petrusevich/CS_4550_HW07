# based on lecture notes of professor Nat Tuck
defmodule EventApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      EventApp.Repo,
      # Start the Telemetry supervisor
      EventAppWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: EventApp.PubSub},
      # Start the Endpoint (http/https)
      EventAppWeb.Endpoint
      # Start a worker by calling: EventApp.Worker.start_link(arg)
      # {EventApp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EventApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    EventAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
