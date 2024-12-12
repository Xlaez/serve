defmodule BlogApi.Notification.Notification do
  use Ecto.Schema
  import Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "notifications" do
    field :title, :string
    field :description, :string
    field :action, :boolean, default: false
    field :action_id, :string
    # account, service, ad
    field :type, :string
    field :is_read, :boolean, default: false
    field :body, :string

    belongs_to :account, BlogApi.Account.Account

    timestamps(type: :utc_datetime)
  end

  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [
      :title,
      :description,
      :action_id,
      :type,
      :is_read,
      :body
    ])
    |> validate_required([:title, :description, :action, :type, :body])
  end
end
