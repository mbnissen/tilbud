defmodule Tilbud.TilbudServer do
  use GenServer

  alias Tilbud.Shopgun

  def start_link(item) do
    GenServer.start_link(__MODULE__, item, name: __MODULE__)
  end

  def list_offers() do
    GenServer.call(__MODULE__, :list)
  end

  # Callbacks

  @impl true
  def init(item) do
    offers = Shopgun.get_offer(item)

    {:ok, offers}
  end

  @impl true
  def handle_call(:list, _from, offers) do
    {:reply, offers, offers}
  end
end
