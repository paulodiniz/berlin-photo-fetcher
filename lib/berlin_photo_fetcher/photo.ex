defmodule BerlinPhotoFetcher.Photo do
  use Ecto.Schema

  schema "photos" do
    field :ext_id, :string
    field :url, :string
    field :meta, :map

    timestamps
  end

  def changeset(photo, params \\ %{}) do
    photo
    |> cast(params, )
  end
end
