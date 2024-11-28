defmodule ComboboxWeb.TerritorySearchLive do
  use ComboboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-2xl">
      <h1 class="text-2xl font-bold mb-4">Search with modal</h1>

      <.modal id="territory-search-modal" show>
        <.live_component
          module={ComboboxWeb.TerritorySearchModalComponent}
          id="territory-search-component" />
        <div>
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
        </.live_component>
      </.modal>

      <button
        phx-click={JS.show(to: "#territory-search-modal")}
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
      >
        Search Territories
      </button>
    </div>
    """
  end
end
