defmodule Combobox.Repo.Migrations.CreateTerritoriesList do
  use Ecto.Migration

  def up do
    execute """
    CREATE VIRTUAL TABLE territories_list USING fts5(
      code,
      name,
      category UNINDEXED,
      updated_at UNINDEXED,
      inserted_at UNINDEXED,
      tokenize='unicode61 remove_diacritics 2'
    );
    """
  end

  def down do
    execute "DROP TABLE IF EXISTS territories_list;"
  end
end
