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

  def store_db(stream) do
    BerlinPhotoFetcher.Store.DB.call(stream)
  end

  def fetch_all do
    fetch() |> store_db() |> Enum.to_list
  end
end
