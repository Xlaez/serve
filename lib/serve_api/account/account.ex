defmodule ServeApi.Account.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :email, :string
    field :password, :string
    field :first_name, :string
    field :last_name, :string
    field :other_name, :string
    field :img_url, :string
    field :country, :string
    field :city, :string
    field :phone, :string
    # worker | customer
    field :type, :string
    # google, password
    field :login_type, :string
    field :device_tokens, {:array, :string}, default: []
    field :send_push_notifications, :boolean, default: false

    has_one :service, ServeApi.Service.Service

    timestamps(type: :utc_datetime)
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, [
      :email,
      :password,
      :first_name,
      :last_name,
      :other_name,
      :img_url,
      :country,
      :city,
      :phone,
      :gender,
      :type,
      :login_type,
      :device_tokens,
      :send_push_notifications
    ])
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/,
      message: "must be a valid email with no spaces"
    )
    |> validate_length(:email, max: 60)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
