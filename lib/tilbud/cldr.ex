defmodule Reel.Cldr do
  use Cldr,
    default_locale: "da",
    locales: [:da],
    providers: [Cldr.Number]
end

