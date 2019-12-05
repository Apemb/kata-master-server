defmodule KataMaster.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)
      add(:pseudo, :string, null: false)
      add(:email, :string, null: false)

      timestamps()
    end
  end
end
