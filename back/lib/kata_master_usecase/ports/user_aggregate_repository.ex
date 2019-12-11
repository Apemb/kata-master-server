defmodule KataMasterUsecase.Ports.UserAggregateRepository do
  @moduledoc false

  defmodule Behaviour do
    alias KataMasterDomain.UserAggregate

    @type uuid :: String.t()

    @callback get(id :: uuid) ::
                {:ok, UserAggregate.t()}
                | {:error, {:resource_not_found, [name: :user_aggregate, id: String.t()]}}
                | {:error, term}

    @callback create(user :: UserAggregate.t()) ::
                {:ok, UserAggregate.t()}
                | {:error, term}
  end

  @behaviour Behaviour

  @impl_module Application.get_env(
                 :kata_master,
                 :user_aggregate_repository,
                 KataMasterInfra.UserAggregateRepository
               )

  @impl Behaviour
  defdelegate get(id), to: @impl_module

  @impl Behaviour
  defdelegate create(user), to: @impl_module
end
