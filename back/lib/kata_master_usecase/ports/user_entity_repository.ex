defmodule KataMasterUsecase.Ports.UserEntityRepository do
  @moduledoc false

  defmodule Behaviour do
    alias KataMasterDomain.UserEntity

    @type uuid :: String.t()

    @callback get(id :: uuid) ::
                {:ok, UserEntity.t()}
                | {:error, {:resource_not_found, [name: :user_entity, id: String.t()]}}
                | {:error, term}

    @callback get_by_github_id(github_id :: uuid) ::
                {:ok, UserEntity.t()}
                | {:error, {:resource_not_found, [name: :user_entity, github_id: String.t()]}}
                | {:error, term}
  end

  @behaviour Behaviour

  @impl_module Application.get_env(
                 :kata_master,
                 :user_entity_repository,
                 KataMasterInfra.UserEntityRepository
               )

  @impl Behaviour
  defdelegate get(id), to: @impl_module

  @impl Behaviour
  defdelegate get_by_github_id(github_id), to: @impl_module
end
