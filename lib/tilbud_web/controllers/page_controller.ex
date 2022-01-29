defmodule TilbudWeb.PageController do
  use TilbudWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
