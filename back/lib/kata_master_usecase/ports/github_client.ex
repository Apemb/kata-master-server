defmodule KataMasterUsecase.Ports.GithubClient do
  defmodule Behaviour do
    alias KataMasterDomain.GithubUserEntity
    alias KataMasterDomain.TokenDataObject

    @callback exchange_code(code :: String.t()) :: {:ok, TokenDataObject.t()} | {:error, term}
    @callback get_authenticated_user(TokenDataObject.t()) ::
                {:ok, GithubUserEntity.t()} | {:error, term}
  end

  @behaviour Behaviour

  @impl_module Application.get_env(
                 :kata_master,
                 :github_client,
                 KataMasterInfra.GithubClient
               )

  @impl Behaviour
  defdelegate exchange_code(code), to: @impl_module
  @impl Behaviour
  defdelegate get_authenticated_user(token), to: @impl_module
end
