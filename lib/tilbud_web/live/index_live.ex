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

  def format_time(%DateTime{} = datetime) do
    datetime
    |> Timex.to_datetime("Europe/Copenhagen")
    |> Timex.format!("{D}/{M} {YYYY}")
  end

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
          <p class="text-slate-700 text-sm"><%= offer.description %></p>
          <div class="flex justify-between pt-4">
            <div class="text-sm text-slate-500">
              <%= format_time(offer.from) %> - <%= format_time(offer.to) %>
            </div>
            <div class="text-slate-600 font-bold"><%= offer.price %> kr.</div>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end
