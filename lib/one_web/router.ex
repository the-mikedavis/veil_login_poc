defmodule OneWeb.Router do
  use OneWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(OneWeb.Plugs.Veil.UserId)
    plug(OneWeb.Plugs.Veil.User)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", OneWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", OneWeb do
  #   pipe_through :api
  # end

  # Default Routes for Veil
  scope "/veil", OneWeb.Veil do
    pipe_through(:browser)

    post("/users", UserController, :create)

    get("/users/new", UserController, :new)
    get("/sessions/new/:request_id", SessionController, :create)
    get("/sessions/signout/:session_id", SessionController, :delete)
  end

  # Add your routes that require authentication in this block.
  # Alternatively, you can use the default block and authenticate in the controllers.
  # See the Veil README for more.
  scope "/", OneWeb do
    pipe_through([:browser, OneWeb.Plugs.Veil.Authenticate])
  end
end
