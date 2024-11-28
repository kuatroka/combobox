defmodule Combobox.Repo.Migrations.CreateTerritoriesFts do
  use Ecto.Migration

  def up do
    execute """
    CREATE VIRTUAL TABLE territories_fts USING fts5(
      territory_name,
      territory_category,
      content='territories',
      content_rowid='id'
    )
    """

    execute """
    INSERT INTO territories_fts(territories_fts, rowid, territory_name, territory_category)
    VALUES('insert', 0, '', '')
    """

    execute """
    INSERT INTO territories_fts(rowid, territory_name, territory_category)
    SELECT id, territory_name, territory_category FROM territories
    """
  end

  def down do
    execute "DROP TABLE IF EXISTS territories_fts;"
  end
end
defmodule Combobox.Repo.Migrations.CreateTerritoriesFts do
  use Ecto.Migration

  def up do
    execute """
    CREATE VIRTUAL TABLE territories_fts USING fts5(
      territory_name,
      territory_category
    )
    """

    execute """
    INSERT INTO territories_fts(territory_name, territory_category)
    SELECT territory_name, territory_category FROM territories
    """
  end

  def down do
    execute "DROP TABLE IF EXISTS territories_fts;"
  end
end
