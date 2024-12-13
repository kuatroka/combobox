defmodule Combobox.Repo.Migrations.AddUniqueConstraintToCountriesCountryCode do
  use Ecto.Migration

  def change do
    create unique_index(:countries, [:country_code])
  end
end
