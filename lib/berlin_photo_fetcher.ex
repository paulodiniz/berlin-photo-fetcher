defmodule BerlinPhotoFetcher do
  @moduledoc """
  Documentation for BerlinPhotoFetcher.
  """

  @doc """
  Hello world.

  ## Examples

      iex> BerlinPhotoFetcher.hello()
      :world

  """
  def hello do
    :world
  end

  def fetch() do
    BerlinPhotoFetcher.QueryFetcher.build("Berlin")
  end
end
