defmodule KataMaster.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:pseudo, :string, null: false)
      add(:email, :string)

      timestamps()
    end
  end
end
