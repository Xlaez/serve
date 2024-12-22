defmodule ServeApi.Repo.Migrations.AddGenderToAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :gender, :string
    end
  end
end
