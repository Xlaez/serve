defmodule ServeApi.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :string
      add :action, :boolean, default: false
      add :action_id, :string
      add :type, :string
      add :is_read, :boolean, default: false
      add :body, :string

      add :account_id, references(:accounts, type: :binary_id)

      timestamps(type: :utc_datetime)
    end
  end
end
