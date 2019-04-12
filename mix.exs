defmodule BerlinPhotoFetcher.MixProject do
  use Mix.Project

  def project do
    [
      app: :berlin_photo_fetcher,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :ecto, :postgrex, :httpotion],
      mod: {BerlinPhotoFetcher.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:httpotion, "~> 3.1.0"},
      {:poison, "~> 3.1"},
      {:ecto, "~> 3.1.1"},
      {:ecto_sql, "~> 3.0-rc.1"},
      {:postgrex, ">= 0.0.0"},
      {:jason, "~> 1.0"}
    ]
  end
end
