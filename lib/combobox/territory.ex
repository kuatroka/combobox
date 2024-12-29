# lib/combobox/territory.ex
defmodule Combobox.Territory do
  use Ecto.Schema

  import Ecto.Query

  alias Combobox.Repo


  alias Combobox.Territory.Country

  @doc """
  Returns the list of countries.

  ## Examples

      iex> list_countries()
      [%Country{}, ...]

  """
  def list_countries do
    Repo.all(Country)

  end

  ### using flop
  def list_countries2(params) do
    # Convert search parameter to a query condition
    base_query = from c in Country

    query = case get_in(params, ["filters", "0", "value"]) do
      value when is_binary(value) and value != "" ->
        pattern = "%#{value}%"
        from c in base_query,
          where: fragment("? COLLATE NOCASE LIKE ? OR ? COLLATE NOCASE LIKE ?",
            c.country_name, ^pattern,
            c.country_code, ^pattern)
      _ ->
        base_query
    end

    Flop.validate_and_run(
      query,
      params,
      for: Country,
      default_limit: 5,
      default_order: [asc: :country_name]
    )
  end



  @doc """
  Gets a single country.

  Raises `Ecto.NoResultsError` if the Country does not exist.

  ## Examples

      iex> get_country!(123)
      %Country{}

      iex> get_country!(456)
      ** (Ecto.NoResultsError)

  """
  def get_country!(country_code) do
    Repo.get_by!(Country, country_code: country_code)
  end

  @doc """
  Creates a country.

  ## Examples

      iex> create_country(%{field: value})
      {:ok, %Country{}}

      iex> create_country(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_country(attrs \\ %{}) do
    %Country{}
    |> Country.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a country.

  ## Examples

      iex> update_country(country, %{field: new_value})
      {:ok, %Country{}}

      iex> update_country(country, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_country(%Country{} = country, attrs) do
    country
    |> Country.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a country.

  ## Examples

      iex> delete_country(country)
      {:ok, %Country{}}

      iex> delete_country(country)
      {:error, %Ecto.Changeset{}}

  """
  def delete_country(%Country{} = country) do
    Repo.delete(country)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking country changes.

  ## Examples

      iex> change_country(country)
      %Ecto.Changeset{data: %Country{}}

  """
  def change_country(%Country{} = country, attrs \\ %{}) do
    Country.changeset(country, attrs)
  end

  def search_countries(query) when is_binary(query) and query != "" do
    query = "%#{query}%"
    from(c in Country,
      where: like(c.country_name, ^query) or like(c.country_code, ^query),
      order_by: c.country_name,
      limit: 5
    )
    |> Repo.all()
  end

  def search_countries(_), do: []

  alias Combobox.Territory.City

  @doc """
  Returns the list of cities.

  ## Examples

      iex> list_cities()
      [%City{}, ...]

  """
  def list_cities do
    # Repo.all(City)
    Repo.all(from c in City, limit: 100)
  end

  @doc """
  Gets a single city.

  Raises `Ecto.NoResultsError` if the City does not exist.

  ## Examples

      iex> get_city!(123)
      %City{}

      iex> get_city!(456)
      ** (Ecto.NoResultsError)

  """
  def get_city!(id), do: Repo.get!(City, id)

  @doc """
  Creates a city.

  ## Examples

      iex> create_city(%{field: value})
      {:ok, %City{}}

      iex> create_city(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_city(attrs \\ %{}) do
    %City{}
    |> City.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a city.

  ## Examples

      iex> update_city(city, %{field: new_value})
      {:ok, %City{}}

      iex> update_city(city, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_city(%City{} = city, attrs) do
    city
    |> City.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a city.

  ## Examples

      iex> delete_city(city)
      {:ok, %City{}}

      iex> delete_city(city)
      {:error, %Ecto.Changeset{}}

  """
  def delete_city(%City{} = city) do
    Repo.delete(city)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking city changes.

  ## Examples

      iex> change_city(city)
      %Ecto.Changeset{data: %City{}}

  """
  def change_city(%City{} = city, attrs \\ %{}) do
    City.changeset(city, attrs)
  end

  alias Combobox.Territory.State

  @doc """
  Returns the list of states.

  ## Examples

      iex> list_states()
      [%State{}, ...]

  """
  def list_states do
    # Repo.all(State)
    Repo.all(from c in State, limit: 100)
  end

  @doc """
  Gets a single state.

  Raises `Ecto.NoResultsError` if the State does not exist.

  ## Examples

      iex> get_state!(123)
      %State{}

      iex> get_state!(456)
      ** (Ecto.NoResultsError)

  """
  def get_state!(code) when is_binary(code) do
    Repo.get_by!(State, code: code)
  end

  @doc """
  Creates a state.

  ## Examples

      iex> create_state(%{field: value})
      {:ok, %State{}}

      iex> create_state(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_state(attrs \\ %{}) do
    %State{}
    |> State.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a state.

  ## Examples

      iex> update_state(state, %{field: new_value})
      {:ok, %State{}}

      iex> update_state(state, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_state(%State{} = state, attrs) do
    state
    |> State.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a state.

  ## Examples

      iex> delete_state(state)
      {:ok, %State{}}

      iex> delete_state(state)
      {:error, %Ecto.Changeset{}}

  """
  def delete_state(%State{} = state) do
    Repo.delete(state)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking state changes.

  ## Examples

      iex> change_state(state)
      %Ecto.Changeset{data: %State{}}

  """
  def change_state(%State{} = state, attrs \\ %{}) do
    State.changeset(state, attrs)
  end

  alias Combobox.Territory.TerritoryList

  @doc """
  Returns the list of territories_list.

  ## Examples

      iex> list_territories_list()
      [%TerritoryList{}, ...]

  """
  def list_territories_list do
    # Repo.all(from tl in TerritoryList, limit: 20)
    cities = Repo.all(from c in TerritoryList, where: c.category == "cities", limit: 20)
    states = Repo.all(from c in TerritoryList, where: c.category == "states", limit: 20)
    countries = Repo.all(from c in TerritoryList, where: c.category == "countries", limit: 20)
    cities ++ states ++ countries
  end


@doc """
  Gets a single territory_list.

  Raises `Ecto.NoResultsError` if the Territory list does not exist.

  ## Examples

      iex> get_territory_list!(123)
      %TerritoryList{}

      iex> get_territory_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_territory_list!(id), do: Repo.get!(TerritoryList, id)

  @doc """
  Creates a territory_list.

  ## Examples

      iex> create_territory_list(%{field: value})
      {:ok, %TerritoryList{}}

      iex> create_territory_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_territory_list(attrs \\ %{}) do
    %TerritoryList{}
    |> TerritoryList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a territory_list.

  ## Examples

      iex> update_territory_list(territory_list, %{field: new_value})
      {:ok, %TerritoryList{}}

      iex> update_territory_list(territory_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_territory_list(%TerritoryList{} = territory_list, attrs) do
    territory_list
    |> TerritoryList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a territory_list.

  ## Examples

      iex> delete_territory_list(territory_list)
      {:ok, %TerritoryList{}}

      iex> delete_territory_list(territory_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_territory_list(%TerritoryList{} = territory_list) do
    Repo.delete(territory_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking territory_list changes.

  ## Examples

      iex> change_territory_list(territory_list)
      %Ecto.Changeset{data: %TerritoryList{}}

  """
  def change_territory_list(%TerritoryList{} = territory_list, attrs \\ %{}) do
    TerritoryList.changeset(territory_list, attrs)
  end


  @doc """
  Searchs our territories based on a simple query.

  """
  def search_territories(q) when is_binary(q) and byte_size(q) > 0 do
    # Add wildcards for partial matching if the query doesn't end with *
    search_term = if String.ends_with?(q, "*"), do: q, else: "#{q}*"

    from(t in TerritoryList,
      select: %{
        name: t.name,
        code: t.code,
        category: t.category,
        # Calculate relevance score using bm25
        relevance: fragment("bm25(territories_list)")
      },
      where: fragment("territories_list MATCH ?", ^search_term),
      # Order first by relevance score, then by name for items with same relevance
      order_by: [
        asc: fragment("bm25(territories_list)"),
        asc: :name
      ],
      limit: 10
    )
    |> Repo.all()
  end
end
