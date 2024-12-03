defmodule Combobox.Territory.City do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cities" do
    field :city_id, :integer
    field :city_name, :string
    field :country_code, :string
    field :state_code, :string
    field :latitude, :string
    field :longitude, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, [:city_id, :city_name, :country_code, :state_code, :latitude, :longitude])
    |> validate_required([:city_id, :city_name, :country_code, :state_code, :latitude, :longitude])
    |> unique_constraint(:city_id)
  end
end
