defmodule KataMaster.MixProject do
  use Mix.Project

  def project do
    [
      app: :kata_master,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {KataMaster.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # web
      {:phoenix, "~> 1.4.10"},
      {:phoenix_pubsub, "~> 1.1"},
      {:gettext, "~> 0.11"},
      {:plug_cowboy, "~> 2.0"},
      {:cors_plug, "~> 2.0"},

      # Auth
      {:ueberauth, "~> 0.6"},
      {:guardian, "~> 2.0"},

      # Database
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},

      # HTTP Client
      {:jason, "~> 1.0"},
      {:tesla, "~> 1.3"},
      {:hackney, "~> 1.14.0"},

      # Utils
      {:chain, "~> 0.1.0"},

      # Tests
      {:credo, "~> 1.1.4", only: [:dev, :test], runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
