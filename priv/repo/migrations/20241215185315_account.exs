defmodule ServeApi.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :password, :string
      add :first_name, :string
      add :last_name, :string
      add :other_name, :string
      add :img_url, :string
      add :country, :string
      add :city, :string
      add :phone, :string
      add :type, :string
      add :login_type, :string
      add :device_tokens, {:array, :string}, default: []
      add :send_push_notifications, :boolean, default: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:accounts, [:email])
  end
end
