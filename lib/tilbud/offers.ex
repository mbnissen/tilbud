defmodule Tilbud.Offers do
  alias Tilbud.TilbudServer

  def list_offers(:eggs) do
    TilbudServer.list_offers()
    |> dbg()
  end
end
