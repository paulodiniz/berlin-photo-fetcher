defmodule BerlinPhotoFetcher.Unsplash.Producer do
  def call(url) do
    url |> get
  end

  # defp build_url(query, page) do
  #   "https://api.unsplash.com/search/photos?page=#{page}&query=#{query}"
  # end

  defp headers() do
    [Authorization: "Client-ID " <> application_id()]
  end

  defp application_id() do
    Application.get_env(:berlin_photo_fetcher, :unsplash_application_id)
  end

  defp get(url) do
    HTTPotion.get(url, headers: headers())
  end
end
