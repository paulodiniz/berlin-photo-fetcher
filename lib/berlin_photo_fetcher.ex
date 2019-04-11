defmodule BerlinPhotoFetcher do
  @moduledoc """
  Documentation for BerlinPhotoFetcher.
  """

  def fetch() do
    BerlinPhotoFetcher.QueryFetcher.build("Berlin")
  end

  def store_local(stream) do
    BerlinPhotoFetcher.Store.Local.call(stream)
  end

  defp store_on_aws_bucket(photo_stream) do
    photo_stream
    |> Stream.map(fn photo -> photo.url end)
  end

  defp store_on_aws_rds(photo_stream) do
  end
end
