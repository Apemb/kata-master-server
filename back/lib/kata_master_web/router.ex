defmodule KataMasterWeb.Router do
  use KataMasterWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])

    plug(Guardian.Plug.Pipeline,
      module: KataMasterWeb.TokenService,
      error_handler: KataMasterWeb.FallbackController
    )

    plug(Guardian.Plug.VerifyHeader, header_name: "authorization")
    plug(Guardian.Plug.LoadResource, allow_blank: true)
  end

  scope "/api", KataMasterWeb do
    pipe_through(:api)

    post("/login", UserController, :login)
    get("/users/me", UserController, :get_me)
  end
end
