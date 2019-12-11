defmodule KataMasterInfra.UserAggregateRepository do
  @moduledoc false
  import Ecto.Query, warn: false

  alias KataMasterDomain.UserAggregate
  alias KataMasterInfra.UserTable

  alias KataMasterUsecase.Ports.UserAggregateRepository.Behaviour,
    as: UserAggregateRepositoryBehaviour

  @behaviour UserAggregateRepositoryBehaviour

  @impl UserAggregateRepositoryBehaviour
  def get(id) do
    result =
      UserTable
      |> where(id: ^id)
      |> KataMaster.Repo.one()

    case result do
      nil ->
        {:error, {:resource_not_found, [name: :user_entity, id: id]}}

      user_table ->
        {:ok, from_user_table(user_table)}
    end
  end

  @impl UserAggregateRepositoryBehaviour
  def create(%UserAggregate{id: nil} = user_aggregate) do
    result =
      %UserTable{}
      |> UserTable.user_aggregate_changeset(Map.from_struct(user_aggregate))
      |> KataMaster.Repo.insert()

    case result do
      {:error, changeset} ->
        {:error, changeset}

      {:ok, user_table} ->
        {:ok, from_user_table(user_table)}
    end
  end

  defp from_user_table(user_table) do
    %UserAggregate{
      id: user_table.id,
      github_id: user_table.github_id,
      pseudo: user_table.pseudo,
      name: user_table.name,
      email: user_table.email
    }
  end
end
