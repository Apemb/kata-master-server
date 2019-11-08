defmodule KataMasterWeb.Router do
  use KataMasterWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", KataMasterWeb do
    pipe_through :api
  end
end
