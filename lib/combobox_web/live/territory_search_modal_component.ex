defmodule ComboboxWeb.TerritorySearchModalComponent do
  use ComboboxWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <.modal id="territory-search-modal">
        <div id="territory-search-component">
          <.header>
            Search Territories
            <:subtitle>Search for territories by name</:subtitle>
          </.header>

          <div class="mt-4">
            <input
              type="text"
              phx-target="territory-search-component"
              phx-keyup="search"
              placeholder="Search territories..."
              class="w-full p-2 border rounded-md"
              autocomplete="off"
            />

            <div class="search-results mt-2">
              <%= for territory <- @results do %>
                <div
                  phx-click="select_territory"
                  phx-value-link={Combobox.Territory.generate_link(territory)}
                  class="cursor-pointer hover:bg-gray-100 p-2 rounded-md"
                >
                  <%= territory.territory_name %>
                </div>
              <% end %>
            </div>
          </div>
        </div>
      </.modal>
    </div>
    """
  end

  def update(assigns, socket) do
    {:ok, 
      socket
      |> assign(assigns)
      |> assign(results: (if assigns[:search_term], do: Combobox.Territory.search(Combobox.Repo, assigns[:search_term]), else: []))
  end


  def handle_event("select_territory", %{"link" => link}, socket) do
    {:noreply, 
     socket
     |> push_navigate(to: "/#{link}")}
  end
end
