defmodule BerlinPhotoFetcher.QueryFetcher do
  alias BerlinPhotoFetcher.Unsplash.Producer, as: UnsplashProducer
  alias BerlinPhotoFetcher.Unsplash.Parser, as: UnsplashParser

  def fetch(query) do
    query
    |> UnsplashProducer.call()
    |> UnsplashParser.call()
  end
end
