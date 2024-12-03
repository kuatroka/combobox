defmodule Combobox.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :city_id, :integer
      add :city_name, :string
      add :country_code, :string
      add :state_code, :string
      add :latitude, :string
      add :longitude, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:cities, [:city_id])
  end
end
