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
      ext_id: photo_json["id"],
      url: photo_json["urls"]["full"],
      meta: %{
        tags: build_tags(photo_json["tags"]),
        likes: photo_json["likes"],
        text: photo_json["alt_description"],
        owner: owner_tag(photo_json["user"]),
        alt: photo_json["alt_description"],
        updated_at: photo_json["updated_at"],
        sponsored: photo_json["sponsored"],
      }
    }
  end

  defp build_tags(tags_json) do
    tags_json
    |> Enum.map(&Map.values(&1))
    |> List.flatten()
  end

  defp owner_tag(user_json) do
    %{
      name: user_json["name"],
      instagram: user_json["instagram_username"],
      total_photos: user_json["total_photos"]
    }
  end
end
