defmodule KataMasterDomain.UserAggregate do
  alias KataMasterDomain.GithubUserEntity
  alias KataMasterDomain.UserAggregate

  @type t() :: %UserAggregate{
          id: String.t(),
          github_id: String.t(),
          pseudo: String.t(),
          name: String.t(),
          email: String.t()
        }
  defstruct [
    :id,
    :github_id,
    :pseudo,
    :name,
    :email
  ]

  def from_github_user_entity(%GithubUserEntity{} = github_user_entity) do
    %UserAggregate{
      id: nil,
      github_id: github_user_entity.id,
      pseudo: github_user_entity.login,
      name: github_user_entity.name,
      email: github_user_entity.email
    }
  end
end
