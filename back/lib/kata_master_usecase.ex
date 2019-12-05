defprotocol KataMasterUsecase do
  @moduledoc """
  KataMasterUsecase is the modules in which the usecase / commands that define your applications
  actions are.

  All Usecases should implement this protocol to ease the call and the formatting of the
  parameters
  """

  @type result :: term
  @type reason :: term

  @doc "modify the builder data with the opts (keyword list of the params)"
  @spec run(KataMasterUsecase.t()) ::
          {:ok, result}
          | {:error, term}
  def run(usecase_data)
end
