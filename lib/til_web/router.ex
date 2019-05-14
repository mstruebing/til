defmodule TilWeb.Router do
  use TilWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api 
    if Mix.env == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: TilWeb.Schema,
        interface: :playground,
        context: %{pubsub: TilWeb.Endpoint}
    end
  end

  forward("/", Absinthe.Plug, schema: TilWeb.Schema)
end

