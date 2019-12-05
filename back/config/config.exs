# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :kata_master,
  ecto_repos: [KataMaster.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :kata_master, KataMasterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "etz2Fyimgwj6ikPNlqDSYnJuHUfqlNdigdqS+jC35AWUY0vbqvaH10Wz0AGoYSLZ",
  render_errors: [view: KataMasterWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: KataMaster.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Ueberauth Strategies
config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [send_redirect_uri: false]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
