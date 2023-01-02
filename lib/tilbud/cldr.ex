defmodule Tilbud.Cldr do
  use Cldr,
    default_locale: "da",
    locales: [:da],
    providers: [Cldr.Number, Cldr.Calendar, Cldr.DateTime]
end
