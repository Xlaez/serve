defmodule ServeApi.Repo.Migrations.CreateAds do
  use Ecto.Migration

  def change do
    create table(:ads, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :media_type, :string
      add :media_url, :string
      add :text, :string
      add :expires_at, :utc_datetime
      add :starts_at, :utc_datetime
      add :priority, :string
      add :order_id, :string
      add :type, :string

      add :latitude, :float
      add :longitude, :float
      add :city, :string
      add :state, :string
      add :country, :string

      add :service_id, references(:services, type: :binary_id)

      timestamps(type: :utc_datetime)
    end
  end
end
