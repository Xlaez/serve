defmodule ServeApi.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string
      add :category, :string
      add :website, :string
      add :instagram, :string
      add :facebook, :string
      add :phone, :string
      add :cover_image, :string
      add :imgs_and_videos, {:array, :string}
      add :subscription_type, :string

      add :latitude, :float
      add :longitude, :float
      add :city, :string
      add :state, :string
      add :country, :string
      add :street, :string

      add :account_id, references(:accounts, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:services, [:instagram, :facebook])
  end
end
