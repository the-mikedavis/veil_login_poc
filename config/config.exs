# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :one,
  ecto_repos: [One.Repo]

# Configures the endpoint
config :one, OneWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3N60F8q9uV5pGrD251gN1eiWWA0zaHaCMGyrjZhtVS8ujYjdtzerm843S8EXPiC8",
  render_errors: [view: OneWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: One.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
