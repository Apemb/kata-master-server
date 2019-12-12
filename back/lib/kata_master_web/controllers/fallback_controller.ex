defmodule KataMasterWeb.FallbackController do
  use KataMasterWeb, :controller

  alias KataMasterWeb.ErrorView

  alias __MODULE__

  @behaviour Guardian.Plug.ErrorHandler
  @guardian_errors [
    :unauthenticated,
    :unauthorized,
    :invalid_token,
    :already_authenticated,
    :no_resource_found
  ]

  def auth_error(conn, {type, reason}, _opts) when type in @guardian_errors do
    FallbackController.call(conn, {:error, type, :guardian})
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, _type, :guardian}) do
    conn
    |> put_status(401)
    |> json(%{error: "Unauthorized"})
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(403)
    |> json(%{error: "Forbidden"})
  end

  #  def call(conn, {:error, %Ecto.NoResultsError{}}) do
  #    send_resp(conn, 404, Jason.encode!(%{error: "Not found"}))
  #  end
  #
  #  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
  #    errors =
  #      Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
  #        Enum.reduce(opts, msg, fn {key, value}, acc ->
  #          String.replace(acc, "%{#{key}}", to_string(value))
  #        end)
  #      end)
  #
  #    conn
  #    |> put_status(:unprocessable_entity)
  #    |> json(%{error: errors})
  #  end
  #
  #  def call(conn, {:error, %Ecto.Query.CastError{type: :binary_id}}) do
  #    send_resp(conn, 404, Jason.encode!(%{error: "Not found"}))
  #  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> json(%{error: "Internal server error"})
  end
end
