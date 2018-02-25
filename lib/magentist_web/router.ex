defmodule MagentistWeb.Router do
  use MagentistWeb, :router

  # The default browser stack
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MagentistWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/data", MagentistWeb do
    pipe_through :api

    post "/", DataController, :index
  end

  forward "/graphql",  Absinthe.Plug,          schema: MagentistWeb.Schema
  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: MagentistWeb.Schema, interface: :simple
end
