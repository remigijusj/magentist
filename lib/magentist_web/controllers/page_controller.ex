defmodule MagentistWeb.PageController do
  use MagentistWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
