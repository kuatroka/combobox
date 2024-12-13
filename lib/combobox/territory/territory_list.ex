defmodule Combobox.Territory.TerritoryList do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true, source: :rowid}
  schema "territories_list" do
    field :code, :string
    field :category, :string
    field :name, :string
    field :rank, :float, virtual: true
    # field :id, :string, virtual: true  # Virtual field for LiveView streams
  end


  @doc false
  def changeset(territory_list, attrs) do
    territory_list
    |> cast(attrs, [:code, :category, :name])
    |> validate_required([:code, :category, :name])
  end

end
