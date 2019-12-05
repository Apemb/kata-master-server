defmodule KataMasterDomain.GithubUserEntity do
  alias KataMasterDomain.GithubUserEntity

  @type t() :: %GithubUserEntity{
          id: String.t(),
          login: String.t(),
          name: String.t(),
          email: String.t()
        }
  defstruct [
    :id,
    :login,
    :name,
    :email
  ]
end
