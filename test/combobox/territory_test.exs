defmodule Combobox.TerritoryTest do
  use Combobox.DataCase

  alias Combobox.Territory

  describe "countries" do
    alias Combobox.Territory.Country

    import Combobox.TerritoryFixtures

    @invalid_attrs %{country_id: nil, country_code: nil, country_name: nil, iso3: nil}

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Territory.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Territory.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      valid_attrs = %{country_id: 42, country_code: "some country_code", country_name: "some country_name", iso3: "some iso3"}

      assert {:ok, %Country{} = country} = Territory.create_country(valid_attrs)
      assert country.country_id == 42
      assert country.country_code == "some country_code"
      assert country.country_name == "some country_name"
      assert country.iso3 == "some iso3"
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Territory.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      update_attrs = %{country_id: 43, country_code: "some updated country_code", country_name: "some updated country_name", iso3: "some updated iso3"}

      assert {:ok, %Country{} = country} = Territory.update_country(country, update_attrs)
      assert country.country_id == 43
      assert country.country_code == "some updated country_code"
      assert country.country_name == "some updated country_name"
      assert country.iso3 == "some updated iso3"
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Territory.update_country(country, @invalid_attrs)
      assert country == Territory.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Territory.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Territory.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Territory.change_country(country)
    end
  end

  describe "cities" do
    alias Combobox.Territory.City

    import Combobox.TerritoryFixtures

    @invalid_attrs %{city_id: nil, city_name: nil, country_code: nil, state_code: nil, latitude: nil, longitude: nil}

    test "list_cities/0 returns all cities" do
      city = city_fixture()
      assert Territory.list_cities() == [city]
    end

    test "get_city!/1 returns the city with given id" do
      city = city_fixture()
      assert Territory.get_city!(city.id) == city
    end

    test "create_city/1 with valid data creates a city" do
      valid_attrs = %{city_id: 42, city_name: "some city_name", country_code: "some country_code", state_code: "some state_code", latitude: "some latitude", longitude: "some longitude"}

      assert {:ok, %City{} = city} = Territory.create_city(valid_attrs)
      assert city.city_id == 42
      assert city.city_name == "some city_name"
      assert city.country_code == "some country_code"
      assert city.state_code == "some state_code"
      assert city.latitude == "some latitude"
      assert city.longitude == "some longitude"
    end

    test "create_city/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Territory.create_city(@invalid_attrs)
    end

    test "update_city/2 with valid data updates the city" do
      city = city_fixture()
      update_attrs = %{city_id: 43, city_name: "some updated city_name", country_code: "some updated country_code", state_code: "some updated state_code", latitude: "some updated latitude", longitude: "some updated longitude"}

      assert {:ok, %City{} = city} = Territory.update_city(city, update_attrs)
      assert city.city_id == 43
      assert city.city_name == "some updated city_name"
      assert city.country_code == "some updated country_code"
      assert city.state_code == "some updated state_code"
      assert city.latitude == "some updated latitude"
      assert city.longitude == "some updated longitude"
    end

    test "update_city/2 with invalid data returns error changeset" do
      city = city_fixture()
      assert {:error, %Ecto.Changeset{}} = Territory.update_city(city, @invalid_attrs)
      assert city == Territory.get_city!(city.id)
    end

    test "delete_city/1 deletes the city" do
      city = city_fixture()
      assert {:ok, %City{}} = Territory.delete_city(city)
      assert_raise Ecto.NoResultsError, fn -> Territory.get_city!(city.id) end
    end

    test "change_city/1 returns a city changeset" do
      city = city_fixture()
      assert %Ecto.Changeset{} = Territory.change_city(city)
    end
  end

  describe "states" do
    alias Combobox.Territory.State

    import Combobox.TerritoryFixtures

    @invalid_attrs %{code: nil, state_id: nil, state_name: nil, country_code: nil}

    test "list_states/0 returns all states" do
      state = state_fixture()
      assert Territory.list_states() == [state]
    end

    test "get_state!/1 returns the state with given id" do
      state = state_fixture()
      assert Territory.get_state!(state.id) == state
    end

    test "create_state/1 with valid data creates a state" do
      valid_attrs = %{code: "some code", state_id: 42, state_name: "some state_name", country_code: "some country_code"}

      assert {:ok, %State{} = state} = Territory.create_state(valid_attrs)
      assert state.code == "some code"
      assert state.state_id == 42
      assert state.state_name == "some state_name"
      assert state.country_code == "some country_code"
    end

    test "create_state/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Territory.create_state(@invalid_attrs)
    end

    test "update_state/2 with valid data updates the state" do
      state = state_fixture()
      update_attrs = %{code: "some updated code", state_id: 43, state_name: "some updated state_name", country_code: "some updated country_code"}

      assert {:ok, %State{} = state} = Territory.update_state(state, update_attrs)
      assert state.code == "some updated code"
      assert state.state_id == 43
      assert state.state_name == "some updated state_name"
      assert state.country_code == "some updated country_code"
    end

    test "update_state/2 with invalid data returns error changeset" do
      state = state_fixture()
      assert {:error, %Ecto.Changeset{}} = Territory.update_state(state, @invalid_attrs)
      assert state == Territory.get_state!(state.id)
    end

    test "delete_state/1 deletes the state" do
      state = state_fixture()
      assert {:ok, %State{}} = Territory.delete_state(state)
      assert_raise Ecto.NoResultsError, fn -> Territory.get_state!(state.id) end
    end

    test "change_state/1 returns a state changeset" do
      state = state_fixture()
      assert %Ecto.Changeset{} = Territory.change_state(state)
    end
  end

  describe "territories_list" do
    alias Combobox.Territory.TerritoryList

    import Combobox.TerritoryFixtures

    @invalid_attrs %{code: nil, name: nil, category: nil}

    test "list_territories_list/0 returns all territories_list" do
      territory_list = territory_list_fixture()
      assert Territory.list_territories_list() == [territory_list]
    end

    test "get_territory_list!/1 returns the territory_list with given id" do
      territory_list = territory_list_fixture()
      assert Territory.get_territory_list!(territory_list.id) == territory_list
    end

    test "create_territory_list/1 with valid data creates a territory_list" do
      valid_attrs = %{code: "some code", name: "some name", category: "some category"}

      assert {:ok, %TerritoryList{} = territory_list} = Territory.create_territory_list(valid_attrs)
      assert territory_list.code == "some code"
      assert territory_list.name == "some name"
      assert territory_list.category == "some category"
    end

    test "create_territory_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Territory.create_territory_list(@invalid_attrs)
    end

    test "update_territory_list/2 with valid data updates the territory_list" do
      territory_list = territory_list_fixture()
      update_attrs = %{code: "some updated code", name: "some updated name", category: "some updated category"}

      assert {:ok, %TerritoryList{} = territory_list} = Territory.update_territory_list(territory_list, update_attrs)
      assert territory_list.code == "some updated code"
      assert territory_list.name == "some updated name"
      assert territory_list.category == "some updated category"
    end

    test "update_territory_list/2 with invalid data returns error changeset" do
      territory_list = territory_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Territory.update_territory_list(territory_list, @invalid_attrs)
      assert territory_list == Territory.get_territory_list!(territory_list.id)
    end

    test "delete_territory_list/1 deletes the territory_list" do
      territory_list = territory_list_fixture()
      assert {:ok, %TerritoryList{}} = Territory.delete_territory_list(territory_list)
      assert_raise Ecto.NoResultsError, fn -> Territory.get_territory_list!(territory_list.id) end
    end

    test "change_territory_list/1 returns a territory_list changeset" do
      territory_list = territory_list_fixture()
      assert %Ecto.Changeset{} = Territory.change_territory_list(territory_list)
    end
  end
end
