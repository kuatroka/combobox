# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Combobox.Repo.insert!(%Combobox.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Combobox.Repo
alias Combobox.Territory.TerritoryList

csv_path = "data/combined.csv"

# Delete all records from the 'territories_list' table
Repo.delete_all(TerritoryList)
Ecto.Adapters.SQL.query!(Combobox.Repo, "DELETE FROM sqlite_sequence WHERE name='territories_list'")

case File.read(csv_path) do
  {:ok, file} ->
    file
    |> String.split("\n", trim: true)
    |> Enum.drop(1) # Skip the header row
    |> Enum.each(fn row ->
      case String.split(row, ~r/,(?=(?:[^"]*"[^"]*")*[^"]*$)/, trim: true) do
        [_, code, name, category] ->
          territory_data = %{
            code: code,
            name: name,
            category: category
          }

          case TerritoryList.changeset(%TerritoryList{}, territory_data) |> Repo.insert() do
            {:ok, _} -> IO.puts("Search territory inserted successfully: #{name}")
            {:error, changeset} -> IO.puts("Error inserting search territory: #{inspect(changeset.errors)}")
          end

        _ ->
          IO.puts("Skipping malformed row: #{row}")
      end
    end)

    IO.puts("Data from combined.csv loaded into the search_territories table.")
  {:error, reason} ->
    IO.puts("Error reading combined.csv: #{inspect(reason)}")
end


#################
# csv_path_countries = "data/countries.csv" # Replace with the actual path to your countries.csv file

# Repo.delete_all(Country)
# Ecto.Adapters.SQL.query!(Combobox.Repo, "DELETE FROM sqlite_sequence WHERE name='countries'")

# case File.read(csv_path_countries) do
#   {:ok, file} ->
#     file
#     |> String.split("\n", trim: true)
#     |> Enum.drop(1) # Skip the header row
#     |> Enum.each(fn row ->
#       case String.split(row, ~r/,(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)/, trim: true) do
#         [country_id, country_code, country_name, iso3] ->
#           country_data = %{
#             country_id: String.to_integer(country_id),
#             country_code: country_code,
#             country_name: String.replace(country_name, ~r/^\"|\"$/, ""), # Remove double quotes
#             iso3: iso3
#           }

#           case Country.changeset(%Country{}, country_data)
#           |> Repo.insert() do
#             {:ok, _} -> IO.puts("Country inserted successfully: #{country_name}")
#             {:error, changeset} ->
#               IO.puts("Error inserting country: #{inspect(changeset.errors)}")
#           end
#         _ ->
#           IO.puts("Skipping malformed row: #{row}")
#       end
#     end)
#     IO.puts("Data from countries.csv loaded into the countries table.")
#   {:error, reason} ->
#     IO.puts("Error reading countries.csv: #{inspect(reason)}")
# end


# ... existing code ...

# alias Combobox.Territory.City

# csv_path_cities = "data/cities.csv" # Replace with the actual path to your cities.csv file

# # Delete all records from the 'cities' table
# Repo.delete_all(City)
# Ecto.Adapters.SQL.query!(Combobox.Repo, "DELETE FROM sqlite_sequence WHERE name='cities'")

# case File.read(csv_path_cities) do
#   {:ok, file} ->
#     file
#     |> String.split("\n", trim: true)
#     |> Enum.drop(1) # Skip the header row
#     |> Enum.each(fn row ->
#       case String.split(row, ~r/,(?=(?:[^"]*"[^"]*")*[^"]*$)/, trim: true) do
#         [city_id, city_name, country_code, state_code, latitude, longitude] ->
#           city_data = %{
#             city_id: String.to_integer(city_id),
#             city_name: String.replace(city_name, ~r/^\"|\"$/, ""), # Remove double quotes if present
#             country_code: country_code,
#             state_code: state_code,
#             latitude: latitude,
#             longitude: longitude
#           }

#           case City.changeset(%City{}, city_data)
#           |> Repo.insert() do
#             {:ok, _} -> IO.puts("City inserted successfully: #{city_name}")
#             {:error, changeset} ->
#               IO.puts("Error inserting city: #{inspect(changeset.errors)}")
#           end
#         _ ->
#           IO.puts("Skipping malformed row: #{row}")
#       end
#     end)
#     IO.puts("Data from cities.csv loaded into the cities table.")
#   {:error, reason} ->
#     IO.puts("Error reading cities.csv: #{inspect(reason)}")
# end


#############

# alias Combobox.Territory.State

# csv_path_states = "data/states.csv" # Replace with the actual path to your states.csv file

# # Delete all records from the 'states' table
# Repo.delete_all(State)
# Ecto.Adapters.SQL.query!(Combobox.Repo, "DELETE FROM sqlite_sequence WHERE name='states'")

# case File.read(csv_path_states) do
#   {:ok, file} ->
#     file
#     |> String.split("\n", trim: true)
#     |> Enum.drop(1) # Skip the header row
#     |> Enum.each(fn row ->
#       case String.split(row, ~r/,(?=(?:[^"]*"[^"]*")*[^"]*$)/, trim: true) do
#         [state_id, state_name, country_code, code] -> # Correct order
#           # Check if state_id is a valid integer
#           case Integer.parse(state_id) do
#             {parsed_state_id, ""} ->
#               state_data = %{
#                 code: code,
#                 state_id: parsed_state_id,
#                 state_name: String.replace(state_name, ~r/^\"|\"$/, ""),
#                 country_code: country_code
#               }

#               case State.changeset(%State{}, state_data)
#               |> Repo.insert() do
#                 {:ok, _} -> IO.puts("State inserted successfully: #{state_name}")
#                 {:error, changeset} ->
#                   IO.puts("Error inserting state: #{inspect(changeset.errors)}")
#               end
#             _ ->
#               IO.puts("Skipping row with invalid state_id: #{row}")
#           end
#         _ ->
#           IO.puts("Skipping malformed row: #{row}")
#       end
#     end)
#     IO.puts("Data from states.csv loaded into the states table.")
#   {:error, reason} ->
#     IO.puts("Error reading states.csv: #{inspect(reason)}")
# end
