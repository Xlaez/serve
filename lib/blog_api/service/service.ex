defmodule BlogApi.Service.Service do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "services" do
    field :name, :string
    field :description, :string
    field :category, :string
    # field :location, :map
    field :website, :string
    field :instagram, :string
    field :facebook, :string
    field :phone, :string
    field :cover_image, :string
    field :imgs_and_videos, {:array, :string}

    # subscriptions : "none" - can be found by someone within your city, "basic" - can be searched by someone within your state, "premium" - can be searched by someone within your country and also get free month-end ads that last for a day.
    field :subscription_type, :string

    embeds_one :location, Location do
      field :latitude, :float
      field :longitude, :float
      field :city, :string
      field :state, :string
      field :country, :string
      field :street, :string
    end

    timestamps(type: :utc_datetime)
  end

  def changeset(service, attrs) do
    service
    |> cast(attrs, [
      :name,
      :description,
      :category,
      :location,
      :website,
      :instagram,
      :facebook,
      :phone,
      :cover_image,
      :imgs_and_videos,
      :subscription_type
    ])
    |> validate_required([:name, :description, :category, :address])
    |> validate_length(:description, min: 200, max: 500)
    |> unique_constraint([:instagram, :facebook])
  end
end
