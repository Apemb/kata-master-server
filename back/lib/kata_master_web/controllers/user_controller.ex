defmodule KataMasterWeb.UserController do
  use KataMasterWeb, :controller
  alias KataMasterDomain.UserEntity
  alias KataMasterWeb.TokenService

  alias KataMasterUsecase.AuthenticateUser
  #  def index(conn, _params) do
  #    users = Accounts.list_users_with_identities()
  #    render(conn, "index.html", users: users)
  #  end

  def login(conn, %{"code" => code}) do
    result =
      %AuthenticateUser{code: code}
      |> Chain.new()
      |> Chain.next(&KataMasterUsecase.run/1)
      |> Chain.next(&generate_token_payload/1)
      |> Chain.run()

    case result do
      {:ok, token_payload} -> json(conn, token_payload)
      {:error, reason} -> {:error, reason}
    end
  end

  defp generate_token_payload(%UserEntity{} = user_entity) do
    case TokenService.encode_and_sign(user_entity) do
      {:ok, token, _} -> {:ok, %{token: token}}
      {:error, reason} -> {:error, reason}
    end
  end

  def get_me(conn, _args) do
    user = Guardian.Plug.current_resource(conn)

    case user do
      %UserEntity{} = user -> json(conn, Map.from_struct(user))
      _ -> {:error, :unauthorized}
    end
  end

  #  def update(conn, %{"id" => id, "user" => user_params}) do
  #    user = Accounts.get_user_with_identities!(id)
  #
  #    case Accounts.update_user(user, user_params) do
  #      {:ok, user} ->
  #        conn
  #        |> put_flash(:success, dgettext("accounts", "User updated successfully."))
  #        |> redirect(to: Routes.user_path(conn, :show, user))
  #
  #      {:error, %Ecto.Changeset{} = changeset} ->
  #        render(conn, "edit.html", user: user, changeset: changeset)
  #    end
  #  end

  #   def delete(conn, %{"id" => id}) do
  #     user = Accounts.get_user!(id)
  #     {:ok, _user} = Accounts.delete_user(user)
  #     conn
  #     |> put_flash(:success, dgettext("accounts", "User deleted successfully."))
  #     |> redirect(to: Routes.user_path(conn, :index))
  #   end
end
