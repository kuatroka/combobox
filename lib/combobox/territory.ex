defmodule Combobox.Territory do
  use Ecto.Schema
  import Ecto.Changeset

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
end
