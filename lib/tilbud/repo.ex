defmodule Tilbud.Repo do
  use Ecto.Repo,
    otp_app: :tilbud,
    adapter: Ecto.Adapters.Postgres
end
