defmodule ServeApi.Ad.Ad do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "ads" do
    # video, image
    field :media_type, :string
    field :media_url, :string
    field :text, :string
    field :expires_at, :utc_datetime
    field :starts_at, :utc_datetime
    field :priority, :string
    # id of the ad order paid
    field :order_id, :string
    # target city, state or country wide
    field :type, :string

    embeds_one :location, Location do
      field :latitude, :float
      field :longitude, :float
      field :city, :string
      field :state, :string
      field :country, :string
    end

    belongs_to :service, ServeApi.Service.Service
  end

  def changeset(ad, attrs) do
    ad
    |> cast(attrs, [
      :media_type,
      :media_url,
      :text,
      :expires_at,
      :starts_at,
      :priority,
      :order_id,
      :type,
      :location
    ])
    |> validate_required([
      :media_url,
      :media_type,
      :expires_at,
      :start_at,
      :priority,
      :order_id,
      :type,
      :location
    ])
  end
end
