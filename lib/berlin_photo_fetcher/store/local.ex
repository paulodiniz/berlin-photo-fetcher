defmodule BerlinPhotoFetcher.Store.Local do
  def call(photo_stream) do
    photo_stream
    |> Stream.map(&save_locally/1)
  end

  defp save_locally(photo) do
    IO.puts("Saving photo #{photo.ext_id}")
    photo.url
    |> HTTPotion.get
    |> extract_binary
    |> save_to_folder(photo.ext_id)
  end

  defp extract_binary(http_response) do
    http_response.body
  end

  defp save_to_folder(photo_binary, ext_id) do
    with {:ok, file} <- File.open("photos/#{ext_id}.jpg", [:write]) do
      IO.binwrite(file, photo_binary)
    end
  end
end
