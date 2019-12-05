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

  def run(%AuthenticateUser{code: code}) do
  end
end
