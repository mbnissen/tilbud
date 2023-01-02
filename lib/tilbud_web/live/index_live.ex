defmodule TilbudWeb.IndexLive do
  use TilbudWeb, :live_view

  alias Tilbud.Offers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> load_tilbud()}
  end

  defp load_tilbud(socket) do
    assign(socket, :offers, Offers.list_offers(:eggs))
  end

  def format_time(%DateTime{} = datetime), do: Tilbud.Cldr.Date.to_string!(datetime)
  def format_amount(amount, currency), do: Tilbud.Cldr.Number.to_string!(amount, currency: currency)

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <%= for offer <- @offers do %>
        <div class="mb-4 p-5 pb-2 border rounded-lg text-slate-800 bg-white">
          <div class="flex justify-between pb-8">
            <h1 class="text-lg"><%= offer.heading %></h1>
            <div><img class="h-12 max-width-12" src={offer.branding.logo} /></div>
          </div>
          <p class="text-slate-700"><%= offer.description %></p>
          <div class="flex justify-between pt-4">
            <div class="text-slate-500">
              <%= format_time(offer.from) %> - <%= format_time(offer.to) %>
            </div>
            <div class="text-slate-600 font-bold"><%= format_amount(offer.price, offer.currency) %></div>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end
