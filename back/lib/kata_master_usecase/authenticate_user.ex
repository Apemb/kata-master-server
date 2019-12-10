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
  alias KataMasterUsecase.AuthenticateUser
  alias KataMasterUsecase.Ports.GithubClient

  def run(%AuthenticateUser{code: code}) do
    code
    |> Chain.new()
    |> Chain.next(&GithubClient.exchange_code/1)
    |> Chain.next(&GithubClient.get_authenticated_user/1)
    |> Chain.run()
  end
end
