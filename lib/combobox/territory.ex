defmodule Combobox.Territory do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "territories" do
    field :territory_id, :integer
    field :territory, :string
    field :territory_name, :string
    field :territory_category, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(territories, attrs) do
    territories
    |> cast(attrs, [:territory_id, :territory, :territory_name, :territory_category])
    |> validate_required([:territory_name, :territory_category])
  end

  def search(query, search_term) do
    from t in query,
      join: fts in fragment("territories_fts"),
      on: t.id == fragment("rowid"),
      where: fragment("territories_fts MATCH ?", ^search_term),
      limit: 5
  end

  def generate_link(%__MODULE__{} = territory) do
    "#{territory.territory_category}/#{territory.territory_id}"
  end
end
