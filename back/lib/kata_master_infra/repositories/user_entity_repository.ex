defmodule KataMasterInfra.UserEntityRepository do
  @moduledoc false
  import Ecto.Query, warn: false

  alias KataMasterDomain.UserEntity
  alias KataMasterInfra.UserTable

  alias KataMasterUsecase.Ports.UserEntityRepository.Behaviour,
    as: UserEntityRepositoryBehaviour

  @behaviour UserEntityRepositoryBehaviour

  @impl UserEntityRepositoryBehaviour
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

  @impl UserEntityRepositoryBehaviour
  def get_by_github_id(github_id) do
    result =
      UserTable
      |> where(github_id: ^github_id)
      |> limit(1)
      |> KataMaster.Repo.one()

    case result do
      nil ->
        {:error, {:resource_not_found, [name: :user_entity, github_id: github_id]}}

      user_table ->
        {:ok, from_user_table(user_table)}
    end
  end

  defp from_user_table(user_table) do
    %UserEntity{
      id: user_table.id,
      github_id: user_table.github_id,
      pseudo: user_table.pseudo,
      name: user_table.name,
      email: user_table.email
    }
  end
end
