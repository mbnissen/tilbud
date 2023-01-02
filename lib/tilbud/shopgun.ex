defmodule Tilbud.Shopgun do
  @moduledoc """
  Documentation for `Shopgun`.
  """

  @url "https://api.etilbudsavis.dk/v2/offers/search"

  def get_offers(items) do
    items
    |> Enum.flat_map(&get_offer/1)
    |> dbg()
  end

  def get_offer(item) do
    @url
    |> URI.new!()
    # |> URI.append_query(URI.encode_query(r_lat: lat))
    # |> URI.append_query(URI.encode_query(r_lng: lon))
    # |> URI.append_query(URI.encode_query(r_radius: 1000))
    |> URI.append_query(URI.encode_query(query: item))
    |> URI.to_string()
    |> HTTPoison.get()
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Poison.decode!()
        |> Enum.map(&parse_offer/1)
        |> dbg()

      error ->
        dbg(error)
        :error
    end
  end

  defp parse_offer(offer) do
    pricing = offer["pricing"]

    %{
      heading: offer["heading"],
      description: offer["description"],
      price: pricing["price"],
      currency: pricing["currency"],
      pre_price: pricing["prePrice"],
      branding: %{
        name: offer["branding"]["name"],
        logo: offer["branding"]["logo"],
        color: offer["branding"]["color"],
        website: offer["branding"]["website"]
      },
      from: parse_time!(offer["run_from"]),
      to: parse_time!(offer["run_till"])
    }
  end

  defp parse_time!(time) do
    {:ok, datetime, _offset} = DateTime.from_iso8601(time)
    datetime
  end
end
