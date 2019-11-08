use Mix.Config

# Configure your database
config :kata_master, KataMaster.Repo,
  username: "postgres",
  password: "postgres",
  database: "kata_master_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :kata_master, KataMasterWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
