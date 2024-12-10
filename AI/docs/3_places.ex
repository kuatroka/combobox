defmodule Traveler.Places do
  import Ecto.Query, warn: false
  alias Traveler.Repo
  alias Traveler.Places.Place
  
  def search(search_query) do
    search_query = "%#{search_query}%"

    Place
    |> order_by(asc: :name)
    |> where([p], ilike(p.name, ^search_query))
    |> limit(5)
    |> Repo.all()
  end
end