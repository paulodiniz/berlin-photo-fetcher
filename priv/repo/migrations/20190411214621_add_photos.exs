defmodule BerlinPhotoFetcher.Repo.Migrations.AddPhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :ext_id, :string
      add :url, :string
      add :meta, :map

      timestamps()
    end
  end
end
