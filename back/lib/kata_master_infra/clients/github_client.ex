defmodule KataMasterInfra.GithubClient do
  alias KataMasterDomain.TokenDataObject
  alias KataMasterDomain.GithubUserEntity

  @behaviour KataMasterUsecase.Ports.GithubClient.Behaviour

  @impl KataMasterUsecase.Ports.GithubClient.Behaviour

  @client_env Application.get_env(:kata_master, KataMasterInfra.GithubClient)
  @client_id Keyword.get(@client_env, :client_id)
  @client_secret Keyword.get(@client_env, :client_secret)

  def exchange_code(code) do
    IO.inspect("exchange_code")

    request_body =
      %{code: code, client_id: @client_id, client_secret: @client_secret}
      |> IO.inspect()

    middleware = [
      {Tesla.Middleware.BaseUrl, "https://github.com"},
      {Tesla.Middleware.Headers, [{"Accept", "application/json"}]},
      Tesla.Middleware.JSON
    ]

    request =
      middleware
      |> Tesla.client()
      |> Tesla.post("login/oauth/access_token", request_body)

    case request do
      {:ok, %Tesla.Env{status: 200, body: %{"error" => error}} = response} ->
        {:error, {:request_error, response}}

      {:ok, %Tesla.Env{status: 200} = response} ->
        token = %TokenDataObject{
          access_token: Map.get(response.body, "access_token"),
          token_type: Map.get(response.body, "token_type")
        }

        {:ok, token}

      {:ok, response} ->
        {:error, {:request_error, response}}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def get_authenticated_user(%TokenDataObject{access_token: token}) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://api.github.com"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Accept", "application/json"}]},
      {Tesla.Middleware.Headers, [{"Authorization", "token " <> token}]}
    ]

    request =
      middleware
      |> Tesla.client()
      |> Tesla.get("user")

    case request do
      {:ok, %Tesla.Env{status: 200} = response} ->
        user = %GithubUserEntity{
          id: "#{Map.get(response.body, "id")}",
          login: Map.get(response.body, "login"),
          name: Map.get(response.body, "name"),
          email: Map.get(response.body, "email")
        }

        {:ok, user}

      {:ok, response} ->
        {:error, {:request_error, response}}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
