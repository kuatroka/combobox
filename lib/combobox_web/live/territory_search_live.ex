defmodule ComboboxWeb.TerritorySearchLive do
  use ComboboxWeb, :live_view


  def mount(_params, _session, socket) do
    {:ok, assign(socket, modal_open: false, search_term: "")}
  end



  def render(assigns) do
    IO.puts("Rendering with modal_open: #{assigns.modal_open}, search_term: #{assigns.search_term}") # Debugging
    ~H"""

    <div>

    <.live_component
    module={ComboboxWeb.TerritoryLive.SearchComponent}
    id="search-results"
    show={true}
    on_cancel={%JS{}}
                      />
    </div>
    """
  end
end
