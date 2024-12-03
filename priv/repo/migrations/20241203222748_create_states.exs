defmodule Combobox.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :state_id, :integer
      add :state_name, :string
      add :country_code, :string
      add :code, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:states, [:state_id])
  end
end
