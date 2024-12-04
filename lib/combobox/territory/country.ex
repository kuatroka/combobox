defmodule Combobox.Territory.Country do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {
    Flop.Schema,
    filterable: [:country_code, :country_name],
    sortable: [:country_id, :country_code, :country_name],
    default_limit: 10
  }

  schema "countries" do
    field :country_id, :integer
    field :country_code, :string
    field :country_name, :string
    field :iso3, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:country_id, :country_code, :country_name, :iso3])
    |> validate_required([:country_id, :country_code, :country_name, :iso3])
    |> unique_constraint(:country_id)
  end
end
