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


# -- Veil Configuration    Don't remove this line
config :veil,
  site_name: "Your Website Name",
  email_from_name: "Your Name",
  email_from_address: "yourname@example.com",
  sign_in_link_expiry: 12 * 3_600, # How long should emailed sign-in links be valid for?
  session_expiry: 86_400 * 30, # How long should sessions be valid for?
  refresh_expiry_interval: 86_400,  # How often should existing sessions be extended to session_expiry
  sessions_cache_limit: 250, # How many recent sessions to keep in cache (to reduce database operations)
  users_cache_limit: 100 # How many recent users to keep in cache

config :veil, Veil.Scheduler,
  jobs: [
    # Runs every midnight to delete all expired requests and sessions
    {"@daily", {One.Veil.Clean, :expired, []}}
  ]

config :veil, OneWeb.Veil.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your-api-key"

# -- End Veil Configuration
