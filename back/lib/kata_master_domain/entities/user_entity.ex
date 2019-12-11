defmodule KataMasterDomain.UserEntity do
  alias KataMasterDomain.UserEntity

  @type t() :: %UserEntity{
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
end
