defmodule Combobox.Repo.Migrations.CreateTerritoriesFts do
  use Ecto.Migration

  def up do
    execute """
    CREATE VIRTUAL TABLE territories_fts USING fts5(
      territory_name, 
      territory_category, 
      territory_id UNINDEXED
    );
    """
  end

  def down do
    execute "DROP TABLE IF EXISTS territories_fts;"
  end
end
