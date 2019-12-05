defmodule KataMasterDomain.TokenDataObject do
  alias KataMasterDomain.TokenDataObject

  @type t() :: %TokenDataObject{
          access_token: String.t(),
          token_type: String.t()
        }
  defstruct [
    :access_token,
    :token_type
  ]
end
