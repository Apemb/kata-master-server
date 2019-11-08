defmodule KataMaster.Repo do
  use Ecto.Repo,
    otp_app: :kata_master,
    adapter: Ecto.Adapters.Postgres
end
