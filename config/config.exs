# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :til,
  ecto_repos: [Til.Repo]

# Configures the endpoint
config :til, TilWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UqvL0AVCdWbtrqHY65U802C7XihdG1Pwq6kQNx4ZK3nqRVutP7Yym4sFpa4Dk+fi",
  render_errors: [view: TilWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Til.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# configures Guardian
config :til, Til.Guardian,
  # optional
  allowed_algos: ["HS512"],
  # optional
  verify_module: Guardian.JWT,
  issuer: "Til",
  ttl: {30, :days},
  allowed_drift: 2000,
  # optional
  verify_issuer: true,
  # generated using: JOSE.JWK.generate_key({:oct, 16}) |> JOSE.JWK.to_map |> elem(1)
  # TODO: CHANGE THIS BEFORE HOSTING
  secret_key: %{"k" => "3gx0vXjUD2BJ8xfo_aQWIA", "kty" => "oct"},
  serializer: Til.Guardian
