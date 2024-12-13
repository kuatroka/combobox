defmodule Combobox.Territory.State do
  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    field :code, :string
    field :state_id, :integer
    field :state_name, :string
    field :country_code, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:state_id, :state_name, :country_code, :code])
    |> validate_required([:state_id, :state_name, :country_code, :code])
    |> unique_constraint(:code)
  end
end
