defmodule KataMasterWeb.TokenService do
  use Guardian, otp_app: :kata_master

  alias KataMasterDomain.UserEntity
  alias KataMasterUsecase.Ports.UserEntityRepository

  def subject_for_token(%UserEntity{id: id}, _claims) do
    {:ok, id}
  end

  def subject_for_token(_, _claims) do
    {:error, :unhandled_resource_type}
  end

  def resource_from_claims(%{"sub" => id}) do
    case UserEntityRepository.get(id) do
      {:error, {:resource_not_found, [name: :user_entity, id: id]}} ->
        {:error, :no_resource_found}

      {:ok, user_entity} ->
        {:ok, user_entity}
    end
  end
end
