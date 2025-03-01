defmodule KataMaster.Repo.Migrations.AddGithubIdToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :github_id, :string
    end

    create index(:users, [:github_id])
  end
end
