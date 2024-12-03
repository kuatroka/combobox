defmodule Combobox.Repo.Migrations.CreateTerritories do
  use Ecto.Migration

  def change do
    create table(:territories) do
      add :territory_id, :integer
      add :territory, :string
      add :territory_name, :string
      add :territory_category, :string

      timestamps(type: :utc_datetime)
    end
  end
end
