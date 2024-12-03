defmodule Combobox.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :country_id, :integer
      add :country_code, :string
      add :country_name, :string
      add :iso3, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:countries, [:country_id])
  end
end
