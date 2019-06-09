defmodule TilWeb.Router do
  use TilWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  scope "/", TilWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(Til.Context)
  end

  scope "/graphql" do
    pipe_through(:api)

    if Mix.env() == :dev do
      forward("/playground", Absinthe.Plug.GraphiQL,
        schema: TilWeb.Schema,
        interface: :playground,
        context: %{pubsub: TilWeb.Endpoint}
      )
    end
  end

  forward("/", Absinthe.Plug, schema: TilWeb.Schema)
end
