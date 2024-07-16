defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", ServerWeb do
    pipe_through(:api)

    get("/items/list", ItemsController, :list)
    post("/items/checkout", ItemsController, :checkout)
  end
end
