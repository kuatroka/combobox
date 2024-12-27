defmodule ComboboxWeb.TerritorySearchModalComponent do
  use ComboboxWeb, :html

  def territory_search_modal(assigns) do
    ~H"""
    <div id="global-search-territory-searchbar-dialog" class="hidden" phx-mounted={@show_modal}>
      <div id="global-search-territory_searchbox_container" class="fixed inset-0 bg-black bg-opacity-50 z-50" phx-click={@close_modal}>
        <div class="flex items-center justify-center min-h-screen">
          <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6">
            <div class="flex items-center justify-between mb-4">
              <h3 class="text-lg font-semibold">Search Territories</h3>
              <button
                type="button"
                phx-click={@close_modal}
                class="text-gray-400 hover:text-gray-500 focus:outline-none"
              >
                <span class="sr-only">Close</span>
                <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>
            
            <form phx-change="change" phx-submit="change">
              <div class="relative">
                <input
                  type="text"
                  name="search[query]"
                  id="global-search-territory-search-input"
                  class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  placeholder="Search..."
                  autocomplete="off"
                  phx-keydown="handle_key"
                />
              </div>
            </form>

            <div class="mt-4 space-y-2 max-h-96 overflow-y-auto">
              <%= for {territory, index} <- Enum.with_index(@search_results) do %>
                <div
                  id={territory.code}
                  class={"p-2 rounded-lg cursor-pointer hover:bg-gray-100 #{if index == @selected_index, do: "bg-gray-100", else: "bg-white"}"}
                  phx-click="handle_key"
                  phx-value-key="Enter"
                >
                  <div class="flex items-center justify-between">
                    <div>
                      <p class="font-medium"><%= territory.name %></p>
                      <p class="text-sm text-gray-500"><%= territory.category %></p>
                    </div>
                  </div>
                </div>
              <% end %>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
