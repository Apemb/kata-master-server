defmodule KataMasterWeb.Router do
  use KataMasterWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])

    plug(Guardian.Plug.Pipeline,
      module: KataMasterWeb.TokenUtil,
      error_handler: KairosWeb.Api.FallbackController,
      key: "session"
    )

    plug(Guardian.Plug.VerifyHeader)
    plug(Guardian.Plug.LoadResource, allow_blank: true)
  end

  scope "/api", KataMasterWeb do
    pipe_through(:api)

    resources("/user", UserController, only: [:create])
  end
end
