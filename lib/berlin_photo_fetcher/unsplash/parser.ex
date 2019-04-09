defmodule BerlinPhotoFetcher.Unsplash.Parser do
  alias BerlinPhotoFetcher.Photo

  def call(raw_result) do
    raw_result.body
    |> Poison.decode!()
    |> to_photos
  end

  defp to_photos(photos_json) do
    with {:ok, results} <- Map.fetch(photos_json, "results") do
      Enum.map(results, &to_photo/1)
    end
  end

  defp to_photo(photo_json) do
    %Photo{
      id: photo_json["id"],
      url: photo_json["urls"]["full"],
      meta: %{
        tags: build_tags(photo_json["tags"]),
        likes: photo_json["likes"],
        owner: owner(photo_json["user"]["first_name"], photo_json["user"]["last_name"]),
        text: photo_json["alt_description"]
      }
    }
  end

  defp build_tags(tags_json) do
    tags_json
    |> Enum.map(&Map.values(&1))
    |> List.flatten()
  end

  defp owner(nil, last_name), do: last_name
  defp owner(first_name, nil), do: first_name

  defp owner(first_name, last_name) do
    first_name <> last_name
  end
end
