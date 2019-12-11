defmodule KataMasterUsecase.AuthenticateUser do
  alias KataMasterUsecase.AuthenticateUser

  @type t() :: %AuthenticateUser{
          code: String.t()
        }
  defstruct [
    :code
  ]
end

defimpl KataMasterUsecase, for: KataMasterUsecase.AuthenticateUser do
  alias KataMasterDomain.UserEntity
  alias KataMasterDomain.UserAggregate
  alias KataMasterUsecase.AuthenticateUser
  alias KataMasterUsecase.Ports.GithubClient
  alias KataMasterUsecase.Ports.UserAggregateRepository
  alias KataMasterUsecase.Ports.UserEntityRepository

  @spec run(AuthenticateUser.t()) :: {:ok, UserEntity.t()} | {:error, term}
  def run(%AuthenticateUser{code: code}) do
    code
    |> Chain.new()
    |> Chain.next(&GithubClient.exchange_code/1)
    |> Chain.next(&GithubClient.get_authenticated_user/1)
    |> Chain.next(fn github_user ->
      github_user.id
      |> Chain.new()
      |> Chain.next(&UserEntityRepository.get_by_github_id/1)
      |> Chain.recover(fn
        {:resource_not_found, _} ->
          github_user
          |> Chain.new()
          |> Chain.next(&UserAggregate.from_github_user_entity/1)
          |> Chain.next(&UserAggregateRepository.create/1)
          |> Chain.next(&UserEntityRepository.get(&1.id))

        reason ->
          {:error, reason}
      end)
    end)
    |> Chain.run()
  end
end
