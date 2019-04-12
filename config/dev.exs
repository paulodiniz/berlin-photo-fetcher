use Mix.Config

config :berlin_photo_fetcher, BerlinPhotoFetcher.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "berlin_photo_fetcher_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
