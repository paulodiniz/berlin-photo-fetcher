defmodule BerlinPhotoFetcher.Store.DB do
  alias BerlinPhotoFetcher.Repo

  def call(photo_stream) do
    photo_stream
    |> Stream.map(&save_db/1)
  end

  defp save_db(photo) do
    Repo.insert! photo
  end
end
