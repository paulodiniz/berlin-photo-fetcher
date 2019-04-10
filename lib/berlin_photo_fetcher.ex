defmodule BerlinPhotoFetcher do
  @moduledoc """
  Documentation for BerlinPhotoFetcher.
  """

  def fetch() do
    BerlinPhotoFetcher.QueryFetcher.build("Berlin")
  end

  def fetch_and_store_on_aws_bucket() do
    fetch()
    |> store_on_aws_bucket()
  end

  def fetch_and_store_local() do
    fetch()
    |> BerlinPhotoFetcher.Store.Local.call()
  end

  def fetch_and_store_on_aws_rds() do
    fetch()
    |> store_on_aws_rds()
  end

  defp store_on_aws_bucket(photo_stream) do
    photo_stream
    |> Stream.map(fn photo -> photo.url end)
  end

  defp store_on_aws_rds(photo_stream) do
  end
end
