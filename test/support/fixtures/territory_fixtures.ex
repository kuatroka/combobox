defmodule Combobox.TerritoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Combobox.Territory` context.
  """

  @doc """
  Generate a unique country country_id.
  """
  def unique_country_country_id, do: System.unique_integer([:positive])

  @doc """
  Generate a country.
  """
  def country_fixture(attrs \\ %{}) do
    {:ok, country} =
      attrs
      |> Enum.into(%{
        country_code: "some country_code",
        country_id: unique_country_country_id(),
        country_name: "some country_name",
        iso3: "some iso3"
      })
      |> Combobox.Territory.create_country()

    country
  end

  @doc """
  Generate a unique city city_id.
  """
  def unique_city_city_id, do: System.unique_integer([:positive])

  @doc """
  Generate a city.
  """
  def city_fixture(attrs \\ %{}) do
    {:ok, city} =
      attrs
      |> Enum.into(%{
        city_id: unique_city_city_id(),
        city_name: "some city_name",
        country_code: "some country_code",
        latitude: "some latitude",
        longitude: "some longitude",
        state_code: "some state_code"
      })
      |> Combobox.Territory.create_city()

    city
  end

  @doc """
  Generate a unique state state_id.
  """
  def unique_state_state_id, do: System.unique_integer([:positive])

  @doc """
  Generate a state.
  """
  def state_fixture(attrs \\ %{}) do
    {:ok, state} =
      attrs
      |> Enum.into(%{
        code: "some code",
        country_code: "some country_code",
        state_id: unique_state_state_id(),
        state_name: "some state_name"
      })
      |> Combobox.Territory.create_state()

    state
  end

  @doc """
  Generate a territory_list.
  """
  def territory_list_fixture(attrs \\ %{}) do
    {:ok, territory_list} =
      attrs
      |> Enum.into(%{
        category: "some category",
        code: "some code",
        name: "some name"
      })
      |> Combobox.Territory.create_territory_list()

    territory_list
  end
end
