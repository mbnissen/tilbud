[
  line_length: 120,
  plugins: [Phoenix.LiveView.HTMLFormatter],
  inputs: ["*.{heex,ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{heex,ex,exs}"],
  import_deps: [:phoenix],
  subdirectories: ["priv/*/migrations"]
]
